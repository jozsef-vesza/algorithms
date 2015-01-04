//
//  NSArray+MapFilterReduce.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 04/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MapFilterReduce)

- (NSArray *)map:(id (^)(id next))mapBlock;
- (NSArray *)filter:(BOOL (^)(id next))filterBlock;
- (id)reduce:(id (^)(id reduced, id next))combineBlock;

@end
