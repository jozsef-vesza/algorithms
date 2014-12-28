//
//  JVQueue.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 23/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVQueue : NSObject

- (void)enqueue:(id)newValue;
- (id)dequeue;
- (BOOL)isEmpty;

@end
