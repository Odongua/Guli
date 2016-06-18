//
//  PhotoFlowLayout.h
//  Guli_Notebook
//
//  Created by lanou3g on 16/6/15.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoFlowLayout;
@protocol PhotoFlowLayoutDelegate <NSObject>
/**
 *  这个代理方法用于在viewcontroller中通过Width来计算高度
 *
 *  @param Flow      flowlayout
 *  @param width     图片的宽
 *  @param indexPath indexPath
 *
 *  @return 图片的高
 */
-(CGFloat)Flow:(PhotoFlowLayout *)Flow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@end
@interface PhotoFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,assign)CGFloat rowMagrin;//行间距
@property(nonatomic,assign)CGFloat colMagrin;//列间距
@property(nonatomic,assign)CGFloat colCount;//多少列
@property(nonatomic,weak)id<PhotoFlowLayoutDelegate>degelate;

@end
