//
//  JVPriorityQueue.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVPriorityQueue : NSObject

- (void)insert:(id)value;
- (id)dequeue;
- (NSUInteger)count;

@end
