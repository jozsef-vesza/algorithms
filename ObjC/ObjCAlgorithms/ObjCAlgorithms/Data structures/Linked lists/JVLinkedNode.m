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

+ (instancetype)findValue:(id)value inList:(JVLinkedNode *)list {
    
    if (!list) { return nil; }
    
    if ([list.value isEqualTo:value]) { return list; }
    
    else { return [self findValue:value inList:list.next]; }
}

+ (instancetype)insertValue:(id)value inList:(JVLinkedNode *)list {

    JVLinkedNode *newList = [[JVLinkedNode alloc] initWithValue:value];
    newList.next = list;
    
    return newList;
}

+ (instancetype)findPredecessorOfValue:(id)value inList:(JVLinkedNode *)list {
    
    if (!list || !list.next) { return nil; }
    
    if ([list.next.value isEqualTo:value]) { return list; }
    
    else { return [self findPredecessorOfValue:value inList:list.next]; }
}

+ (instancetype)deleteValue:(id)value fromList:(JVLinkedNode *)list {
    
    JVLinkedNode *toBeDeleted = [self findValue:value inList:list];
    
    if (toBeDeleted) {
        
        JVLinkedNode *predecessor = [self findPredecessorOfValue:value inList:list];
        
        if (!predecessor) {
            
            return toBeDeleted.next;
            
        } else {
            
            predecessor.next = toBeDeleted.next;
            return list;
        }
    }
    
    return nil;
}

@end
