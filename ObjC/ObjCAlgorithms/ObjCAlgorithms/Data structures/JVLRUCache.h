//
//  JVLRUCache.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVLRUCache : NSObject

- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (id)getValueForKey:(id<NSCopying>)key;
- (void)setValue:(id)value forKey:(id<NSCopying>)key;

@end
