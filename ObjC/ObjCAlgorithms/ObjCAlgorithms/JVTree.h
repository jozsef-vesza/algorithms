//
//  JVTree.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 22/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SearchType) {
    BreadthFirst,
    DepthFirst
};

@interface JVTree : NSObject

@property (nonatomic, strong) id root;

+ (instancetype)createTreeWithRoot:(id)root;
+ (instancetype)addValue:(id)newValue toTree:(JVTree *)tree;
+ (instancetype)deleteValue:(id)value fromTree:(JVTree *)tree;
+ (void)traverseTree:(JVTree *)tree withAction:(void (^)(JVTree *current))action;
+ (instancetype)findValue:(id)value inTree:(JVTree *)tree withSearchMethod:(SearchType)searchType;

- (instancetype)initWithRoot:(id)root;
- (instancetype)addValue:(id)newValue;
- (instancetype)deleteValue:(id)value;
- (void)traverseWithAction:(void (^)(JVTree *current))action;
- (instancetype)findValue:(id)value withSearchMethod:(SearchType)searchType;
- (NSSet *)getSubTree;

@end
