//
//  CollectionViewCell.h
//  Guli_Notebook
//
//  Created by Allen on 16/6/15.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property(nonatomic,strong)PhotoModel *model;

@end
