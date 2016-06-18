//
//  HostTableViewCell.m
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/16.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "HostTableViewCell.h"

@implementation HostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeBall.layer.masksToBounds = YES;
    self.timeBall.layer.cornerRadius = self.timeBall.frame.size.width / 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
