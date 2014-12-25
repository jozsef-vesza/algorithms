//
//  JVReverseOrder.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 26/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JVLinkedNode;

@interface JVReverseOrder : NSObject

+ (JVLinkedNode *)reverseOrder:(JVLinkedNode *)head;
+ (JVLinkedNode *)reorderList:(JVLinkedNode *)head;
+ (void)splitLinkedList:(JVLinkedNode *)head intoFront:(JVLinkedNode **)front andBack:(JVLinkedNode **)back;

@end
