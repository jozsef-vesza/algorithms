//
//  JVStack.m
//  ObjCAlgorithms
//
//  Created by József Vesza on 14/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

#import "JVStack.h"

@interface JVStack ()

@property (nonatomic, strong) NSMutableArray *values;

@end

@implementation JVStack

- (instancetype)init {
    self = [super init];
    if (self) {
        self.values = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push:(id)newValue {
    [self.values addObject:newValue];
}

- (id)pop {
    id value = [self.values lastObject];
    [self.values removeLastObject];
    
    return value;
}

@end
