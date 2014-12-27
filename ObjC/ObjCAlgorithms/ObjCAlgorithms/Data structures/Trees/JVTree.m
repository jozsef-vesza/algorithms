//
//  JVTree.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 22/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVTree.h"
#import "JVStack.h"

@interface JVTree ()

@property (nonatomic, strong) NSMutableSet *subTree;

@end

@implementation JVTree

+ (instancetype)createTreeWithRoot:(id)root {
    return [[JVTree alloc] initWithRoot:root];
}

+ (instancetype)addValue:(id)newValue toTree:(JVTree *)tree {
    
    if (![tree.subTree containsObject:newValue]) {
        [tree.subTree addObject:[JVTree createTreeWithRoot:newValue]];
    }
    
    return tree;
}

+ (instancetype)addTree:(JVTree *)newTree toTree:(JVTree *)tree {
    
    [tree.subTree addObject:newTree];
    return tree;
}

+ (instancetype)deleteValue:(id)value fromTree:(JVTree *)tree {
    
    return [JVTree deleteValue:value fromTree:tree withParent:nil];
}

+ (instancetype)deleteValue:(id)value fromTree:(JVTree *)tree withParent:(JVTree *)parent {
    
//    if ([tree.root isEqual:value]) {
//        
//        if (parent != nil) {
//            
//            for (JVTree *subtree in tree.subTree) {
//                [JVTree addTree:subtree toTree:parent];
//                
//            }
//        }
//        
//        tree = nil;
//    }
    
    //TODO: fix this
    return nil;
}

+ (instancetype)findValue:(id)value inTree:(JVTree *)tree withSearchMethod:(SearchType)searchType {
    
    switch (searchType) {
            
        case BreadthFirst:
            return [JVTree findValueBFS:value inTree:tree];
            break;
            
        case DepthFirst:
            return [JVTree findValuePreorder:value inTree:tree];
            break;
            
        default:
            return nil;
            break;
    }
}

+ (instancetype)findValueBFS:(id)value inTree:(JVTree *)tree {
    
    JVStack *stack = [[JVStack alloc] init];
    [stack push:tree];
    
    while (![stack isEmpty]) {
        JVTree *next = [stack pop];
        
        if ([next.root isEqual:value]) {
            return next;
        } else {
            for (JVTree *subTree in next.subTree) {
                [stack push:subTree];
            }
        }
    }
    
    return nil;
}

+ (instancetype)findValuePreorder:(id)value inTree:(JVTree *)tree {
    
    JVTree *foundNode;
    
    if ([tree.root isEqual:value]) {
        foundNode = tree;
    } else {
        for (JVTree *subtree in tree.subTree) {
            foundNode = [JVTree findValuePreorder:value inTree:subtree];
            if (foundNode != nil) {
                break;
            }
        }
    }
    
    return foundNode;
}

+ (void)traverseTree:(JVTree *)tree withAction:(void (^)(JVTree *current))action {
    action(tree);
    for (JVTree *subtree in tree.subTree) {
        [JVTree traverseTree:subtree withAction:action];
    }
}

- (instancetype)initWithRoot:(id)root {
    self = [super init];
    if (self) {
        self.root = root;
        self.subTree = [[NSMutableSet alloc] init];
    }
    return self;
}

- (instancetype)addValue:(id)newValue {
    return [JVTree addValue:newValue toTree:self];
}

- (instancetype)deleteValue:(id)value {
    return [JVTree deleteValue:value fromTree:self];
}

- (instancetype)findValue:(id)value withSearchMethod:(SearchType)searchType {
    return [JVTree findValue:value inTree:self withSearchMethod:searchType];
}

- (void)traverseWithAction:(void (^)(JVTree *current))action {
    [JVTree traverseTree:self withAction:action];
}

- (NSSet *)getSubTree {
    return self.subTree;
}

@end