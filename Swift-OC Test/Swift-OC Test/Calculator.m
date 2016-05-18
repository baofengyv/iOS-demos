//
//  Calculator.m
//  Swift-OC Test
//
//  Created by b on 16/5/18.
//  Copyright © 2016年 b. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "Calculator.h"

@implementation Calculator

@synthesize first;

-(id) init {
    if (self = [super init]){
        self.first = 1;
    }
    return self;
}

-(int) add {
    return self.first + 99;
}

@end

