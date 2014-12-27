//
//  JVLinkedList.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 22/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVLinkedList.h"
#import "JVLinkedNode.h"

@interface JVLinkedList ()

@property (nonatomic, strong) JVLinkedNode *first;

@end

@implementation JVLinkedList

- (JVLinkedNode *)head {
    return self.first;
}

- (JVLinkedNode *)insertFirstValue:(id)value {
    
    JVLinkedNode *newNode = [[JVLinkedNode alloc] initWithValue:value];
    self.first = newNode;
    
    return newNode;
}

- (JVLinkedNode *)insertValue:(id)value afterNode:(JVLinkedNode *)node {
    
    JVLinkedNode *newNode = [[JVLinkedNode alloc] initWithValue:value];
    
    if (node == nil) {
        self.first = newNode;
    } else {
        node.next = newNode;
    }
    
    return newNode;
}

- (JVLinkedNode *)removeFirstNode {
    
    JVLinkedNode *obsoleteNode = self.first;
    self.first = self.first.next;
    
    return obsoleteNode;
}

- (JVLinkedNode *)removeAfterNode:(JVLinkedNode *)node {
    
    JVLinkedNode *obsoleteNode = node.next;
    node.next = node.next.next;
    
    return obsoleteNode;
}

@end
