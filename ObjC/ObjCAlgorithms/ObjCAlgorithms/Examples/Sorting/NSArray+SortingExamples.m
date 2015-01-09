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
        
        for (NSUInteger i = 1; i < size; i++) {
            if (output[i - 1] < output[i]) {
                [output exchangeObjectAtIndex:i - 1 withObjectAtIndex:i];
                swapped = YES;
            }
        }
    }
    
    return output;
}

+ (instancetype)selectionSortArray:(NSArray *)input {
    
    NSUInteger minimum;
    NSUInteger size = [input count];
    NSMutableArray *output = [input mutableCopy];
    
    for (NSUInteger i = 0; i < size - 1; i++) {
        
        minimum = i;
        
        for (NSUInteger j = i + 1; j < size; j++) {
            
            if (output[j] < output[minimum]) {
                
                minimum = j;
            }
        }
        
        if (i != minimum) {
            [output exchangeObjectAtIndex:i withObjectAtIndex:minimum];
        }
    }
    
    return output;
}

+ (instancetype)insertionSortArray:(NSArray *)input {
    
    NSUInteger size = [input count];
    NSMutableArray *output = [input mutableCopy];
    NSUInteger i, j;
    
    for (i = 1; i < size; i++) {
        
        NSNumber *x = input[i];
        j = i;
        
        while (j > 0 && output[j - 1] > x) {
            
            output[j] = output[j - 1];
            j = j - 1;
        }
        
        output[j] = x;
    }
    
    return output;
}

@end
