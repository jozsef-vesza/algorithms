//
//  JVLinkedNode+Examples.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVLinkedNode.h"

@interface JVLinkedNode (Examples)

+ (instancetype)addNumber:(JVLinkedNode *)firstNumber toNumber:(JVLinkedNode *)secondNumber;

+ (instancetype)reverseOrder:(JVLinkedNode *)head;
+ (instancetype)reorderList:(JVLinkedNode *)head;
+ (void)splitLinkedList:(JVLinkedNode *)head
              intoFront:(JVLinkedNode **)front
                andBack:(JVLinkedNode **)back;
+ (instancetype)mergeList:(JVLinkedNode *)firstHead
                 withSecondList:(JVLinkedNode *)secondHead;

+ (BOOL)listHasCycle:(JVLinkedNode *)head;

+ (instancetype)mergeList:(JVLinkedNode *)first withList:(JVLinkedNode *)second;
+ (instancetype)mergeLists:(NSArray *)lists;

+ (instancetype)removeDuplicates:(JVLinkedNode *)head;

@end
