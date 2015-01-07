//
//  NSArray+SortingExamples.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 07/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "NSArray+SortingExamples.h"

@implementation NSArray (SortingExamples)

+ (instancetype)bubbleSortArray:(NSArray *)input {
    
    NSUInteger size = [input count];
    NSMutableArray *output = [input mutableCopy];
    BOOL swapped = YES;
    
    while (swapped) {
        
        swapped = NO;
        
        for (int i = 1; i < size; i++) {
            if (output[i - 1] < output[i]) {
                [output exchangeObjectAtIndex:i - 1 withObjectAtIndex:i];
                swapped = YES;
            }
        }
    }
    
    return output;
}

@end
