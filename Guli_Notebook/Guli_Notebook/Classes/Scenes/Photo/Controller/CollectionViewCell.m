//
//  CollectionViewCell.m
//  Guli_Notebook
//
//  Created by lanou3g on 16/6/15.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
}

-(void)setModel:(PhotoModel *)model
{
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:_model.img]];
}


@end
