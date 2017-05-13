//
//  RecordCell.m
//  test
//
//  Created by Rob Mayoff on 5/13/17.
//  Copyright © 2017 Rob Mayoff. All rights reserved.
//

#import "RecordCell.h"
#import "Record.h"
#import "ViewController.h"

@interface RecordCell ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UISwitch *expansionSwitch;
@property (strong, nonatomic) IBOutlet UIView *box;
@end

@implementation RecordCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.box.layer.cornerRadius = 8;
}

- (void)setRecord:(Record *)record {
    _record = record;
    self.label.text = record.name;
    self.expansionSwitch.on = record.expanded;
}

- (IBAction)switchValueChanged:(id)sender {
    if (_record == nil) { return; }

    self.record.expanded = self.expansionSwitch.isOn;

    UIResponder *candidate = self;
    while (candidate != nil && ![candidate isKindOfClass:[ViewController class]]) {
        candidate = candidate.nextResponder;
    }

    if (candidate != nil) {
        ViewController *vc = (ViewController *)candidate;
        [vc expandedPropertyDidChangeInRecord:self.record];
    }
}

@end
