//
//  Tests.m
//  Tests
//
//  Created by József Vesza on 14/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "JVReversePolish.h"
#import "JVPalindromic.h"

@interface Tests : XCTestCase

@property (nonatomic, strong) NSMutableArray *reversePolishInputs;
@property (nonatomic, strong) NSMutableArray *reversePolishOutputs;

@property (nonatomic, strong) NSArray *palindromicInputs;
@property (nonatomic, strong) NSArray *palindromicOutputs;

@end

@implementation Tests

- (void)setUp {
    
    [super setUp];
    
    NSArray *testFiles = [[NSBundle bundleForClass:[self class]] pathsForResourcesOfType:@"txt" inDirectory:nil];
    
    for (NSString *fileName in testFiles) {
        
        NSString *contents = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
        
        if ([fileName hasPrefix:@"reversePolishInput"]) {
            
            [self.reversePolishInputs addObject:contents];
            
        } else if ([fileName hasPrefix:@"reversePolishOutput"]) {
            
            [self.reversePolishOutputs addObject:contents];
            
        } else if ([fileName hasPrefix:@"palindromicInput"]) {
            
            self.palindromicInputs = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
        } else if ([fileName hasPrefix:@"palindromicOutput"]) {
            
            self.palindromicOutputs = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        }
    }
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReversePolish {
    for (int i = 0; i < [self.reversePolishInputs count]; i++) {
        XCTAssertEqual([self.reversePolishOutputs[i] intValue], [JVReversePolish calculateValue:self.reversePolishInputs[i]]);
    }
}

- (void)testPalindromic {
    for (int i = 0; i < [self.palindromicInputs count]; i++) {
        XCTAssert([[JVPalindromic findLongestPalindromicSubstring:self.palindromicInputs[i]] isEqualToString:self.palindromicOutputs[i]]);
    }
}

@end
