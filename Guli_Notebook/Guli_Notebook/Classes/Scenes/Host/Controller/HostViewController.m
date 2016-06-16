//
//  HostViewController.m
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "HostViewController.h"
#import "HostDetailedViewController.h"
@interface HostViewController ()

@end

@implementation HostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[UIColor whiteColor], UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,nil]];
    
}



- (IBAction)action:(UIButton *)sender {
    HostDetailedViewController *VC = [[HostDetailedViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}















@end
