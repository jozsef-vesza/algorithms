//
//  ReversePolish.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 14/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "ReversePolish.h"
#import "JVStack.h"

@implementation ReversePolish

+ (int)calculateValue:(NSArray *)inputFiles {
    
    const NSString *operators = @"+-*/";
    
    JVStack *stack = [[JVStack alloc] init];
    int result = 0;
    
    for (NSString *value in inputFiles) {
        
        if (![operators containsString:value]) {
            
            [stack push:value];
            
        } else {
            
            int value1 = [[stack pop] intValue];
            int value2 = [[stack pop] intValue];
            
            if ([value isEqualToString:@"+"]) {
                
                [stack push:@(value1 + value2)];
                
            } else if ([value isEqualToString:@"-"]) {
                
                [stack push:@(value1 - value2)];
                
            } else if ([value isEqualToString:@"*"]) {
                
                [stack push:@(value1 * value2)];
                
            } else if ([value isEqualToString:@"/"]) {
                
                [stack push:@(value1 / value2)];
                
            }
        }
    }
    
    result = [[stack pop] intValue];
    
    return result;
}

@end
