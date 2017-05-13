//
//  ViewController.h
//  test
//
//  Created by Rob Mayoff on 5/13/17.
//  Copyright © 2017 Rob Mayoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Record;

@interface ViewController : UITableViewController

- (void)expandedPropertyDidChangeInRecord:(Record *_Nonnull)record;

@end
