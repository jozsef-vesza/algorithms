//
//  JVTree.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 25/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "JVTree.h"

@interface JVTree ()

@property (nonatomic, strong) JVTree *left, *right;
@property (nonatomic, weak) JVTree *parent;

@end

@implementation JVTree

+ (instancetype)treeWithItem:(id)item {
    return [[self alloc] initWithItem:item];
}

+ (JVTree *)insertItem:(id)item inTree:(JVTree *)tree {
    
    return [self insertItem:item inTree:tree withParent:nil];
}

+ (JVTree *)insertItem:(id)item inTree:(JVTree *)tree withParent:(JVTree *)parent {

    if ([tree.item isEqualTo:item]) {
        return nil;
    }
    
    if (!tree) {
        
        JVTree *newTree = [self treeWithItem:item];
        newTree.parent = parent;
        return newTree;
    }
    
    if (item < tree.item) {
        
        tree.left = [self insertItem:item inTree:tree.left withParent:tree];
        
    } else {
        
        tree.right = [self insertItem:item inTree:tree.right withParent:tree];
    }
    
    return tree;
}

+ (JVTree *)findItem:(id)item inTree:(JVTree *)tree {
    
    if (!tree) { return nil; }
    
    if ([tree.item isEqual:item]) { return tree; }
    
    if (item < tree.item) { return [self findItem:item inTree:tree.left]; }
    
    else { return [self findItem:item inTree:tree.right]; }
}

+ (JVTree *)minimumInTree:(JVTree *)tree {
    
    JVTree *minimum = tree;
    
    while (minimum.left != nil) {
        minimum = minimum.left;
    }
    
    return minimum;
}

+ (JVTree *)maximumInTree:(JVTree *)tree {
    
    JVTree *maximum = tree;
    
    while (maximum.right != nil) {
        maximum = maximum.right;
    }
    
    return maximum;
}

+ (void)traverseTree:(JVTree *)tree inOrder:(JVTreeTraversalMode)mode withAction:(void (^)(JVTree *current))action {
    
    switch (mode) {
            
        case Preorder:
            [self preorderTraverseTree:tree withAction:action];
            break;
            
        case Inorder:
            [self inorderTraverseTree:tree withAction:action];
            break;
            
        case Postorder:
            [self postorderTraverseTree:tree withAction:action];
            break;
            
        default:
            break;
    }
}

+ (void)preorderTraverseTree:(JVTree *)tree withAction:(void (^)(JVTree *current))action {
    
    if (tree != nil) {
        
        action(tree);
        [self preorderTraverseTree:tree.left withAction:action];
        [self preorderTraverseTree:tree.right withAction:action];
    }
}

+ (void)inorderTraverseTree:(JVTree *)tree withAction:(void (^)(JVTree *current))action {
    
    if (tree != nil) {
        
        [self inorderTraverseTree:tree.left withAction:action];
        action(tree);
        [self inorderTraverseTree:tree.right withAction:action];
    }
}

+ (void)postorderTraverseTree:(JVTree *)tree withAction:(void (^)(JVTree *current))action {
    
    if (tree != nil) {
        
        [self postorderTraverseTree:tree.left withAction:action];
        [self postorderTraverseTree:tree.right withAction:action];
        action(tree);
    }
}

+ (JVTree *)deleteValue:(id)value fromTree:(JVTree *)tree {
    
    JVTree *doomedNode = [self findItem:value inTree:tree];
    
    if (!doomedNode.left && !doomedNode.right) {
        
        doomedNode.parent = [self removeChildFromParent:doomedNode];
        
    } else if (!doomedNode.left || !doomedNode.right) {
        
        doomedNode.parent = [self replaceChildWithGrandChild:doomedNode];
    } else {
        
        doomedNode = [self replaceWithInorderSuccessor:doomedNode];
    }
    
    return tree;
}

+ (JVTree *)removeChildFromParent:(JVTree *)child {
    
    if (child.parent.item > child.item) {
        child.parent.left = nil;
    } else {
        child.parent.right = nil;
    }
    
    return child.parent;
}

+ (JVTree *)replaceChildWithGrandChild:(JVTree *)child {
    
    JVTree *grandChild = child.left ?: child.right;
    JVTree *grandParent = child.parent;
    
    if (child.item < grandParent.item) {
        
        grandParent.left = grandChild;
        
    } else {
        
        grandParent.right = grandChild;
    }
    
    grandChild.parent = grandParent;
    
    return grandParent;
}

+ (JVTree *)replaceWithInorderSuccessor:(JVTree *)tree {
    
    id newValue = [self minimumInTree:tree.right].item;
    tree = [self deleteValue:newValue fromTree:tree];
    tree.item = newValue;
    
    return tree;
}

- (instancetype)initWithItem:(id)item {
    self = [super init];
    if (self) {
        self.item = item;
    }
    return self;
}

@end
