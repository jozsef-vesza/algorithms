//
//  JVBinaryTree.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 22/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVBinaryTree : NSObject

@property (nonatomic, strong) id root;
@property (nonatomic, strong) JVBinaryTree *left;
@property (nonatomic, strong) JVBinaryTree *right;

@end
