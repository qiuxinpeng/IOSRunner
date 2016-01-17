//
//  ADFirstViewController.m
//  NewBaLa
//
//  Created by Mr.Qiu on 15/8/10.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "ADFirstViewController.h"
#import "BaseNavigationController.h"
#import "LoginFirstViewController.h"

@interface ADFirstViewController ()

@end

@implementation ADFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor redColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self showMainViewController];
        if ([PBUser isLogin]) {
            [self showMainViewController];
        }else{
            [self login:^(BOOL isLogin, LoginFirstViewController *loginVC) {
                if (isLogin) {
                    [self showMainViewController];
                }
            }];
        }
    });
}

- (void)showLoginViewController{
    LoginFirstViewController *VCfirstLogin=[[LoginFirstViewController alloc]initWithNibName:@"LoginFirstViewController" bundle:nil];
    
    [VCfirstLogin setLoginCallBlock:^(BOOL isLogin, LoginFirstViewController *VCLogin) {
        if (isLogin) {
            VCLogin=nil;
            QXPDispatch_after(0.5, ^{
                [self showMainViewController];
            });
        }
    }];
    BaseNavigationController  *nav=[[BaseNavigationController alloc]initWithRootViewController:VCfirstLogin];
    
    [self presentViewController:nav animated:NO completion:^{
        
    }];;
    VCfirstLogin=nil;
    nav=nil;
}

- (void)loginOut{
    
}

/**
 *  登陆成功显示主页
 */
- (void)showMainViewController{
    MainViewController  *VCMain=[[MainViewController alloc]init];
    // VCMain.delegate=self;
    [MainManager manager].VCMain=VCMain;
    
    [self presentViewController:VCMain animated:NO completion:^{
        
    }];
    
    //[[[UIApplication sharedApplication] keyWindow] setRootViewController:VCMain];
    //    QXPDispatch_after(0.2, ^{
    //        [VCMain showTabBarAnimated:YES];
    //
    //    });
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
