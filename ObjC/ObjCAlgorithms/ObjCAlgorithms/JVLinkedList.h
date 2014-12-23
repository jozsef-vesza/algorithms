//
//  JVLinkedList.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 22/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JVLinkedNode;

@interface JVLinkedList : NSObject

- (JVLinkedNode *)head;
- (JVLinkedNode *)insertFirstValue:(id)value;
- (JVLinkedNode *)insertValue:(id)value afterNode:(JVLinkedNode *)node;
- (JVLinkedNode *)removeFirstNode;
- (JVLinkedNode *)removeAfterNode:(JVLinkedNode *)node;

@end
