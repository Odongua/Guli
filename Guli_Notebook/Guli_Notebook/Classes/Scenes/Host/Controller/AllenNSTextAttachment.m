//
//  AllenNSTextAttachment.m
//  Guli_Notebook
//
//  Created by iOS on 16/6/15.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "AllenNSTextAttachment.h"

@implementation AllenNSTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    return [self scaleImageSizeToWidth:_imgSize.width];
}

- (CGRect)scaleImageSizeToWidth:(CGFloat)width{
    //缩放系数
    CGFloat factor = 1.0;
    //获取原本图片大小
    CGSize oriSize = [self.image size];
    //计算缩放系数
    factor = (CGFloat)(width/oriSize.width);
    //创建新的Size
    CGRect newSize = CGRectMake(0, 0, oriSize.width * factor - 10, oriSize.height * factor);
    return newSize;
}

@end
