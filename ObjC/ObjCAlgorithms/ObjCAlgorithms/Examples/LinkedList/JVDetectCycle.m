//
//  JVDetectCycle.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 27/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVDetectCycle.h"
#import "JVLinkedNode.h"

@implementation JVDetectCycle

+ (BOOL)listHasCycle:(JVLinkedNode *)head {
    
    JVLinkedNode *slow = head;
    JVLinkedNode *fast = head;
    
    while (fast) {
        
        slow = slow.next;
        fast = fast.next.next;
        
        if ([slow.value isEqual:fast.value]) {
            return YES;
        }
    }
    
    return NO;
}

@end
