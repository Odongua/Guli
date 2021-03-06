//
//  RootViewController.m
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "RootViewController.h"
#import "Color_macro.h"
#import "UIImage+imageContentWithColor.h"

#import "CalendarViewController.h"
#import "HostViewController.h"
#import "PhotoViewController.h"
#import "AppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置主题颜色
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR]];
    
    //设置 tabbar 文本的标题颜色
    [self setTabBarTextAtrribute];
    //添加3个子视图控制器
    [self createChildViewController];
    
}

//设置 tabbar 文本的标题颜色
- (void)setTabBarTextAtrribute{
    //设置普通状态下,文本标题颜色
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //设置选中状态下,文本标题颜色
    NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
    selectDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    //配置文本属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
}

-(void)addOneChildViewController:(UIViewController *)viewController Title:(NSString *)title NormalImage:(NSString *)normalImg SelectedImage:(NSString *)selectImg{
//显示
//    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(showMyPage)];
    
    
    //给子视图控制器的 tabbarItem 赋值
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:normalImg];
    UIImage *image = [UIImage imageNamed:selectImg];
    //设置渲染模式
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//渲染图片本身的样子
    viewController.tabBarItem.selectedImage = image;
    //把子视图控制器添加上去
    [self addChildViewController:viewController];
}

-(void)showMyPage{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.drawerVC openLeftView];
}

//添加3个子视图控制器
-(void)createChildViewController{
    //主页
    HostViewController *hostVC = [[HostViewController alloc]init];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:hostVC] Title:@"主页" NormalImage:@"" SelectedImage:@""];

    hostVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStylePlain target:self action:@selector(showMyPage)];
    hostVC.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    //日历
    CalendarViewController *calendarVC = [[CalendarViewController alloc]init];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:calendarVC] Title:@"日历" NormalImage:@"" SelectedImage:@""];
    
    calendarVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStylePlain target:self action:@selector(showMyPage)];
    calendarVC.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    //图片墙
    PhotoViewController *photoVC = [[PhotoViewController alloc]init];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:photoVC] Title:@"照片墙" NormalImage:@"" SelectedImage:@""];

    photoVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStylePlain target:self action:@selector(showMyPage)];
    photoVC.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
}


@end
