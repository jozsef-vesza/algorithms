//
//  JVQueue.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 23/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVQueue.h"
#import "JVLinkedNode.h"

@interface JVQueue ()

@property (nonatomic, strong) JVLinkedNode *first, *last;

@end

@implementation JVQueue

- (void)enqueue:(id)newValue {
    
    JVLinkedNode *oldLast = self.last;
    JVLinkedNode *newNode = [[JVLinkedNode alloc] initWithValue:newValue];
    
    if ([self isEmpty]) {
        self.first = newNode;
    } else {
        oldLast.next = newNode;
    }
    
    self.last = newNode;
}

- (id)dequeue {
    
    id value = self.first.value;
    self.first = self.first.next;
    
    if ([self isEmpty]) {
        self.last = nil;
    }
    
    return value;
}

- (BOOL)isEmpty {
    return self.first == nil;
}

@end
