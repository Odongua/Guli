//
//  HostDetailedViewController.h
//  Guli_Notebook
//
//  Created by iOS on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostDetailedViewController : UIViewController
//标题
@property (nonatomic,copy) NSString *titleStr;
//内容
@property (nonatomic,copy) NSString *summaryStr;
//图片
@property (nonatomic,copy) NSString *imageData;
//位置
@property (nonatomic,copy) NSString *location;
//ID
@property (nonatomic,copy) NSString *noteID;

//内容
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
//标题
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
//判断是不是点击cell进入到这个页面
@property (nonatomic,assign)BOOL isEdit;

@end
