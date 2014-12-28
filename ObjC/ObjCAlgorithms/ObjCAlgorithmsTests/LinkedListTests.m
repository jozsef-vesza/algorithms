//
//  LinkedListTests.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 25/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "JVLinkedNode+Examples.h"

@interface LinkedListTests : XCTestCase

@end

@implementation LinkedListTests

- (void)testAddition {
    
    JVLinkedNode *num1 = [[JVLinkedNode alloc] initWithValue:@2];
    num1.next = [[JVLinkedNode alloc] initWithValue:@4];
    num1.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    
    JVLinkedNode *num2 = [[JVLinkedNode alloc] initWithValue:@5];
    num2.next = [[JVLinkedNode alloc] initWithValue:@6];
    num2.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *result = [[JVLinkedNode alloc] initWithValue:@7];
    result.next = [[JVLinkedNode alloc] initWithValue:@0];
    result.next.next = [[JVLinkedNode alloc] initWithValue:@8];
    
    JVLinkedNode *actualResult = [JVLinkedNode addNumber:num1 toNumber:num2];
    
    for (JVLinkedNode *v1 = result, *v2 = actualResult;
         v1 != nil || v2 != nil;
         v1 = v1.next, v2 = v2.next) {
        
        XCTAssertEqual(v1.value, v2.value);
    }
    
}

- (void)testReversal {

    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@1];
    n1.next = [[JVLinkedNode alloc] initWithValue:@2];
    n1.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n1.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *r1 = [[JVLinkedNode alloc] initWithValue:@4];
    r1.next = [[JVLinkedNode alloc] initWithValue:@3];
    r1.next.next = [[JVLinkedNode alloc] initWithValue:@2];
    r1.next.next.next = [[JVLinkedNode alloc] initWithValue:@1];
    
    for (JVLinkedNode *i1 = r1, *i2 = [JVLinkedNode reverseOrder:n1];
         i1 != nil || i2 != nil;
         i1 = i1.next, i2 = i2.next) {
        
        XCTAssertEqual(i1.value, i2.value);
    }
}

- (void)testReorder {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@1];
    n1.next = [[JVLinkedNode alloc] initWithValue:@2];
    n1.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n1.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *r1 = [[JVLinkedNode alloc] initWithValue:@1];
    r1.next = [[JVLinkedNode alloc] initWithValue:@4];
    r1.next.next = [[JVLinkedNode alloc] initWithValue:@2];
    r1.next.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    
    for (JVLinkedNode *i1 = r1, *i2 = [JVLinkedNode reorderList:n1];
         i1 != nil || i2 != nil;
         i1 = i1.next, i2 = i2.next) {
        
        XCTAssertEqual(i1.value, i2.value);
    }
}

- (void)testListSplit {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@1];
    n1.next = [[JVLinkedNode alloc] initWithValue:@2];
    n1.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n1.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *front;
    JVLinkedNode *back;
    
    [JVLinkedNode splitLinkedList:n1 intoFront:&front andBack:&back];
    
    XCTAssertEqual(front.value, @1);
    XCTAssertEqual(back.value, @3);
}

- (void)testListMerge {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@1];
    n1.next = [[JVLinkedNode alloc] initWithValue:@2];
    
    JVLinkedNode *n2 = [[JVLinkedNode alloc] initWithValue:@3];
    n2.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *merged = [JVLinkedNode mergeList:n1 withSecondList:n2];
    
    XCTAssertEqual(merged.value, @1);
    XCTAssertEqual(merged.next.value, @3);
}

- (void)testCycle {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@1];
    n1.next = [[JVLinkedNode alloc] initWithValue:@2];
    n1.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n1.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    XCTAssertFalse([JVLinkedNode listHasCycle:n1]);
    
    JVLinkedNode *n2 = [[JVLinkedNode alloc] initWithValue:@1];
    n2.next = [[JVLinkedNode alloc] initWithValue:@2];
    n2.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n2.next.next.next = n2;
    
    XCTAssertTrue([JVLinkedNode listHasCycle:n2]);
}

- (void)testTwoListMerge {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@5];
    n1.next = [[JVLinkedNode alloc] initWithValue:@6];
    n1.next.next = [[JVLinkedNode alloc] initWithValue:@7];
    n1.next.next.next = [[JVLinkedNode alloc] initWithValue:@8];
    
    JVLinkedNode *n2 = [[JVLinkedNode alloc] initWithValue:@1];
    n2.next = [[JVLinkedNode alloc] initWithValue:@2];
    n2.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n2.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *expected = [[JVLinkedNode alloc] initWithValue:@1];
    expected.next = [[JVLinkedNode alloc] initWithValue:@2];
    expected.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    expected.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    expected.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@5];
    expected.next.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@6];
    expected.next.next.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@7];
    expected.next.next.next.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@8];
    
    JVLinkedNode *merged = [JVLinkedNode mergeList:n1 withList:n2];
    
    
    for (
         JVLinkedNode *r1 = expected, *r2 = merged;
         r1 != nil || r2 != nil;
         r1 = r1.next, r2 = r2.next) {
        
        XCTAssertEqual(r1.value, r2.value);
    }
}

- (void)testNListMerge {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@5];
    n1.next = [[JVLinkedNode alloc] initWithValue:@6];
    n1.next.next = [[JVLinkedNode alloc] initWithValue:@7];
    n1.next.next.next = [[JVLinkedNode alloc] initWithValue:@8];
    
    JVLinkedNode *n2 = [[JVLinkedNode alloc] initWithValue:@1];
    n2.next = [[JVLinkedNode alloc] initWithValue:@2];
    n2.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n2.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *expected = [[JVLinkedNode alloc] initWithValue:@1];
    expected.next = [[JVLinkedNode alloc] initWithValue:@2];
    expected.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    expected.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    expected.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@5];
    expected.next.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@6];
    expected.next.next.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@7];
    expected.next.next.next.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@8];
    
    NSArray *input = @[n1, n2];
    
    JVLinkedNode *output = [JVLinkedNode mergeLists:input];
    for (
         JVLinkedNode *r1 = expected, *r2 = output;
         r1 != nil || r2 != nil;
         r1 = r1.next, r2 = r2.next) {
        
        XCTAssertEqual(r1.value, r2.value);
    }
}

- (void)testDuplicateRemoval {
    
    JVLinkedNode *input = [[JVLinkedNode alloc] initWithValue:@1];
    input.next = [[JVLinkedNode alloc] initWithValue:@1];
    input.next.next = [[JVLinkedNode alloc] initWithValue:@2];
    input.next.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    input.next.next.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    
    JVLinkedNode *expected = [[JVLinkedNode alloc] initWithValue:@1];
    expected.next = [[JVLinkedNode alloc] initWithValue:@2];
    expected.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    
    JVLinkedNode *output = [JVLinkedNode removeDuplicates:input];
    
    for (
         JVLinkedNode *r1 = expected, *r2 = output;
         r1 != nil || r2 != nil;
         r1 = r1.next, r2 = r2.next) {
        
        XCTAssertEqual(r1.value, r2.value);
    }
}

@end
