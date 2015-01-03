//
//  JVStringArrayMatrix.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 28/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVStringArrayMatrix : NSObject

+ (int)calculateValue:(NSArray *)inputFiles;

+ (NSString *)findLongestPalindromicSubstring:(NSString *)inputString;

+ (NSArray *)twoSumInArray:(NSArray *)numbers withTarget:(int)target;

+ (int)countSumsInArray:(NSArray *)numbers withTarget:(int)target;

+ (NSArray *)threeSumInArray:(NSArray *)numbers;

+ (BOOL)findSumsInArray:(NSArray *)numbers withTarget:(int)targetSum;

+ (NSArray *)mergeArray:(NSArray *)input1 intoArray:(NSArray *)input2;

+ (int)maximumSubarray:(NSArray *)input;

+ (NSString *)reverseStringWordByWord:(NSString *)input;

+ (NSString *)reverseString:(NSString *)input;

@end
