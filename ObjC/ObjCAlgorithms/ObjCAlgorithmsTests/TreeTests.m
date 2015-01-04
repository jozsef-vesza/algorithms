//
//  TreeTests.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 03/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "JVTree+Examples.h"
#import "JVLinkedNode.h"

@interface TreeTests : XCTestCase

@end

@implementation TreeTests

- (void)testTreeValidation {
    
    JVTree *tree1 = [[JVTree alloc] initWithValue:@5];
    
    [JVTree insertValue:@3 intoTree:tree1];
    [JVTree insertValue:@1 intoTree:tree1];
    [JVTree insertValue:@2 intoTree:tree1];
    
    [JVTree insertValue:@9 intoTree:tree1];
    [JVTree insertValue:@8 intoTree:tree1];
    [JVTree insertValue:@10 intoTree:tree1];
    
    XCTAssertTrue([JVTree isBST:tree1]);
    
    JVTree *tree2= [[JVTree alloc] initWithValue:@5];
    tree2.left = [[JVTree alloc] initWithValue:@6];
    tree2.right = [[JVTree alloc] initWithValue:@2];
    
    XCTAssertFalse([JVTree isBST:tree2]);
}

- (void)testTreeFlatten {
    
    JVTree *tree1 = [[JVTree alloc] initWithValue:@5];
    
    [JVTree insertValue:@3 intoTree:tree1];
    [JVTree insertValue:@1 intoTree:tree1];
    [JVTree insertValue:@2 intoTree:tree1];
    
    [JVTree insertValue:@9 intoTree:tree1];
    [JVTree insertValue:@8 intoTree:tree1];
    [JVTree insertValue:@10 intoTree:tree1];
    
    JVLinkedNode *output = [JVTree flattenTree:tree1];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *expected = @[@1, @2, @3, @5, @8, @9, @10];
    
    for (JVLinkedNode *cursor = output; cursor != nil; cursor = cursor.next) {
        [result addObject:cursor.value];
    }
    
    XCTAssert([expected isEqualToArray:result]);
}

@end
