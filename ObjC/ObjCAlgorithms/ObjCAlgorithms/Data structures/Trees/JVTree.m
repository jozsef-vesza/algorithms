//
//  JVTree.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 03/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "JVTree.h"

@implementation JVTree

- (instancetype)initWithValue:(id)value {
    
    self = [super init];
    
    if (self) {
        self.value = value;
    }
    
    return self;
}

+ (instancetype)insertValue:(id)newValue intoTree:(JVTree *)tree {
    
    if ([newValue isEqual:tree.value]) {
        return tree;
    }
    
    JVTree *newTree = [[JVTree alloc] initWithValue:newValue];
    
    if (newValue < tree.value) {
        
        if (tree.left != nil) {
            tree.left = [self insertValue:newValue intoTree:tree.left];
        } else {
            tree.left = newTree;
        }
    } else {
        
        if (tree.right != nil) {
            tree.right = [self insertValue:newValue intoTree:tree.right];
        } else {
            tree.right = newTree;
        }
    }
    
    return tree;
}

+ (void)traverseTree:(JVTree *)tree withTraversalType:(TreeTraversalType)traversalType withAction:(void (^)(JVTree *))action {
    
    switch (traversalType) {
            
        case Preorder:
            [self preorderTraverseTree:tree withAction:action];
            break;
        case Inorder:
            [self inorderTraverseTree:tree withAction:action];
            break;
        case Postorder:
            [self postorderTraverseTree:tree withAction:action];
            break;
    }
}

+ (void)preorderTraverseTree:(JVTree *)tree withAction:(void (^)(JVTree *))action {
    
    action(tree);
    
    if (tree.left != nil) {
        [self preorderTraverseTree:tree.left withAction:action];
    }
    
    if (tree.right != nil) {
        [self preorderTraverseTree:tree.right withAction:action];
    }
}

+ (void)inorderTraverseTree:(JVTree *)tree withAction:(void (^)(JVTree *))action {
    
    if (tree.left != nil) {
        [self inorderTraverseTree:tree.left withAction:action];
    }
    
    action(tree);
    
    if (tree.right != nil) {
        [self inorderTraverseTree:tree.right withAction:action];
    }
}

+ (void)postorderTraverseTree:(JVTree *)tree withAction:(void (^)(JVTree *))action {
    
    if (tree.left != nil) {
        [self postorderTraverseTree:tree.left withAction:action];
    }
    
    if (tree.right != nil) {
        [self postorderTraverseTree:tree.right withAction:action];
    }
    
    action(tree);
}

@end
