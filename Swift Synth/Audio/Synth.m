//
//  Synth.m
//  Swift Synth
//
//  Created by Oleksii Lytvynov-Bohdanov on 07.04.2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

#import "Synth.h"
#import "Weakinstance.h"

@interface Synth()

@property (strong, nonatomic) AVAudioEngine *audioEngine;
@property (strong, nonatomic) AVAudioSourceNode *sourceNode;

@property (nonatomic) float time;
@property (nonatomic) double sampleRate;
@property (nonatomic) float deltaTime;
@property (strong, nonatomic) Signal signal;

@end

@implementation Synth

+ (instancetype)sharedInstance {
    static Synth *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Synth alloc] init];
    });
    return sharedInstance;
}

- (AVAudioSourceNode *)sourceNode {
    if (_sourceNode == nil) {
        weakify(self)
        _sourceNode = [[AVAudioSourceNode alloc] initWithRenderBlock:^OSStatus(BOOL * _Nonnull isSilence, const AudioTimeStamp * _Nonnull timestamp, AVAudioFrameCount frameCount, AudioBufferList * _Nonnull outputData) {
            strongify(self)
            
            for (NSInteger i = 0; i < frameCount; i++) {
                float tempSignal = self.signal(self.time);
                self.time += self.deltaTime;
                
                for (NSInteger nBuffer = 0; i < outputData->mNumberBuffers; i++) {
                    Float32 *buffer = (Float32 *)outputData->mBuffers[nBuffer].mData;
                    buffer[i] = tempSignal;
                }
            }
            return noErr;
        }];
    }
    return _sourceNode;
}

- (void)setVolume:(float)volume {
    self.audioEngine.mainMixerNode.outputVolume = volume;
}

- (float)volume {
    return self.audioEngine.mainMixerNode.outputVolume;
}

- (void)initWithSignal:(Signal)signal {
    if (signal == nil) {
        // TODO: default value
        //Signal = Oscillator.sine
    }

    AVAudioEngine *audioEngine = [[AVAudioEngine alloc] init];
    AVAudioMixerNode *mainMixer = self.audioEngine.mainMixerNode;
    AVAudioOutputNode *outputNode = self.audioEngine.outputNode;
    AVAudioFormat *format = [outputNode inputFormatForBus:0];
    
    self.sampleRate = format.sampleRate;
    self.deltaTime = 1 / self.sampleRate;
    self.signal = signal;
    
    AVAudioFormat *inputFormat =
    [[AVAudioFormat alloc] initWithCommonFormat:format.commonFormat
                                     sampleRate:self.sampleRate channels:1
                                    interleaved:format.isInterleaved];
    
    [audioEngine attachNode:self.sourceNode];
    [audioEngine connect:self.sourceNode to:mainMixer format:inputFormat];
    [audioEngine connect:mainMixer to:outputNode format:nil];
    mainMixer.outputVolume = 0;
    
    NSError *error;
    @try {
        [audioEngine startAndReturnError:&error];
    } @catch (NSException* e) {
        NSLog(@"Could not start audioEngine: %@", error.localizedDescription);
    }
}

- (void)setWaveformToSignal:(Signal)signal {
    self.signal = signal;
}

@end
