//
//  TreeTests.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 03/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "JVTree.h"

@interface TreeTests : XCTestCase

@property (nonatomic, strong) JVTree *tree;

@end

@implementation TreeTests

- (void)setUp {
    
    self.tree = [JVTree treeWithItem:@5];
    
    self.tree = [JVTree insertItem:@3 inTree:self.tree];
    self.tree = [JVTree insertItem:@4 inTree:self.tree];
    self.tree = [JVTree insertItem:@2 inTree:self.tree];
    self.tree = [JVTree insertItem:@1 inTree:self.tree];
    self.tree = [JVTree insertItem:@8 inTree:self.tree];
    self.tree = [JVTree insertItem:@7 inTree:self.tree];
    self.tree = [JVTree insertItem:@10 inTree:self.tree];
}

- (void)testInsertion {
    XCTAssertNotNil(self.tree);
}

- (void)testSearch {
    
    XCTAssertNotNil([JVTree findItem:@2 inTree:self.tree]);
    XCTAssertNil([JVTree findItem:@100 inTree:self.tree]);
}

@end
