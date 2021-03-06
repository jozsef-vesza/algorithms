//
//  JVLinkedNode.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 22/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVLinkedNode : NSObject

@property (nonatomic, strong) id value;
@property (nonatomic, strong) JVLinkedNode *next;

- (instancetype)initWithValue:(id)value;
+ (instancetype)findValue:(id)value inList:(JVLinkedNode *)list;
+ (instancetype)insertValue:(id)value inList:(JVLinkedNode *)list;
+ (instancetype)deleteValue:(id)value fromList:(JVLinkedNode *)list;

@end
