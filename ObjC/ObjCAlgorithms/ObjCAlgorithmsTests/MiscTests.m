//
//  MiscTests.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 11/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

@interface MiscTests : XCTestCase

@end

@implementation MiscTests

- (void)testStandardInput {
    
    NSFileHandle *stdInput = [NSFileHandle fileHandleWithStandardInput];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    BOOL transferFinished = NO;
    
    while (!transferFinished) {
        
        NSString *input = [[[NSString alloc] initWithData:[stdInput availableData] encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        if ([input isEqualToString:@""]) {
            transferFinished = YES;
        } else {
            [arr addObject:input];
        }
    }
    
    NSLog(@"end");
}

@end
