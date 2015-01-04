//
//  NSArray+MapFilterReduce.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 04/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import "NSArray+MapFilterReduce.h"

@implementation NSArray (MapFilterReduce)

- (NSArray *)map:(id (^)(id))mapBlock {
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (id obj in self) {
        [temp addObject:mapBlock(obj)];
    }
    
    return temp;
}

- (NSArray *)filter:(BOOL (^)(id))filterBlock {
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (id obj in self) {
        if (filterBlock(obj)) {
            [temp addObject:obj];
        }
    }
    
    return temp;
}

- (id)reduce:(id)initial withBlock:(id (^)(id, id))combineBlock {
    
    id reduce = initial;
    
    for (id obj in self) {
        reduce = combineBlock(reduce, obj);
    }
    
    return reduce;
}

@end
