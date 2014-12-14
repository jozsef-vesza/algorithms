//
//  ObjCAlgorithmsTests.m
//  ObjCAlgorithmsTests
//
//  Created by József Vesza on 14/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "ReversePolish.h"

@interface ObjCAlgorithmsTests : XCTestCase

@property (nonatomic, strong) NSMutableArray *reversePolishInputs;
@property (nonatomic, strong) NSMutableArray *reversePolishOutputs;

@end

@implementation ObjCAlgorithmsTests

- (void)setUp {
    [super setUp];
    
    NSArray *reversePolishFiles = [[NSBundle bundleForClass:[self class]] pathsForResourcesOfType:@"txt" inDirectory:nil];
    
    for (NSString *fileName in reversePolishFiles) {
        if ([fileName hasPrefix:@"reversePolishInput"]) {
            [self.reversePolishInputs addObject:[NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil]];
        } else if ([fileName hasPrefix:@"reversePolishOutput"]) {
            [self.reversePolishOutputs addObject:[NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil]];
        }
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReversePolish {
    for (int i = 0; i < [self.reversePolishInputs count]; i++) {
        XCTAssertEqual([self.reversePolishOutputs[i] intValue], [ReversePolish calculateValue:self.reversePolishInputs[i]]);
    }
}

@end
