//
//  JVTree.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 03/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Preorder,
    Inorder,
    Postorder,
} TreeTraversalType;

@interface JVTree : NSObject

@property (nonatomic, strong) id value;
@property (nonatomic, strong) JVTree *left, *right;

- (instancetype)initWithValue:(id)value;

+ (instancetype)insertValue:(id)newValue intoTree:(JVTree *)tree;
+ (void)traverseTree:(JVTree *)tree withTraversalType:(TreeTraversalType)traversalType withAction:(void (^)(JVTree *))action;

@end
