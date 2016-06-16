//
//  HostDetailedViewController.m
//  Guli_Notebook
//
//  Created by iOS on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "HostDetailedViewController.h"
#import "HostViewController.h"
#import "RWDropdownMenu.h"
#import <AFNetworking.h>
#import "AllenNSTextAttachment.h"

@interface HostDetailedViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic, assign) RWDropdownMenuStyle menuStyle;

@property (nonatomic, strong)NSTextAttachment *attachment;
//图片选择器
@property (nonatomic, strong)UIImagePickerController *imgPicker;

@property (nonatomic, strong)UIImage *img;

@end

@implementation HostDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:97/255.0 green:210/255.0 blue:246/255.0 alpha:1.0];
    
    //初始化图片选择器
    _imgPicker = [[UIImagePickerController alloc] init];
    //设置代理
    _imgPicker.delegate = self;
    
//    //添加一个编辑按钮,进入编辑页面
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑"] style:UIBarButtonItemStyleDone target:self action:@selector(editingAction)];
//    //改变编辑按钮颜色
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

//返回主页
- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//加入手势右边返回主页
- (IBAction)backSwiperGestureRecognizer:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//添加进入下拉菜单
- (IBAction)AddAction:(UIBarButtonItem *)sender {
    RWDropdownMenuCellAlignment alignment = RWDropdownMenuCellAlignmentCenter;
    if (sender == self.navigationItem.leftBarButtonItem)
    {
        alignment = RWDropdownMenuCellAlignmentLeft;
    }
    else
    {
        alignment = RWDropdownMenuCellAlignmentRight;
    }
    
    [RWDropdownMenu presentFromViewController:self withItems:self.menuItems align:alignment style:self.menuStyle navBarImage:[sender image] completion:nil];
}

//下拉菜单添加3个分组,并进入相册
- (NSArray *)menuItems{
    if (!_menuItems)
    {
        _menuItems =
        @[
          [RWDropdownMenuItem itemWithText:@"视频" image:[UIImage imageNamed:@"视频"] action:nil],
          [RWDropdownMenuItem itemWithText:@"录音" image:[UIImage imageNamed:@"录音"] action:nil],
          [RWDropdownMenuItem itemWithText:@"照片" image:[UIImage imageNamed:@"照片"] action:^{
              __weak typeof(self) weakSelf = self;
              //添加 AlertSheet
//              UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//              UIAlertAction *photoAC = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              
                  //指定资源类型为相册获取图片
                  _imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                  _imgPicker.allowsEditing = YES;
                  [weakSelf presentViewController:_imgPicker animated:YES completion:nil];
//              }];
//              
//              UIAlertAction *cameraAC = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                  //指定资源类型为照相机获取图片
//                  _imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                  _imgPicker.allowsEditing = YES;
//                  [weakSelf presentViewController:_imgPicker animated:YES completion:nil];
//              }];
//              
//              //取消操作
//              UIAlertAction *canceAC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//              
//              //把响应事件交给弹出
//              [alert addAction:photoAC];
//              [alert addAction:cameraAC];
//              [alert addAction:canceAC];
//              
//              [self presentViewController:alert animated:YES completion:nil];
          }],
          ];
    }
    return _menuItems;
}

#pragma mark UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取到我们选择的图片
    _img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    //1.首先创建一个NSTextAttachment对象，这个对象有一个image属性，可以将需要显示的图片赋值给这个属性
    AllenNSTextAttachment *allenNSTextAttachment = [AllenNSTextAttachment new];
    allenNSTextAttachment.imgSize = CGSizeMake(_textViewTest.frame.size.width, 0);
    
    allenNSTextAttachment.image = _img;    
    
    //2.在任意位置添加图片
    [_textViewTest.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:allenNSTextAttachment] atIndex:_textViewTest.selectedRange.location];
    
    //隐藏图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage{
    NSLog(@"图片存进去了");
}
















@end
