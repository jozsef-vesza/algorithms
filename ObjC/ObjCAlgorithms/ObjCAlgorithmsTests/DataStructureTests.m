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
#import "JVLRUCache.h"

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

- (void)testLRUCache {
    
    JVLRUCache *cache = [[JVLRUCache alloc] initWithCapacity:4];
    
    [cache setValue:@"1" forKey:@"first"];
    [cache setValue:@"2" forKey:@"second"];
    [cache setValue:@"3" forKey:@"third"];
    [cache setValue:@"4" forKey:@"fourth"];
    [cache setValue:@"5" forKey:@"fifth"];
    
    NSString *removedFirst = [cache getValueForKey:@"first"];
    
    XCTAssertNil(removedFirst);
    
    NSString *fifth = [cache getValueForKey:@"fifth"];
    
    XCTAssert([fifth isEqualToString:@"5"]);
}

@end
