//
//  AppDelegate.m
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "DrawerViewController.h"
#import "MyPageController.h"
#import <FMDB.h>

static AppDelegate *appDelegate = nil;
@interface AppDelegate ()

@property(nonatomic,strong)FMDatabase *db;

@end

@implementation AppDelegate

//AppDelegate单例
-(instancetype)sharedAppDelegate{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appDelegate = [[AppDelegate alloc]init];
    });
    return appDelegate;
}

-(void)setDatabase{
    //获取数据库地址
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接地址
    NSString *dbPath = [docPath stringByAppendingString:@"/Guli_Notebook.sqlite"];
    NSLog(@"%@",dbPath);
    //创建数据库
    _db = [FMDatabase databaseWithPath:dbPath];
    //打开数据库
    [_db open];
    //创建表
    if ([_db open]) {
        NSLog(@"数据库打开成功");
        //创建数据库的SQL语句
        NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS GULI(G_ID TEXT PRIMARY KEY,G_TITLE TEXT,G_SUMMARY TEXT,G_ADDRESS TEXT,G_DATE TEXT,G_TIME TEXT,G_IMAGE DATA,G_VIDEO DATA,G_VOICE DATA)";
        //执行SQL语句
        BOOL isCreate = [_db executeUpdate:sqlStr];
        if (isCreate) {
            NSLog(@"创建表成功");
        }
        else{
            NSLog(@"创建表失败");
        }
        //关闭数据库
        [_db close];
    }
    else{
        NSLog(@"数据库打开失败");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController *rootVC = [[RootViewController alloc]init];
    MyPageController *myPageVC = [[MyPageController alloc]init];
    
//    self.window.rootViewController = rootVC;
    self.drawerVC = [[DrawerViewController alloc] initWithLeftView:myPageVC andMainView:rootVC];
    [self.window setRootViewController:self.drawerVC];
    [self.window makeKeyAndVisible];
    [self setDatabase];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
