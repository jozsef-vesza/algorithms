//
//  SortTests.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 07/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "NSArray+SortingExamples.h"

@interface SortTests : XCTestCase

@property (nonatomic, copy) NSArray *forward;
@property (nonatomic, copy) NSArray *rewerse;

@end

@implementation SortTests

- (void)setUp {
    self.forward = @[@1, @2, @3, @4];
    self.rewerse = @[@4, @3, @2, @1];
}

- (void)testBubbleSort {
    NSArray *output = [NSArray bubbleSortArray:self.forward];
    XCTAssert([output isEqualToArray:self.rewerse]);
}

- (void)testSelectionSort {
    NSArray *output = [NSArray selectionSortArray:self.rewerse];
    XCTAssert([output isEqualToArray:self.forward]);
}

- (void)testInsertionSort {
    NSArray *output = [NSArray insertionSortArray:self.rewerse];
    XCTAssert([output isEqualToArray:self.forward]);
}

@end
