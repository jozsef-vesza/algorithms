//
//  StringArrayMatrixTests.m
//  Tests
//
//  Created by József Vesza on 14/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "JVLinkedNode.h"
#import "JVStack.h"
#import "JVQueue.h"
#import "JVStringArrayMatrix.h"
#import "NSArray+MapFilterReduce.h"

@interface StringArrayMatrixTests : XCTestCase

@property (nonatomic, strong) NSMutableArray *reversePolishInputs;
@property (nonatomic, strong) NSMutableArray *reversePolishOutputs;

@property (nonatomic, strong) NSArray *palindromicInputs;
@property (nonatomic, strong) NSArray *palindromicOutputs;

@property (nonatomic, strong) NSMutableArray *zeroSumInputs;
@property (nonatomic, strong) NSMutableArray *zeroSumOutputs;

@end

@implementation StringArrayMatrixTests

- (void)setUp {
    
    [super setUp];
    
    NSArray *testFiles = [[NSBundle bundleForClass:[self class]] pathsForResourcesOfType:@"txt" inDirectory:nil];
    self.zeroSumOutputs = [[NSMutableArray alloc] init];
    self.zeroSumInputs = [[NSMutableArray alloc] init];
    
    for (NSString *fileName in testFiles) {
        
        NSString *contents = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
        
        if ([fileName containsString:@"reversePolishInput"]) {
            
            [self.reversePolishInputs addObject:contents];
            
        } else if ([fileName containsString:@"reversePolishOutput"]) {
            
            [self.reversePolishOutputs addObject:contents];
            
        } else if ([fileName containsString:@"palindromicInput"]) {
            
            self.palindromicInputs = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
        } else if ([fileName containsString:@"palindromicOutput"]) {
            
            self.palindromicOutputs = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        } else if ([fileName containsString:@"input00"]) {
            
            [self.zeroSumInputs addObject:[contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
        } else if ([fileName containsString:@"output00"]) {
            
            [self.zeroSumOutputs addObject:contents];
        }
    }
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReversePolish {
    for (int i = 0; i < [self.reversePolishInputs count]; i++) {
        XCTAssertEqual([self.reversePolishOutputs[i] intValue], [JVStringArrayMatrix calculateValue:self.reversePolishInputs[i]]);
    }
}

- (void)testPalindromic {
    for (int i = 0; i < [self.palindromicInputs count]; i++) {
        XCTAssert([[JVStringArrayMatrix findLongestPalindromicSubstring:self.palindromicInputs[i]] isEqualToString:self.palindromicOutputs[i]]);
    }
}

- (void)testTwoSum {
    
    NSArray *input = @[@2, @7, @11, @15];
    NSArray *output = [[JVStringArrayMatrix twoSumInArray:input withTarget:9] jv_map:^id(id next) {
        return input[[next intValue]];
    }];
    
    NSArray *expected = @[@2, @7];
    
    XCTAssert([expected isEqualToArray:output]);
    
}

- (void)testSumCount {
    
    XCTAssertEqual([self.zeroSumOutputs[0] intValue], [JVStringArrayMatrix countSumsInArray:self.zeroSumInputs[0] withTarget:0]);
    
    XCTAssertEqual([self.zeroSumOutputs[1] intValue], [JVStringArrayMatrix countSumsInArray:self.zeroSumInputs[1] withTarget:0]);
    
//    XCTAssertEqual([self.zeroSumOutputs[2] intValue], [JVStringArrayMatrix countSumsInArray:self.zeroSumInputs[2] withTarget:0]);
}

- (void)testThreeSum {
    
    NSArray *input = @[@-10, @-25, @-3, @-7, @4, @2, @10, @8];
    NSArray *output = [[JVStringArrayMatrix threeSumInArray:input] firstObject];
    NSArray *expected = @[@-10, @2, @8];
    
    XCTAssert([expected isEqualToArray:output]);
    
    NSArray *input2 = @[@-1, @0, @1, @2, @-1, @-4];
    NSArray *output2 = [JVStringArrayMatrix threeSumInArray:input2];
    NSArray *expected2 = @[@-1, @-1, @2, @-1, @0, @1];
    
    NSArray *flat = [output2 jv_reduce:[[NSMutableArray alloc] init] withBlock:^id(id reduced, id next) {
        [reduced addObjectsFromArray:next];
        return reduced;
    }];
    
    XCTAssert([expected2 isEqualToArray:flat]);
}

- (void)testTwoArrayMerge {
    
    NSArray *input2 = @[@1, @2, @3, @4, @5];
    NSArray *input1 = @[@5, @6, @7, @8, @9, @10];
    
    NSArray *output = [JVStringArrayMatrix mergeArray:input2 intoArray:input1];
    NSArray *expected = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    
    XCTAssert([expected isEqualToArray:output]);
}

- (void)testMaximumSubarraySum {
    
    NSArray *input = @[@-2, @1, @-3, @4, @-1, @2, @1, @-5, @4];
    int expected = 6;
    
    XCTAssertEqual(expected, [JVStringArrayMatrix maximumSubarray:input]);
}

- (void)testSentenceReversal {
    
    NSString *input = @"the sky is blue";
    NSString *expected = @"blue is sky the";
    NSString *output = [JVStringArrayMatrix reverseStringWordByWord:input];
    
    XCTAssert([expected isEqualToString:output]);
}

- (void)testStringReversal {
    
    NSString *input = @"abcde";
    NSString *expected = @"edcba";
    NSString *output = [JVStringArrayMatrix reverseString:input];
    
    XCTAssert([expected isEqualToString:output]);
}

@end
