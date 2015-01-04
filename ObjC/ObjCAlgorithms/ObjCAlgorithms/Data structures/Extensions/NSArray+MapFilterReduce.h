//
//  NSArray+MapFilterReduce.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 04/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MapFilterReduce)

- (NSArray *)jv_map:(id (^)(id next))mapBlock;
- (NSArray *)jv_filter:(BOOL (^)(id next))filterBlock;
- (id)jv_reduce:(id)initial withBlock:(id (^)(id reduced, id next))combineBlock;

@end
