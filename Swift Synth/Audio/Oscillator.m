//
//  Oscillator.m
//  Swift Synth
//
//  Created by Oleksii Lytvynov-Bohdanov on 07.04.2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "Oscillator.h"

@implementation Oscillator

static float amplitude = 1.0f;
+ (int)amplitude {
    @synchronized(self) {
        return amplitude;
    }
}
+ (void)setAmplitude:(int)value {
    @synchronized(self) {
        amplitude = value;
    }
}

static float frequency = 440.0f;
+ (int)frequency {
    @synchronized(self) {
        return frequency;
    }
}
+ (void)setFrequency:(int)value {
    @synchronized(self) {
        frequency = value;
    }
}

+ (Signal)sine {
    return ^(float time) {
        return Oscillator.amplitude * (float)sin(2.0 * M_PI * Oscillator.frequency * time);
    };
}

+ (Signal)triangle {
    return ^(float time) {
        double period = 1.0 / Oscillator.frequency;
        double currentTime = fmod(time, period);
        double value = currentTime / period;
        double result = 0.0;
        if (value < 0.25) {
            result = value * 4;
        } else if (value < 0.75) {
            result = 2.0 - (value * 4.0);
        } else {
            result = (value * 4) - 4.0;
        }
        return Oscillator.amplitude * (float)result;
    };
}

+ (Signal)sawtooth {
    return ^(float time) {
        double period = 1.0 / Oscillator.frequency;
        double currentTime = fmod(time, period);
        return Oscillator.amplitude * (float)((currentTime / period) * 2 - 1.0);
    };
}

+ (Signal)square {
    return ^(float time) {
        double period = 1.0 / Oscillator.frequency;
        double currentTime = fmod(time, period);

        return ((currentTime / period) < 0.5) ? Oscillator.amplitude : (float)(-1.0 * Oscillator.amplitude);
    };
}

+ (Signal)whiteNoise {
    return ^(float time) {
        return Oscillator.amplitude * (float)((arc4random() % 2) - 1);
    };
}

@end
