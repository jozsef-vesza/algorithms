//
//  JVTree+Examples.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 04/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "JVTree+Examples.h"
#import "JVLinkedNode.h"

@implementation JVTree (Examples)

+ (BOOL)isBST:(JVTree *)tree {
    return [self isBST:tree min:INT_MIN max:INT_MAX];
}

+ (BOOL)isBST:(JVTree *)tree min:(int)min max:(int)max {
    
    if (tree == nil) {
        return YES;
    }
    
    if ([tree.value intValue] < min || [tree.value intValue] > max) {
        return NO;
    }
    
    return [self isBST:tree.left min:min max:[tree.value intValue]] && [self isBST:tree.right min:[tree.value intValue] max:max];
}

+ (JVLinkedNode *)flattenTree:(JVTree *)tree {
    
    JVLinkedNode *fakeHead = [[JVLinkedNode alloc] initWithValue:@0];
    __block JVLinkedNode *cursor = fakeHead;
    
    [JVTree traverseTree:tree withTraversalType:Inorder withAction:^(JVTree *next) {
        cursor.next = [[JVLinkedNode alloc] initWithValue:next.value];
        cursor = cursor.next;
    }];
    
    return fakeHead.next;
}

@end
