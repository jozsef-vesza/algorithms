//
//  JVBucket.h
//  ObjCAlgorithms
//
//  Created by József Vesza on 10/01/15.
//  Copyright (c) 2015 Jozsef Vesza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVBucket : NSObject

- (instancetype)initWithValue:(id)value;
- (void)setValue:(id)value;
- (id)getValue:(id)value;

@end
