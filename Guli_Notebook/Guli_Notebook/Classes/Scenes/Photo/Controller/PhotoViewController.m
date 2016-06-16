//
//  PhotoViewController.m
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoView.h"
#import "CollectionViewCell.h"
#import "PhotoFlowLayout.h"
#import "PhotoModel.h"
#import "MJExtension.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,PhotoFlowLayoutDelegate,didRemovePictureDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property(nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic, assign)CGRect transformedFrame;
@property (nonatomic, strong)UIImageView *lookImg;
@property (nonatomic , strong)PhotoView* photoView;
@property (nonnull, strong)PhotoFlowLayout *layOut;


@end

@implementation PhotoViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"照片墙";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[UIColor whiteColor], UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,nil]];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.hidden = YES;
    _layOut = [[PhotoFlowLayout alloc] init];
//    _collection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:_layOut];
    _collection.delegate = self;
    _collection.dataSource = self;
    
    _layOut.degelate = self;
    [_collection setCollectionViewLayout:_layOut];
    _collection.backgroundColor = [UIColor whiteColor];
    //初始化数据
    NSArray * arr = [PhotoModel objectArrayWithFilename:@"1.plist"];
    //注册
    [_collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.dataArr addObjectsFromArray:arr];
    [self.view addSubview:_collection];
    NSLog(@"%@",self.dataArr);
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //cell注册
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setModel:_dataArr[indexPath.row]];
    NSLog(@"%@",NSStringFromCGRect(cell.frame));
    return cell;
}

-(CGFloat)Flow:(PhotoFlowLayout *)Flow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath{
    PhotoModel *model = self.dataArr[indexPath.row];
    return  model.h/model.w*width;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_lookImg) {
        return;
    }
    PhotoModel *model = _dataArr[indexPath.row];
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    _transformedFrame = [cell convertRect:cell.image.frame toView:[UIApplication sharedApplication].keyWindow];
    _lookImg = [[UIImageView alloc]initWithFrame:_transformedFrame];
    _lookImg.image = cell.image.image;
    [[UIApplication sharedApplication].keyWindow addSubview:_lookImg];
    [UIView animateWithDuration:0.1 animations:^{
        _lookImg.frame = CGRectMake(10, 40, SCREEN_WIDTH - 20, model.h / model.w * (SCREEN_WIDTH - 20));
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        _photoView = [[PhotoView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
        [_photoView initWithPicArray:_dataArr picNo:indexPath.row];
        _photoView.removeDelegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:_photoView];
        
    }];
}

-(void)didremovePicture:(NSMutableArray *)shopArr{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    NSInteger i =   _photoView.scrollView.contentOffset.x / SCREEN_WIDTH;
    CollectionViewCell *cell = (CollectionViewCell *)[_collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    _transformedFrame = [cell.superview convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];
    _lookImg.image = cell.image.image;
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 1;
        _lookImg.frame = _transformedFrame;
    } completion:^(BOOL finished) {
        [_lookImg removeFromSuperview];
        _lookImg = nil;
        _dataArr = [NSMutableArray arrayWithArray:shopArr];
        [_collection reloadData];
    }];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)deletePicture:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    [_collection reloadData];
}




//- (void)awakeFromNib {
//    UICollectionViewFlowLayout * layout=[UICollectionViewFlowLayout alloc];
//    self.collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
//    self.collection.delegate=self;
//    self.collection.dataSource=self;
//    self.collection.backgroundColor=[UIColor whiteColor];
//    [self.view  addSubview:self.collection];
//    
//    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    
//}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 4;
//}
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    
//    
//    return cell;
//}
////布局
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 20;
//}
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(120, 120);
//}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    
//    
//}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
