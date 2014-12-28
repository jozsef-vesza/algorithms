//
//  JVLRUCache.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVLRUCache.h"
#import "JVDoublyLinkedNode.h"

@interface JVLRUCache ()

@property (nonatomic) NSUInteger capacity;
@property (nonatomic, strong) JVDoublyLinkedNode *head;
@property (nonatomic, strong) JVDoublyLinkedNode *tail;
@property (nonatomic, strong) NSMutableDictionary *entries;

@end

@implementation JVLRUCache

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    
    self = [super init];
    
    if (self) {
        
        self.capacity = capacity;
        self.entries = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (id)getValueForKey:(id<NSCopying>)key {
    
    JVDoublyLinkedNode *entry = self.entries[key];
    
    if (!entry) {
        return nil;
    }
    
    [self moveToHead:entry];
    
    return entry.value;
}

- (void)setValue:(id)value forKey:(id<NSCopying>)key {
    
    JVDoublyLinkedNode *entry = self.entries[key];
    
    if (!entry) {
        
        entry = [[JVDoublyLinkedNode alloc] initWithValue:value withKey:key];
        
        if ([self.entries count] == self.capacity) {
            
            [self.entries removeObjectForKey:self.tail.key];
            self.tail = self.tail.previous;
            
            if (self.tail) {
                self.tail.next = nil;
            }
        }
        
        self.entries[key] = entry;
    }
    
    entry.value = value;
    
    [self moveToHead:entry];
    
    if (!self.tail) {
        self.tail = self.head;
    }
}

- (void)moveToHead:(JVDoublyLinkedNode *)entry {
    
    JVDoublyLinkedNode *next = (JVDoublyLinkedNode *)entry.next;
    JVDoublyLinkedNode *previous = entry.previous;
    
    if (next) {
        next.previous = entry.previous;
    }
    
    if (previous) {
        previous.next = entry.next;
    }
    
    entry.previous = nil;
    entry.next = self.head;
    
    if (self.head) {
        self.head.previous = entry;
    }
    
    self.head = entry;
    
    if ([self.tail isEqual:entry]) {
        self.tail = previous;
    }
    
}

@end
