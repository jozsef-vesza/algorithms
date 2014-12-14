//
//  Palindromic.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 14/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "Palindromic.h"

@implementation Palindromic

+ (NSString *)findLongestPalindromicSubstring:(NSString *)inputString {
    
    if ([inputString length] == 0) {
        return nil;
    }
    
    if ([inputString length] == 1) {
        return  inputString;
    }
    
    NSString *longest = @"";
    NSString *temp;
    
    unsigned int len = [inputString length];
    char buffer[len];
    
    [inputString getCharacters:buffer range:NSMakeRange(0, len)];
    
    for (int i = 0; i < len; i++) {
        
        temp = [self findPalindromicIn:inputString iterateFrom:i iterateTo:i];
        
        if ([temp length] > [longest length]) {
            longest = temp;
        }
        
        temp = [self findPalindromicIn:inputString iterateFrom:i iterateTo:i + 1];
        
        if ([temp length] > [longest length]) {
            longest = temp;
        }
    }
    
    return longest;
}

+ (NSString *)findPalindromicIn:(NSString *)input iterateFrom:(int)toFront iterateTo:(int)toEnd {
    
    while (toFront >= 0 &&
           toEnd <= [input length] -1
           && [input characterAtIndex:toFront] == [input characterAtIndex:toEnd]) {
        
        toFront--;
        toEnd++;
    }
    
    int startIndex = toFront + 1;
    int endIndex = toEnd - 1;

    
    return [input substringWithRange: NSMakeRange(startIndex, endIndex - startIndex + 1)];
}

@end
