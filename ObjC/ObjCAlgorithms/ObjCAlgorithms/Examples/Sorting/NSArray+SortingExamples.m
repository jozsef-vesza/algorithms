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

+ (instancetype)quickSortArray:(NSArray *)input {
    
    NSUInteger count = [input count];
    
    if (count < 1) {
        return nil;
    }
    
    NSMutableArray *unsortedInput = [input mutableCopy];
    NSMutableArray *output = [[NSMutableArray alloc] init];
    
    NSMutableArray *less = [[NSMutableArray alloc] init];
    NSMutableArray *greater = [[NSMutableArray alloc] init];
    
    NSUInteger randomPivotPoint = arc4random() % [input count];
    NSNumber *pivotValue = unsortedInput[randomPivotPoint];
    
    [unsortedInput removeObjectAtIndex:randomPivotPoint];
    for (NSNumber *number in unsortedInput) {
        
        if ([number compare:pivotValue] == NSOrderedAscending) {
            
            [less addObject:number];
            
        } else {
            
            [greater addObject:number];
        }
    }
    
    [output addObjectsFromArray:[self quickSortArray:less]];
    [output addObject:pivotValue];
    [output addObjectsFromArray:[self quickSortArray:greater]];
    
    return output;
}

+ (instancetype)mergeSortArray:(NSArray *)input {
    
    NSUInteger count = [input count];
    
    if ([input count] < 2) {
        return input;
    }
    
    NSMutableArray *left = [[NSMutableArray alloc] init];
    NSMutableArray *right = [[NSMutableArray alloc] init];
    NSUInteger middle = count / 2;
    
    for (NSUInteger i = 0; i < middle; i++) {
        [left addObject:input[i]];
    }
    
    for (NSUInteger i = middle; i < count; i++) {
        [right addObject:input[i]];
    }
    
    left = [self mergeSortArray:left];
    right = [self mergeSortArray:right];
    
    return [self mergeArray:left into:right];
}

+ (instancetype)mergeArray:(NSArray *)left into:(NSArray *)right {
    
    NSMutableArray *mergedResult = [[NSMutableArray alloc] init];
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = 0;
    NSUInteger leftSize = [left count];
    NSUInteger rightSize = [right count];
    
    while (leftIndex < leftSize && rightIndex < rightSize) {
        
        if ([left[leftIndex] compare:right[rightIndex]] == NSOrderedAscending) {
            
            [mergedResult addObject:left[leftIndex++]];
            
        } else {
            
            [mergedResult addObject:right[rightIndex++]];
        }
    }
    
    NSRange leftRange = NSMakeRange(leftIndex, leftSize - leftIndex);
    NSRange rightRange = NSMakeRange(rightIndex, rightSize - rightIndex);
    
    [mergedResult addObjectsFromArray:[left subarrayWithRange:leftRange]];
    [mergedResult addObjectsFromArray:[right subarrayWithRange:rightRange]];
    
    return mergedResult;
}

@end
