//
//  LinkedListTests.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 25/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "JVLinkedNode.h"
#import "JVLinkedList.h"
#import "JVAddition.h"
#import "JVReverseOrder.h"
#import "JVDetectCycle.h"

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
    
    JVLinkedNode *actualResult = [JVAddition addNumber:num1 toNumber:num2];
    
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
    
    for (JVLinkedNode *i1 = r1, *i2 = [JVReverseOrder reverseOrder:n1];
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
    
    for (JVLinkedNode *i1 = r1, *i2 = [JVReverseOrder reorderList:n1];
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
    
    [JVReverseOrder splitLinkedList:n1 intoFront:&front andBack:&back];
    
    XCTAssertEqual(front.value, @1);
    XCTAssertEqual(back.value, @3);
}

- (void)testListMerge {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@1];
    n1.next = [[JVLinkedNode alloc] initWithValue:@2];
    
    JVLinkedNode *n2 = [[JVLinkedNode alloc] initWithValue:@3];
    n2.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    JVLinkedNode *merged = [JVReverseOrder mergeList:n1 withList:n2];
    
    XCTAssertEqual(merged.value, @1);
    XCTAssertEqual(merged.next.value, @3);
}

- (void)testCycle {
    
    JVLinkedNode *n1 = [[JVLinkedNode alloc] initWithValue:@1];
    n1.next = [[JVLinkedNode alloc] initWithValue:@2];
    n1.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n1.next.next.next = [[JVLinkedNode alloc] initWithValue:@4];
    
    XCTAssertFalse([JVDetectCycle listHasCycle:n1]);
    
    JVLinkedNode *n2 = [[JVLinkedNode alloc] initWithValue:@1];
    n2.next = [[JVLinkedNode alloc] initWithValue:@2];
    n2.next.next = [[JVLinkedNode alloc] initWithValue:@3];
    n2.next.next.next = n2;
    
    XCTAssertTrue([JVDetectCycle listHasCycle:n2]);
}

@end
