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

- (void)testPathSum {
    
    JVTree *tree2= [[JVTree alloc] initWithValue:@5];
    tree2.left = [[JVTree alloc] initWithValue:@4];
    tree2.left.left = [[JVTree alloc] initWithValue:@11];
    tree2.left.left.left = [[JVTree alloc] initWithValue:@7];
    tree2.left.left.right = [[JVTree alloc] initWithValue:@2];
    tree2.right = [[JVTree alloc] initWithValue:@8];
    tree2.right.left = [[JVTree alloc] initWithValue:@13];
    tree2.right.right = [[JVTree alloc] initWithValue:@4];
    tree2.right.right.right = [[JVTree alloc] initWithValue:@1];
    
    XCTAssertTrue([JVTree tree:tree2 hasPathSum:22]);
}

- (void)testBalancedTreeConstruction {
    
    NSArray *input = @[@1, @2, @3, @4, @5, @6];
    NSArray *expected = @[@3, @1, @2, @5, @4, @6];
    
    JVTree *output = [JVTree createBalancedTreeFromArray:input];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [JVTree traverseTree:output withTraversalType:Preorder withAction:^(JVTree *next) {
        [result addObject:next.value];
    }];
    
    XCTAssert([result isEqualToArray:expected]);
}

- (void)testMinimumDepth {
    
    JVTree *tree1 = [[JVTree alloc] initWithValue:@5];
    
    [JVTree insertValue:@3 intoTree:tree1];
    
    [JVTree insertValue:@9 intoTree:tree1];
    [JVTree insertValue:@8 intoTree:tree1];
    [JVTree insertValue:@10 intoTree:tree1];
    
    int output = [JVTree findMinimumDepthInTree:tree1];
    int expected = 1;
    
    XCTAssertEqual(output, expected);
}

- (void)testMaxSum {
    
    JVTree *tree2= [[JVTree alloc] initWithValue:@5];
    tree2.left = [[JVTree alloc] initWithValue:@4];
    tree2.left.left = [[JVTree alloc] initWithValue:@11];
    tree2.left.right = [[JVTree alloc] initWithValue:@7];
    tree2.right = [[JVTree alloc] initWithValue:@8];
    tree2.right.left = [[JVTree alloc] initWithValue:@13];
    tree2.right.right = [[JVTree alloc] initWithValue:@4];
    
    int output = [JVTree findMaxPathSumInTree:tree2];
    int expected = 26;
    
    XCTAssertEqual(output, expected);
}

- (void)testHeightCheck {
    
    JVTree *inbalancedInput = [[JVTree alloc] initWithValue:@0];
    [JVTree insertValue:@1 intoTree:inbalancedInput];
    [JVTree insertValue:@2 intoTree:inbalancedInput];
    [JVTree insertValue:@3 intoTree:inbalancedInput];
    
    XCTAssertEqual(4, [JVTree getHeightOfTree:inbalancedInput]);
    
    JVTree *balancedInput = [[JVTree alloc] initWithValue:@5];
    [JVTree insertValue:@1 intoTree:balancedInput];
    [JVTree insertValue:@2 intoTree:balancedInput];
    [JVTree insertValue:@6 intoTree:balancedInput];
    
    XCTAssertEqual(3, [JVTree getHeightOfTree:balancedInput]);
    
}

- (void)testBalanced {
    
    JVTree *inbalancedInput = [[JVTree alloc] initWithValue:@0];
    [JVTree insertValue:@1 intoTree:inbalancedInput];
    [JVTree insertValue:@2 intoTree:inbalancedInput];
    [JVTree insertValue:@3 intoTree:inbalancedInput];
    
    XCTAssertFalse([JVTree isBalanced:inbalancedInput]);
    
    JVTree *balancedInput = [[JVTree alloc] initWithValue:@5];
    [JVTree insertValue:@1 intoTree:balancedInput];
    [JVTree insertValue:@2 intoTree:balancedInput];
    [JVTree insertValue:@6 intoTree:balancedInput];
    
    XCTAssertTrue([JVTree isBalanced:balancedInput]);
}

@end
