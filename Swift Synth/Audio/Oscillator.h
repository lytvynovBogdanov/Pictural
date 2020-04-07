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
    kSine = 1,
    kTriangle = 2,
    kSawtooth = 3,
    kSquare = 4,
    kWhiteNoise = 5
};

@interface Oscillator : NSObject

@end

NS_ASSUME_NONNULL_END
