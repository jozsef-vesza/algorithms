//
//  JVPriorityQueue.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVPriorityQueue.h"

@interface JVPriorityQueue ()

@property (nonatomic, strong) NSMutableArray *elements;

@end

@implementation JVPriorityQueue

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.elements = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)insert:(id)value {
    
    NSMutableArray *tempElem = [self.elements mutableCopy];
    BOOL placeFound = NO;
    
    for (id current in self.elements) {
        
        if (value < current) {
            [tempElem
             insertObject:value
             atIndex:[self.elements indexOfObject:current]];
            
            placeFound = YES;
            
            break;
        }
    }
    
    if (!placeFound) {
        [tempElem addObject:value];
    }
    
    self.elements = tempElem;
}

- (id)dequeue {
    
    id value = [self.elements firstObject];
    [self.elements removeObjectAtIndex:0];
    
    return value;
}

- (NSUInteger)count {
    return [self.elements count];
}

@end
