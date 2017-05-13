//
//  ViewController.m
//  test
//
//  Created by Rob Mayoff on 5/13/17.
//  Copyright © 2017 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"
#import "Record.h"
#import "RecordCell.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSArray<Record *> *_records;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        NSString *names = @"Alice Barbara Cassandra Delia Eve Fran Gabrielle Henrietta Iris Janet Karen Linda Mary Nancy Opal Patricia Quinn Robin Siobahn Tracy";
        NSMutableArray *records = [NSMutableArray new];
        for (NSString *name in [names componentsSeparatedByString:@" "]) {
            [records addObject:[[Record alloc] initWithName:name]];
        }
        _records = [records copy];
    }
    return self;
}

- (void)expandedPropertyDidChangeInRecord:(Record *)record {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return _records.count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.record = _records[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _records[indexPath.row].expanded ? 100 : 64;
}

@end
