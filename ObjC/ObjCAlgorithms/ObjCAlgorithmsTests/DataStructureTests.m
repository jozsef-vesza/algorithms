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
#import "JVLinkedNode.h"
#import "JVStack.h"
#import "JVQueue.h"
#import "JVHashTable.h"
#import "NSArray+MapFilterReduce.h"

@interface DataStructureTests : XCTestCase

@end

@implementation DataStructureTests

- (void)testLinkedLists {
    
    JVLinkedNode *head = [[JVLinkedNode alloc] initWithValue:@10];

    for (int i = 9; i > -1; i--) {
        head = [JVLinkedNode insertValue:@(i) inList:head];
    }
    
    XCTAssertNotNil([JVLinkedNode findValue:@3 inList:head]);
    XCTAssertNil([JVLinkedNode findValue:@20 inList:head]);
    XCTAssertEqual(@4, [JVLinkedNode findValue:@4 inList:head].value);
    
    JVLinkedNode *minusFour = [JVLinkedNode deleteValue:@4 fromList:head];
    XCTAssertNotNil(minusFour);
    XCTAssertNil([JVLinkedNode findValue:@4 inList:minusFour]);
    
    JVLinkedNode *minusHead = [JVLinkedNode deleteValue:@0 fromList:minusFour];
    XCTAssertEqual(@1, minusHead.value);
    XCTAssertEqual(@2, minusHead.next.value);
    
}

- (void)testStacks {
    
    JVStack *stack = [[JVStack alloc] init];
    
    [stack push:@1];
    [stack push:@2];
    
    id poppedTwo = [stack pop];
    XCTAssertEqual(@2, poppedTwo);
    
    [stack push:@3];
    
    while (![stack isEmpty]) {
        [stack pop];
    }
    
    XCTAssertTrue([stack isEmpty]);
}

- (void)testQueues {
    
    JVQueue *queue = [[JVQueue alloc] init];
    
    [queue enqueue:@1];
    [queue enqueue:@2];
    
    id dequeuedTwo = [queue dequeue];
    XCTAssertEqual(@1, dequeuedTwo);
}


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

- (void)testMap {
    
    NSArray *input = @[@1, @2, @3];
    NSArray *expected = @[@2, @3, @4];
    NSArray *output = [input jv_map:^id(id next) {
        return @([next intValue] + 1);
    }];
    
    for (int i = 0; i < [expected count]; i++) {
        XCTAssertEqual([expected[i] intValue], [output[i] intValue]);
    }
}

- (void)testFilter {

    NSArray *input = @[@1, @2, @3];
    NSArray *expected = @[@2];
    NSArray *output = [input jv_filter:^BOOL(id next) {
        return [next intValue] % 2 == 0;
    }];
    
    for (int i = 0; i < [expected count]; i++) {
        XCTAssertEqual([expected[i] intValue], [output[i] intValue]);
    }
}

- (void)testReduce {
    
    NSArray *input = @[@1, @2, @3];
    int expected = 6;
    int output = [[input jv_reduce:@0 withBlock:^id(id reduced, id next) {
        return @([reduced intValue] + [next intValue]);
    }] intValue];
    
    XCTAssertEqual(expected, output);
    
    NSArray *input2 = @[@"a", @"b", @"c"];
    NSString *expected2 = @"abc";
    NSString *output2 = [input2 jv_reduce:@"" withBlock:^id(id reduced, id next) {
        return [NSString stringWithFormat:@"%@%@", reduced, next];
    }];
    
    XCTAssert([expected2 isEqualToString:output2]);
}

- (void)testTree {
    
}

- (void)testHashMap {
    
    NSString *input = @"Test string";
    JVHashTable *hashTable = [[JVHashTable alloc] init];
    [hashTable addItem:input];
    id output = [hashTable findItem:input];
    
    XCTAssertEqual(output, input);
}

@end
