//
//  CalendarViewController.m
//  Guli_Notebook
//
//  Created by Borjigin Odongua on 16/6/13.
//  Copyright © 2016年 Borjigin Odongua. All rights reserved.
//

#import "CalendarViewController.h"
#import "SZCalendarPicker.h"

#import "SZTableViewController.h"

@interface CalendarViewController ()<UICollectionViewDelegate>

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
    calendarPicker.collectionView.delegate = self;
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    calendarPicker.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 10) {
        SZTableViewController *sVC = [SZTableViewController new];
        [self.navigationController pushViewController:sVC animated:YES];
    }
    
    
    
}


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
