//
//  JVReverseOrder.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 26/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVReverseOrder.h"
#import "JVLinkedNode.h"

@implementation JVReverseOrder

+ (JVLinkedNode *)reorderList:(JVLinkedNode *)head {
    
    if (head == nil && head.next == nil) {
        return head;
    }
    
    JVLinkedNode *slow = head;
    JVLinkedNode *fast = head;
    
    while (fast != nil && fast.next != nil && fast.next.next != nil) {
        
        slow = slow.next;
        fast = fast.next.next;
    }
    
    JVLinkedNode *secondHead = slow.next;
    slow.next = nil;
    
    secondHead = [JVReverseOrder reverseOrder:secondHead];
    
    JVLinkedNode *p1 = head;
    JVLinkedNode *p2 = secondHead;
    
    while (p2 != nil) {
        
        JVLinkedNode *temp1 = p1.next;
        JVLinkedNode *temp2 = p2.next;
        
        p1.next = p2;
        p2.next = temp1;
        
        p1 = temp1;
        p2 = temp2;
    }
    
    return head;
}

+ (JVLinkedNode *)reverseOrder:(JVLinkedNode *)head {
    
    if (head == nil || head.next == nil) {
        return head;
    }
    
    JVLinkedNode *pre = head;
    JVLinkedNode *current = head.next;
    
    while (current != nil) {
        
        JVLinkedNode *temp = current.next;
        current.next = pre;
        pre = current;
        current = temp;
    }
    
    head.next = nil;
    
    return pre;
}

@end
