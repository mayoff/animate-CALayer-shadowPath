//
//  Record.h
//  test
//
//  Created by Rob Mayoff on 5/13/17.
//  Copyright © 2017 Rob Mayoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject

- (instancetype _Nonnull)initWithName:(NSString *_Nonnull)name;

@property (nonatomic, copy) NSString *_Nonnull name;
@property (nonatomic) BOOL expanded;

@end
