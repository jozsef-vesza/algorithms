//
//  StackQueueTests.m
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

@interface StackQueueTests : XCTestCase

@end

@implementation StackQueueTests

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

@end
