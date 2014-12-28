//
//  JVDoublyLinkedNode.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVDoublyLinkedNode.h"

@implementation JVDoublyLinkedNode

- (instancetype)initWithValue:(id)value withKey:(id<NSCopying>)key {
    
    self = [super init];
    
    if (self) {
        self.value = value;
        self.key = key;
    }
    
    return self;
}

@end
