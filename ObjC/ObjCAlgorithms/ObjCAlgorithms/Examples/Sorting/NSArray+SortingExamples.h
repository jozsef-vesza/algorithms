//
//  NSArray+SortingExamples.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 07/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SortingExamples)

+ (instancetype)bubbleSortArray:(NSArray *)input;
+ (instancetype)selectionSortArray:(NSArray *)input;
+ (instancetype)insertionSortArray:(NSArray *)input;
+ (instancetype)quickSortArray:(NSArray *)input;

@end
