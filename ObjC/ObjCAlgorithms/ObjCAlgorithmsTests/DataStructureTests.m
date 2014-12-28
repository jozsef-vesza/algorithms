//
//  DataStructureTests.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "JVPriorityQueue.h"

@interface DataStructureTests : XCTestCase

@end

@implementation DataStructureTests

- (void)testPriorityQueue {
    
    JVPriorityQueue *prioQueue = [[JVPriorityQueue alloc] init];
    
    [prioQueue insert:@2];
    [prioQueue insert:@1];
    [prioQueue insert:@4];
    [prioQueue insert:@3];
    
    NSArray *expected = @[@1, @2, @3, @4];
    
    for (int i = 0; i < [prioQueue count]; i++) {
        XCTAssertEqual(expected[i], [prioQueue dequeue]);
    }
}

@end
