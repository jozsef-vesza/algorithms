//
//  JVTree.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 25/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Preorder,
    Inorder,
    Postorder,
} JVTreeTraversalMode;

@interface JVTree : NSObject

+ (instancetype)treeWithItem:(id)item;
+ (JVTree *)insertItem:(id)item inTree:(JVTree *)tree;
+ (JVTree *)findItem:(id)item inTree:(JVTree *)tree;
+ (JVTree *)minimumInTree:(JVTree *)tree;
+ (JVTree *)maximumInTree:(JVTree *)tree;
+ (void)traverseTree:(JVTree *)tree inOrder:(JVTreeTraversalMode)mode withAction:(void (^)(JVTree *current))action;

@end
