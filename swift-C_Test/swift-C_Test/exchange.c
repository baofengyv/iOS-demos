//
//  exchange.c
//  swift-C_Test
//
//  Created by b on 16/5/19.
//  Copyright © 2016年 b. All rights reserved.

#include <stdio.h>

void exchange(int *a, int *b){
    int tmp = *a;
    *a = *b;
    *b = tmp;
}
