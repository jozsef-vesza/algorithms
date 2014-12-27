//
//  JVLinkedNode.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 22/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVLinkedNode.h"

@implementation JVLinkedNode

- (instancetype)initWithValue:(id)value {
    self = [super init];
    if (self) {
        self.value = value;
    }
    return self;
}

@end
