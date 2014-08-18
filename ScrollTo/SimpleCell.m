//
//  SimpleCell.m
//  ScrollTo
//
//  Created by Hubert Kunnemeyer on 8/16/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "SimpleCell.h"

@implementation SimpleCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor lightGrayColor];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 60)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor darkTextColor];
    _label.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self.contentView addSubview:_label];

    return self;
}
@end
