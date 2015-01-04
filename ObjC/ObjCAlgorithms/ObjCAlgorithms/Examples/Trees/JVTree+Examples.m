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

+ (BOOL)tree:(JVTree *)root hasPathSum:(int)sum {
    
    if (root == nil) {
        return NO;
    }
    
    if ([root.value intValue] == sum && root.left == nil && root.right == nil) {
        return YES;
    }
    
    return [self tree:root.left hasPathSum:sum - [root.value intValue]] || [self tree:root.right hasPathSum:sum - [root.value intValue]];
}

+ (JVTree *)createBalancedTreeFromArray:(NSArray *)array {
    
    return [self createTreeFromArray:array start:0 end:(int)[array count] - 1];
}

+ (JVTree *)createTreeFromArray:(NSArray *)array start:(int)start end:(int)end {

    if (start > end) {
        return nil;
    }
    
    int mid = (start + end) / 2;
    
    JVTree *root = [[JVTree alloc] initWithValue:array[mid]];
    root.left = [self createTreeFromArray:array start:start end:mid - 1];
    root.right = [self createTreeFromArray:array start:mid + 1 end:end];
    
    return root;
}

+ (int)findMinimumDepthInTree:(JVTree *)tree {
    
    return [self findMinimumDepthInTree:tree minDepth:INT_MAX depth:0];
}

+ (int)findMinimumDepthInTree:(JVTree *)tree minDepth:(int)minDepth depth:(int)depth {
    
    if (tree.right == nil && tree.left == nil) {
        
        if (depth < minDepth) {
            minDepth = depth;
        }
        
    } else {
        
        depth++;
        
        minDepth = MIN(
                       [self findMinimumDepthInTree:tree.left minDepth:minDepth depth:depth],
                       [self findMinimumDepthInTree:tree.right minDepth:minDepth depth:depth]
                       );
    }
    
    return minDepth;
}

+ (int)findMaxPathSumInTree:(JVTree *)tree {
    
    return [self findMaxPathSumInTree:tree withCurrentSum:0 withMax:0];
}

+ (int)findMaxPathSumInTree:(JVTree *)tree withCurrentSum:(int)currentSum withMax:(int)maxSum {
    
    currentSum += [tree.value intValue];
    
    if (currentSum > maxSum) {
        maxSum = currentSum;
    }
    
    if (tree.left == nil && tree.right == nil) {
        
        return maxSum;
        
    } else {
        
        JVTree *nextTree = tree.left.value > tree.right.value ? tree.left : tree.right;
        return [self findMaxPathSumInTree:nextTree withCurrentSum:currentSum withMax:maxSum];
    }
}

+ (BOOL)isBalanced:(JVTree *)tree {
    
    return ABS([self getHeightOfTree:tree.left] - [self getHeightOfTree:tree.right]) <= 1;
}

+ (int)getHeightOfTree:(JVTree *)root {
    
    if (root == nil) {
        return 0;
    }
    
    int height = 0;
    
    if (root.left != nil || root.right != nil) {
        height += MAX([self getHeightOfTree:root.left], [self getHeightOfTree:root.right]) + 1;
    }
    
    return height;
}

@end
