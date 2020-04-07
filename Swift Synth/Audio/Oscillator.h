//
//  Oscillator.h
//  Swift Synth
//
//  Created by Oleksii Lytvynov-Bohdanov on 07.04.2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Waveform) {
    sine = 0,
    triangle = 1,
    sawtooth = 2,
    square = 3,
    whiteNoise = 4
};

typedef float (^Signal) (float signal);

@interface Oscillator : NSObject

@property (class) float amplitude;
@property (class) float frequency;

@property (class, readonly) Signal sine;
@property (class, readonly) Signal triangle;
@property (class, readonly) Signal sawtooth;
@property (class, readonly) Signal square;
@property (class, readonly) Signal whiteNoise;

@end

NS_ASSUME_NONNULL_END
