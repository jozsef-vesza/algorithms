//
//  JVHashTable.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 10/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "JVHashTable.h"
#import "JVBucket.h"

@interface JVHashTable ()

@property (nonatomic, strong) NSMutableArray *buckets;

@end

@implementation JVHashTable

- (instancetype)init {
    return [self initWithCapacity:50];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    
    self = [super init];
    
    if (self) {
        
        self.buckets = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < capacity; i ++) {
            [self.buckets addObject:[NSNull null]];
        }
        
    }
    
    return self;
}

- (void)addItem:(id)item {
    
    NSUInteger hashIndex = [self hashForItem:item];
    
    JVBucket *existingHash = self.buckets[hashIndex];
    
    if ([existingHash isKindOfClass:[NSNull class]]) {
        self.buckets[hashIndex] = [[JVBucket alloc] initWithValue:item];
    } else {
        [existingHash setValue:item];
    }
}

- (id)findItem:(id)item {
    
    NSUInteger hashIndex = [self hashForItem:item];
    
    JVBucket *existingHash = self.buckets[hashIndex];
    
    if (existingHash != nil) {
        return [existingHash getValue:item];
    }
    
    return nil;
}

- (NSUInteger)hashForItem:(id)item {
    return [self indexForHash:[item hash]];
}

- (NSUInteger)indexForHash:(NSUInteger)hash {
    return hash % [self.buckets count];
}

@end
