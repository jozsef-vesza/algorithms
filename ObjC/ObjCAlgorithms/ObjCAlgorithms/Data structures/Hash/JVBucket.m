//
//  JVBucket.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 10/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "JVBucket.h"
#import "JVLinkedNode.h"

@interface JVBucket ()

@property (nonatomic, strong) JVLinkedNode *item;

@end

@implementation JVBucket

- (instancetype)initWithValue:(id)value {
    
    self = [super init];
    
    if (self) {
        
        self.item = [[JVLinkedNode alloc] initWithValue:value];
    }
    
    return self;
}

- (void)setValue:(id)value {
    
    JVLinkedNode *newItem = [[JVLinkedNode alloc] initWithValue:value];

    if (self.item == nil) {
        
        self.item = newItem;
        
    } else {
        
        newItem.next = self.item;
        self.item = newItem;
    }
}

- (id)getValue:(id)value {
    
    if ([self.item.value isEqual:value]) {
        
        return self.item.value;
        
    } else {
    
        JVLinkedNode *cursor = self.item;
        
        while (cursor.next != nil) {
            
            if ([cursor.value isEqual:value]) {
                return cursor.value;
            } else {
                cursor = cursor.next;
            }
        }
    }
    
    return nil;
}

@end
