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
#import "JVLinkedList.h"
#import "JVLinkedNode.h"
#import "JVTree.h"
#import "JVStack.h"
#import "JVQueue.h"

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

- (void)testLinkedLists {
    
    JVLinkedList *list = [[JVLinkedList alloc] init];
    JVLinkedNode *prev;
    
    for (int i = 0; i < 10; i++) {
        prev = [list insertValue:@(i) afterNode:prev];
    }
    
    XCTAssertEqual(0, [[list head].value intValue]);
    
    JVLinkedNode *removedSecond = [list removeAfterNode:[list head]];
    
    XCTAssertEqual(1, [removedSecond.value intValue]);
    XCTAssertEqual(2, [[list head].next.value intValue]);
}

- (void)testStacks {
    
    JVStack *stack = [[JVStack alloc] init];
    
    [stack push:@1];
    [stack push:@2];
    
    id poppedTwo = [stack pop];
    XCTAssertEqual(@2, poppedTwo);
    
    [stack push:@3];
    
    while (![stack isEmpty]) {
        [stack pop];
    }
    
    XCTAssertTrue([stack isEmpty]);
}

- (void)testQueues {
    
    JVQueue *queue = [[JVQueue alloc] init];
    
    [queue enqueue:@1];
    [queue enqueue:@2];
    
    id dequeuedTwo = [queue dequeue];
    XCTAssertEqual(@1, dequeuedTwo);
}

- (void)testTrees {
    
    JVTree *tree = [JVTree createTreeWithRoot:@(1)];
    
    [tree addValue:@2];
    [tree addValue:@3];
    [tree addValue:@4];
    
    JVTree *two = [tree findValue:@2 withSearchMethod:BreadthFirst];
    [two addValue:@5];
    [two addValue:@6];
    [two addValue:@7];
    
    JVTree *three = [tree findValue:@3 withSearchMethod:BreadthFirst];
    [three addValue:@8];
    [three addValue:@9];
    
    JVTree *four = [tree findValue:@4 withSearchMethod:BreadthFirst];
    [four addValue:@10];
    
    [tree traverseWithAction:^(JVTree *next) {
        NSLog(@"%@", next.root);
    }];
    
    JVTree *foundWidth = [tree findValue:@7 withSearchMethod:BreadthFirst];
    JVTree *foundDepth = [tree findValue:@7 withSearchMethod:DepthFirst];
    
    
    NSLog(@"After deletion");
    
    
    [tree traverseWithAction:^(JVTree *next) {
        NSLog(@"%@", next.root);
    }];
    
    XCTAssertNotNil(foundDepth);
    XCTAssertNotNil(foundWidth);
}

@end
