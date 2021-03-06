//
//  JVStringArrayMatrix.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVStringArrayMatrix.h"
#import "JVStack.h"

@implementation JVStringArrayMatrix

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

+ (NSArray *)twoSumInArray:(NSArray *)numbers withTarget:(int)target {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [numbers count]; i++) {
        
        int value = [numbers[i] intValue];
        NSString *soughtKey = [NSString stringWithFormat:@"%d", value];
        
        if (dict[soughtKey]) {
            
            int saved = [dict[soughtKey] intValue];
            result[0] = @(saved);
            result[1] = @(i);
            
        } else {
            
            int result = target - value;
            NSString *key = [NSString stringWithFormat:@"%d", result];
            dict[key] = @(i);
        }
    }
    
    return result;
}

+ (int)countSumsInArray:(NSArray *)numbers withTarget:(int)target {
    
    NSMutableArray *nums = [numbers mutableCopy];
    [nums removeObjectAtIndex:0];
    
    return [self countSumsInArray:nums withTarget:target startingatIndex:0];
}

+ (int)countSumsInArray:(NSArray *)numbers withTarget:(int)target startingatIndex:(int)index {
    
    int count = 0;
    int preSum = 0;
    
    for (int i = index; i < [numbers count]; i++) {
        
        int currentValue = [numbers[i] intValue];
        
        if (preSum + currentValue == target) {
            count += 1;
        }
        
        preSum += currentValue;
    }
    
    if (index < [numbers count]) {
        count += [self countSumsInArray:numbers withTarget:target startingatIndex:index + 1];
    }
    
    return count;
}

+ (NSArray *)threeSumInArray:(NSArray *)numbers {
    
    NSArray *sorted =[numbers sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSUInteger n = [sorted count];
    NSMutableSet *result = [[NSMutableSet alloc] init];
    
    for (int i = 0; i < n; i++) {

        int a = [sorted[i] intValue];
        NSUInteger start = i + 1;
        NSUInteger end = n - 1;
        
        while (start < end) {
            
            int b = [sorted[start] intValue];
            int c = [sorted[end] intValue];
            
            if (a + b + c == 0) {
                
                [result addObject:@[@(a), @(b), @(c)]];
                start += 1;
                end -= 1;
                
            } else if (a + b + c > 0) {
            
                end = end - 1;
                
            } else {
                
                start = start + 1;
            }
        }
    }
    
    return [result allObjects];
}

+ (NSArray *)mergeArray:(NSArray *)input1 intoArray:(NSArray *)input2 {
    
    NSMutableArray *output = [input1 mutableCopy];
    
    NSUInteger count1 = [input1 count];
    NSUInteger count2 = [input2 count];
    
    for (int i = 0; i < count2; i++) {
        
        BOOL inserted = NO;
        
        for (int j = 0; j < count1; j++) {
            
            if ([input2[i] intValue] == [input1[j] intValue]) {
                
                i++;
                break;
            }
            
            if ([input2[i] intValue] < [input1[j] intValue]) {
                
                NSUInteger index = [output indexOfObject:input1[j]];
                [output insertObject:input2[i] atIndex:index];
                inserted = YES;
                
                break;
            }
        }
        
        if (!inserted) {
            [output addObject:input2[i]];
        }
    }
    
    return output;
}

+ (int)maximumSubarray:(NSArray *)input {
    
    int sum = [input[0] intValue];
    int max = [input[0] intValue];
    
    for (int i = 1; i < [input count]; i++) {
        sum = MAX(sum + [input[i] intValue], [input[i] intValue]);
        max = MAX(max, sum);
    }
    
    return max;
}

+ (NSString *)reverseStringWordByWord:(NSString *)input {
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    NSArray *words = [input componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    for (NSInteger i = [words count] - 1; i > 0; i--) {
        [output appendFormat:@"%@ ", words[i]];
    }
    
    [output appendString:[words firstObject]];
    
    return output;
}

+ (NSString *)reverseString:(NSString *)input {
    
    NSMutableString *output = [[NSMutableString alloc] init];
    NSUInteger charIndex = [input length];
    
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [output appendString:[input substringWithRange:subStrRange]];
    }
    
    return output;
}

@end
