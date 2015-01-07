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

@end

@implementation SortTests

- (void)testBubbleSort {
    
    NSArray *input = @[@1, @2, @3, @4];
    NSArray *expected = @[@4, @3, @2, @1];
    NSArray *output = [NSArray bubbleSortArray:input];
    
    XCTAssert([output isEqualToArray:expected]);
}

@end
