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

@end
