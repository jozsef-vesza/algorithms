//
//  JVLinkedNode+Examples.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVLinkedNode+Examples.h"

@implementation JVLinkedNode (Examples)

+ (instancetype)addNumber:(JVLinkedNode *)firstNumber toNumber:(JVLinkedNode *)secondNumber {

    JVLinkedNode *result = [[JVLinkedNode alloc] init];
    JVLinkedNode *currentResultPointer;
    JVLinkedNode *first = firstNumber;
    JVLinkedNode *second = secondNumber;
    
    int carry = 0;
    
    while (first != nil || second != nil) {
        
        int sum = [first.value intValue] + [second.value intValue] + carry;
        
        carry = sum < 10 ? 0 : 1;
        sum = sum % 10;
        
        if (currentResultPointer == nil) {
            
            result.value = @(sum);
            currentResultPointer = result;
            
        } else {
            
            currentResultPointer.next = [[JVLinkedNode alloc] initWithValue:@(sum)];
            currentResultPointer = currentResultPointer.next;
        }
        
        first = first.next;
        second = second.next;
    }
    
    return result;
}

+ (instancetype)reorderList:(JVLinkedNode *)head {
    
    if (head == nil && head.next == nil) {
        return head;
    }
    
    JVLinkedNode *secondHead;
    [JVLinkedNode splitLinkedList:head intoFront:&head andBack:&secondHead];
    secondHead = [JVLinkedNode reverseOrder:secondHead];
    
    return [JVLinkedNode mergeList:head withSecondList:secondHead];
}

+ (void)splitLinkedList:(JVLinkedNode *)head intoFront:(JVLinkedNode **)front andBack:(JVLinkedNode **)back {
    
    if (head == nil) {
        return;
    }
    
    JVLinkedNode *endOfFront;
    JVLinkedNode *slow = head;
    JVLinkedNode *fast = head;
    
    while (fast) {
        
        endOfFront = slow;
        slow = slow.next;
        fast = fast.next.next;
    }
    
    endOfFront.next = nil;
    *front = head;
    *back = slow;
}

+ (instancetype)reverseOrder:(JVLinkedNode *)head {
    
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

+ (instancetype)mergeList:(JVLinkedNode *)firstHead withSecondList:(JVLinkedNode *)secondHead {
    
    JVLinkedNode *p1 = firstHead;
    JVLinkedNode *p2 = secondHead;
    
    while (p2 != nil) {
        
        JVLinkedNode *temp1 = p1.next;
        JVLinkedNode *temp2 = p2.next;
        
        p1.next = p2;
        p2.next = temp1;
        
        p1 = temp1;
        p2 = temp2;
    }
    
    return firstHead;
}

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

+ (instancetype)mergeList:(JVLinkedNode *)first withList:(JVLinkedNode *)second {
    
    JVLinkedNode *p1 = first;
    JVLinkedNode *p2 = second;
    
    JVLinkedNode *fakeHead = [[JVLinkedNode alloc] init];
    JVLinkedNode *p = fakeHead;
    
    while (p1 != nil && p2 != nil) {
        
        if (p1.value < p2.value) {
            
            p.next = p1;
            p1 = p1.next;
        } else {
            
            p.next = p2;
            p2 = p2.next;
        }
        
        p = p.next;
    }
    
    if (p1 != nil) {
        p.next = p1;
    }
    
    if (p2 != nil) {
        p.next = p2;
    }
    
    return fakeHead.next;
}

+ (instancetype)mergeLists:(NSArray *)lists {
    
    NSArray *sorted = [lists sortedArrayUsingComparator:^NSComparisonResult(JVLinkedNode *obj1, JVLinkedNode *obj2) {
        return [obj1.value compare:obj2.value];
    }];
    
    JVLinkedNode *merged = [[JVLinkedNode alloc] initWithValue:@0];
    JVLinkedNode *p = merged;
    
    for (JVLinkedNode *node in sorted) {
        
        for (JVLinkedNode *i = node; i != nil; i = i.next) {
            p.next = i;
            p = p.next;
        }
    }
    
    return merged.next;
}

+ (instancetype)removeDuplicates:(JVLinkedNode *)head {
    
    JVLinkedNode *current = head;
    JVLinkedNode *ahead = head.next;
    
    while (ahead != nil) {
        
        if ([current.value isEqual:ahead.value]) {
            current.next = ahead.next;
        } else {
            current = current.next;
        }
        
        ahead = ahead.next;
    }
    
    return head;
}

@end
