//
//  JVTree+Examples.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 04/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "JVTree.h"
@class JVLinkedNode;

@interface JVTree (Examples)

+ (BOOL)isBST:(JVTree *)tree;
+ (JVLinkedNode *)flattenTree:(JVTree *)tree;

@end
