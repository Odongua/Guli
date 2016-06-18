//
//  PhotoView.h
//  Guli_Notebook
//
//  Created by Allen on 16/6/15.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@protocol didRemovePictureDelegate <NSObject>

-(void)didremovePicture:(NSMutableArray *)dataArr;
-(void)deletePicture:(NSMutableArray *)dataArr;

@end

@interface PhotoView : UIView

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, assign)id<didRemovePictureDelegate>removeDelegate;

/**
 *  初始化方法
 *
 *  @param array  照片数组
 *  @param number 第几张照片
 */
-(void)initWithPicArray:(NSMutableArray *)array
                  picNo:(NSInteger)number;


@end
