//
//  HostViewController.m
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "HostViewController.h"
#import "HostDetailedViewController.h"
#import "HostTableViewCell.h"
#import <FMDB.h>
#import "AppDelegate.h"
#import "AllenNSTextAttachment.h"

@interface HostViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *noteListTableView;

//存标题的数组
@property(nonatomic,strong)NSMutableArray *titleArr;
//存内容的数组
@property(nonatomic,strong)NSMutableArray *summaryArr;
//存图片的数组
@property(nonatomic,strong)NSMutableArray *imageArr;
//存时间的数组
@property(nonatomic,strong)NSMutableArray *dateArr;
//存位置的数组
@property(nonatomic,strong)NSMutableArray *locationArr;
//存放ID的数组
@property(nonatomic,strong)NSMutableArray *idArr;

@end

@implementation HostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[UIColor whiteColor], UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,nil]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑.png"] style:UIBarButtonItemStyleDone target:self action:@selector(barButtonAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

    _noteListTableView.dataSource = self;
    _noteListTableView.delegate = self;
    //注册
    [_noteListTableView registerNib:[UINib nibWithNibName:@"HostTableViewCell" bundle:nil] forCellReuseIdentifier:@"HostListCell"];
    
//    [self getData];

}
-(void)viewWillAppear:(BOOL)animated{
    _titleArr = [NSMutableArray array];
    _summaryArr = [NSMutableArray array];
    _imageArr = [NSMutableArray array];
    _dateArr = [NSMutableArray array];
    _locationArr = [NSMutableArray array];
    _idArr = [NSMutableArray array];
    [self getData];
    [self.noteListTableView reloadData];
}


#pragma mark DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

//获取数据库数据
-(void)getData{
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
        //创建SQL语句
        NSString *sqlStr = @"SELECT * FROM GULI";
        //执行SQL语句
        FMResultSet *resultSet = [appDelegate.db executeQuery:sqlStr];
        while ([resultSet next]) {
            //将对应的字段存到相应的数组中
            NSString *title = [resultSet stringForColumn:@"G_TITLE"];
            NSString *summary = [resultSet stringForColumn:@"G_SUMMARY"];
            
            NSString *image = [resultSet stringForColumn:@"G_IMAGE"];//要想存多个图片在一个心情中，可能需要数组来存储
            NSString *date = [resultSet stringForColumn:@"G_DATE"];
            NSInteger location = [resultSet intForColumn:@"G_LOCATION"];
            NSInteger noteID = [resultSet intForColumn:@"G_ID"];
            [_titleArr addObject:title];
            [_summaryArr addObject:summary];
            [_imageArr addObject:image];
            [_dateArr addObject:date];
            [_locationArr addObject:[NSString stringWithFormat:@"%ld",location]];
            [_idArr addObject:[NSString stringWithFormat:@"%ld",noteID]];
        }
        [appDelegate.db close];
    }
    else{
        NSLog(@"数据库打开失败");
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HostListCell";
    HostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [self.noteListTableView dequeueReusableCellWithIdentifier:@"HostListCell" forIndexPath:indexPath];
    }
    cell.titleLabel.text = _titleArr[indexPath.row];
    cell.dateLabel.text = _dateArr[indexPath.row];
//    cell.backgroundColor = [UIColor purpleColor];
    return cell;
    
}



#pragma mark Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HostDetailedViewController *HostDVC = [[HostDetailedViewController alloc]init];
    HostDVC.isEdit = YES;
    
    NSLog(@"%@",_summaryArr);
    
    HostDVC.titleStr = _titleArr[indexPath.row];
    HostDVC.summaryStr = _summaryArr[indexPath.row];
    HostDVC.location = _locationArr[indexPath.row] ;
    HostDVC.imageData = _imageArr[indexPath.row];
    HostDVC.noteID = _idArr[indexPath.row];
    
    [self presentViewController:HostDVC animated:YES completion:nil];
}

-(void)barButtonAction{
    HostDetailedViewController *VC = [[HostDetailedViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}
















@end
