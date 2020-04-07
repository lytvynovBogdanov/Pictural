//
//  Synth.m
//  Swift Synth
//
//  Created by Oleksii Lytvynov-Bohdanov on 07.04.2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "Synth.h"

@implementation Synth

+ (instancetype)sharedInstance {
    static Synth *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Synth alloc] init];
    });
    return sharedInstance;
}

@end
