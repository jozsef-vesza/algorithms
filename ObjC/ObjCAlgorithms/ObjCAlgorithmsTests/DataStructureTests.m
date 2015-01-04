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
#import "JVLinkedList.h"
#import "JVLinkedNode.h"
#import "JVStack.h"
#import "JVQueue.h"
#import "JVTree.h"
#import "NSArray+MapFilterReduce.h"

@interface DataStructureTests : XCTestCase

@end

@implementation DataStructureTests

- (void)testLinkedLists {
    
    JVLinkedList *list = [[JVLinkedList alloc] init];
    JVLinkedNode *prev;
    
    for (int i = 0; i < 10; i++) {
        prev = [list insertValue:@(i) afterNode:prev];
    }
    
    XCTAssertEqual(0, [[list head].value intValue]);
    
    JVLinkedNode *removedSecond = [list removeAfterNode:[list head]];
    
    XCTAssertEqual(1, [removedSecond.value intValue]);
    XCTAssertEqual(2, [[list head].next.value intValue]);
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
    NSArray *output = [input map:^id(id next) {
        return @([next intValue] + 1);
    }];
    
    for (int i = 0; i < [expected count]; i++) {
        XCTAssertEqual([expected[i] intValue], [output[i] intValue]);
    }
}

- (void)testFilter {

    NSArray *input = @[@1, @2, @3];
    NSArray *expected = @[@2];
    NSArray *output = [input filter:^BOOL(id next) {
        return [next intValue] % 2 == 0;
    }];
    
    for (int i = 0; i < [expected count]; i++) {
        XCTAssertEqual([expected[i] intValue], [output[i] intValue]);
    }
}

- (void)testReduce {
    
    NSArray *input = @[@1, @2, @3];
    int expected = 6;
    int output = [[input reduce:^id(id reduced, id next) {
        return @([reduced intValue] + [next intValue]);
    }] intValue];
    
    XCTAssertEqual(expected, output);
}

- (void)testTree {
    
    JVTree *tree = [[JVTree alloc] initWithValue:@5];
    
    [JVTree insertValue:@3 intoTree:tree];
    [JVTree insertValue:@1 intoTree:tree];
    [JVTree insertValue:@2 intoTree:tree];
    
    [JVTree insertValue:@9 intoTree:tree];
    [JVTree insertValue:@8 intoTree:tree];
    [JVTree insertValue:@10 intoTree:tree];
    
    NSLog(@"Preorder: \n");
    [JVTree traverseTree:tree withTraversalType:Preorder withAction:^(JVTree *tree) {
        NSLog(@"%@", tree.value);
    }];
    
    NSLog(@"Inorder: \n");
    [JVTree traverseTree:tree withTraversalType:Inorder withAction:^(JVTree *tree) {
        NSLog(@"%@", tree.value);
    }];
    
    NSLog(@"Postorder: \n");
    [JVTree traverseTree:tree withTraversalType:Postorder withAction:^(JVTree *tree) {
        NSLog(@"%@", tree.value);
    }];
    
    NSLog(@"fin");
}

@end
