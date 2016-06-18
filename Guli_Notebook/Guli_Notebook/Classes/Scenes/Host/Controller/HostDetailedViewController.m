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
#import <FMDB.h>
#import "AppDelegate.h"



@interface HostDetailedViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic, assign) RWDropdownMenuStyle menuStyle;



//图片选择器
@property (nonatomic, strong)UIImagePickerController *imgPicker;

@property (nonatomic, strong)UIImage *img;


@property (nonatomic,strong)FMDatabase *db;
//存当前心情的图片
@property (nonatomic,strong)NSMutableArray *imagesArr;

@property (nonatomic,strong)AllenNSTextAttachment *attachment;

@property (nonatomic,assign)NSInteger location1;

@end

@implementation HostDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:97/255.0 green:210/255.0 blue:246/255.0 alpha:1.0];
    
    //初始化图片选择器
    _imgPicker = [[UIImagePickerController alloc] init];
    //设置代理
    _imgPicker.delegate = self;
    
    _attachment = [[AllenNSTextAttachment alloc]init];
    _titleTextField.text = _titleStr;
    _summaryTextView.text = _summaryStr;
}
-(void)viewWillAppear:(BOOL)animated{
//    NSLog(@"%@",_imageData);
    //初始化图片数组
    _imagesArr = [NSMutableArray array];
    if (_isEdit == YES) {
        if (![_imageData isEqualToString:@"(null)"]) {
            //1.首先创建一个NSTextAttachment对象，这个对象有一个image属性，可以将需要显示的图片赋值给这个属性
            AllenNSTextAttachment *allenNSTextAttachment = [AllenNSTextAttachment new];
            allenNSTextAttachment.imgSize = CGSizeMake(_summaryTextView.frame.size.width, 0);
            NSData *imgData = [[NSData alloc] initWithBase64Encoding:_imageData];
            UIImage *IMG = [UIImage imageWithData:imgData];
            allenNSTextAttachment.image = IMG;
            //2.在任意位置添加图片
            [_summaryTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:allenNSTextAttachment] atIndex:[_location intValue]];
            NSLog(@"%@",_location);
        }
        else{
            _titleTextField.text = _titleStr;
            _summaryTextView.text = _summaryStr;
        }
    }
}
//返回主页
- (IBAction)backAction:(UIBarButtonItem *)sender {
    
    NSString *dateAndTime = [self getSystemTime];
    
    
    //获取数据库地址
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接地址
    NSString *dbPath = [docPath stringByAppendingString:@"/Guli_Notebook.sqlite"];
    NSLog(@"%@",dbPath);
    AppDelegate *appDelegate = [[AppDelegate alloc]init];
    appDelegate.db = [FMDatabase databaseWithPath:dbPath];
    //打开数据库
    [appDelegate.db open];
    
    if ([appDelegate.db open]) {
        NSLog(@"数据库打开成功");
        if (_isEdit == YES) {
            //将图片转换成DATA类型
            NSData *imageData = UIImageJPEGRepresentation(_img, 1);
            NSString *imgStr = [imageData base64Encoding];
            //创建SQL语句
            NSString *sqlStr = [NSString stringWithFormat:@"UPDATE GULI SET G_TITLE = '%@',G_SUMMARY = '%@',G_DATE = '%@' WHERE G_ID = '%ld'",_titleTextField.text,_summaryTextView.text,dateAndTime,[_noteID integerValue]];
            //执行SQL语句
            BOOL isUpdate = [appDelegate.db executeUpdate:sqlStr];
            if (isUpdate) {
                NSLog(@"数据更新成功");
            }
            else{
                NSLog(@"数据更新失败");
            }
            
        }else{
            //将图片转换成DATA类型
            NSData *imageData = UIImageJPEGRepresentation(_img, 1);
            NSString *imgStr = [imageData base64Encoding];
            //创建SQL语句
            NSString *sqlStr =[NSString stringWithFormat: @"INSERT INTO GULI(G_TITLE,G_SUMMARY,G_IMAGE,G_DATE,G_LOCATION) VALUES('%@','%@','%@','%@','%ld')",_titleTextField.text,_summaryTextView.text,imgStr,dateAndTime,(long)_location1];
            //执行sql语句
            BOOL isInsert = [appDelegate.db executeUpdate:sqlStr];
            if (isInsert) {
                NSLog(@"添加成功");
            }
            else{
                NSLog(@"添加失败");
            }
        }
        [appDelegate.db close];
        
    }
    else{
        NSLog(@"打开数据库失败");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取系统时间
-(NSString *)getSystemTime{
    NSDate *getDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSString *locationString = [formatter stringFromDate:getDate];
    
    NSLog(@"--------------%@",locationString);

    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents *component = [cal components:unitFlags fromDate:getDate];
    NSInteger year = [component year];
    NSInteger month = [component month];
    NSInteger day = [component day];
    NSString *nsDateString = [NSString stringWithFormat:@"%4ld-%02ld-%02ld",(long)year,(long)month,(long)day];
    NSLog(@"------------%@------------",nsDateString);
    
    //拼接字符串
//    NSString *dateAndTime = [locationString stringByAppendingString:nsDateString];
    return nsDateString;
}
//添加按钮
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

- (NSArray *)menuItems
{
    if (!_menuItems)
    {
        _menuItems =
        @[
          [RWDropdownMenuItem itemWithText:@"视频" image:[UIImage imageNamed:@"视频"] action:nil],
          [RWDropdownMenuItem itemWithText:@"录音" image:[UIImage imageNamed:@"录音"] action:nil],
          [RWDropdownMenuItem itemWithText:@"照片" image:[UIImage imageNamed:@"照片"] action:^{
              __weak typeof(self) weakSelf = self;
              
                  //指定资源类型为相册获取图片
                  _imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                  _imgPicker.allowsEditing = YES;
                  [weakSelf presentViewController:_imgPicker animated:YES completion:nil];

          }],
          ];
    }
    return _menuItems;
}
#pragma mark UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _isEdit = NO;
    //获取到我们选择的图片
    _img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //1.首先创建一个NSTextAttachment对象，这个对象有一个image属性，可以将需要显示的图片赋值给这个属性
    AllenNSTextAttachment *allenNSTextAttachment = [AllenNSTextAttachment new];
    allenNSTextAttachment.imgSize = CGSizeMake(_summaryTextView.frame.size.width, 0);
    
    allenNSTextAttachment.image = _img;
    _attachment = allenNSTextAttachment;
    //2.在任意位置添加图片
    [_summaryTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:allenNSTextAttachment] atIndex:_summaryTextView.selectedRange.location];
    _location1 = _summaryTextView.selectedRange.location;
    //隐藏图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)saveImage{
    NSLog(@"图片存进去了");
}

@end
