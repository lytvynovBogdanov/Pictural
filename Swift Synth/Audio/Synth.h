//
//  Synth.h
//  Swift Synth
//
//  Created by Oleksii Lytvynov-Bohdanov on 07.04.2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Oscillator.h"

NS_ASSUME_NONNULL_BEGIN

@interface Synth : NSObject

+ (instancetype)sharedInstance;

@property (atomic) float volume;

- (void)setWaveformToSignal:(Signal)signal;

@end

NS_ASSUME_NONNULL_END
