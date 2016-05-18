//
//  Calculator.h
//  Swift-OC Test
//
//  Created by b on 16/5/18.
//  Copyright © 2016年 b. All rights reserved.
//

#ifndef Calculator_h
#define Calculator_h
#import <Foundation/Foundation.h>

@interface Calculator : NSObject
@property (nonatomic ,assign) int first;

-(id) init;


-(int) add;
@end

#endif /* Calculator_h */
