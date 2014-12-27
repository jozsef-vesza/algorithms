//
//  JVDetectCycle.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 27/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JVLinkedNode;

@interface JVDetectCycle : NSObject

+ (BOOL)listHasCycle:(JVLinkedNode *)head;

@end
