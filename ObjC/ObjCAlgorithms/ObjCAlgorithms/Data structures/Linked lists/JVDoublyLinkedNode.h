//
//  JVDoublyLinkedNode.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVLinkedNode.h"

@interface JVDoublyLinkedNode : JVLinkedNode

@property (nonatomic, strong) JVDoublyLinkedNode *previous;
@property (nonatomic, copy) id<NSCopying> key;

- (instancetype)initWithValue:(id)value withKey:(id<NSCopying>)key;

@end
