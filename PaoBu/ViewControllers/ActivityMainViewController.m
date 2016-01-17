//
//  ActivityMainViewController.m
//  PaoBu
//
//  Created by 邱玲 on 15/8/28.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "ActivityMainViewController.h"

@interface ActivityMainViewController ()

@end

@implementation ActivityMainViewController
- (NSString *)tabImageName
{
    return @"cion4.png";
}
- (NSString *)tabTitle
{
    return @"活动";
}
- (NSString *)activeTabImageName
{
    return @"cion4.png";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar=YES;

    // Do any additional setup after loading the view from its nib.
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
