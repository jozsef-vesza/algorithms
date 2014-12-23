//
//  JVStack.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 14/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVStack.h"
#import "JVLinkedNode.h"

@interface JVStack ()

@property (nonatomic, strong) JVLinkedNode *first;

@end

@implementation JVStack

- (void)push:(id)newValue {
    
    JVLinkedNode *oldFirst = self.first;
    self.first = [[JVLinkedNode alloc] initWithValue:newValue];
    self.first.next = oldFirst;
}

- (id)pop {
    id value = self.first.value;
    self.first = self.first.next;
    
    return value;
}

- (BOOL)isEmpty {
    return self.first == nil;
}

@end
