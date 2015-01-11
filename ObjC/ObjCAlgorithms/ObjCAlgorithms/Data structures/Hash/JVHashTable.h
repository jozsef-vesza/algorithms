//
//  JVHashTable.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 10/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVHashTable : NSObject

- (instancetype)initWithCapacity:(NSUInteger)capacity NS_DESIGNATED_INITIALIZER;
- (id)findItem:(id)item;
- (void)addItem:(id)item;

@end
