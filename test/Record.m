//
//  Record.m
//  test
//
//  Created by Rob Mayoff on 5/13/17.
//  Copyright © 2017 Rob Mayoff. All rights reserved.
//

#import "Record.h"

@implementation Record

- (instancetype)initWithName:(NSString *_Nonnull)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

@end
