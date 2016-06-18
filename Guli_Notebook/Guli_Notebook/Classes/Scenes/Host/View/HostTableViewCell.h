//
//  HostTableViewCell.h
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/16.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *timeBall;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
