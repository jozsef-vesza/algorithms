//
//  JVAddition.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 25/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JVLinkedNode;

@interface JVAddition : NSObject

+ (JVLinkedNode *)addNumber:(JVLinkedNode *)firstNumber toNumber:(JVLinkedNode *)secondNumber;

@end
