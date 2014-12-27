//
//  JVAddition.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 25/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVAddition.h"
#import "JVLinkedNode.h"
#import "JVLinkedList.h"
#import "JVStack.h"
#import "JVQueue.h"

@implementation JVAddition

+ (JVLinkedNode *)addNumber:(JVLinkedNode *)firstNumber toNumber:(JVLinkedNode *)secondNumber {
    
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

@end
