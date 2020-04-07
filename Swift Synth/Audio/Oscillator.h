//
//  Oscillator.h
//  Swift Synth
//
//  Created by Oleksii Lytvynov-Bohdanov on 07.04.2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, Waveform) {
    sine = 1,
    triangle = 2,
    sawtooth = 3,
    square = 4,
    whiteNoise = 5
};

typedef float (^Signal) (float signal);

@interface Oscillator : NSObject

@end

NS_ASSUME_NONNULL_END
