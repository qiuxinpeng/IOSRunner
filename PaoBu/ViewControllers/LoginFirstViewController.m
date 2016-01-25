//
//  LoginFirstViewController.m
//  NewBaLa
//
//  Created by Mr.Qiu on 15/8/10.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "LoginFirstViewController.h"
//#import "NSTimer+BlocksKit.h"
//#import "LoginViewController.h"
//#import "LoginSecondViewController.h"
//#import "SVWebViewController.h"
//#import "SysInfoOBJ.h"

#define Max_Get_Code_Time 60

@interface LoginFirstViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewTextBackGround;
@property (weak, nonatomic) IBOutlet UITextField *textField_Mobile;//手机号
@property (weak, nonatomic) IBOutlet UITextField *textField_Code;//验证码

@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *btnNext;//下一步

@end

@implementation LoginFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户注册";
}

////协议
//- (IBAction)xieyiAction:(id)sender {
//    SVWebViewController *webVC=[[SVWebViewController alloc] initWithAddress:[SysInfoOBJ sharedInfo].useagreement];
//    webVC.view.backgroundColor=[UIColor colorWithHexString:@"F2F2F2"];
//    [self.navigationController pushViewController:webVC animated:YES];
//}

//获取验证码
- (IBAction)btnGetCodeAction:(id)sender {
    if (self.textField_Mobile.text.trim.isNilOrEmpty) {
        [UIAlertView say:@"请输入手机号!"];
        return;
    }
    
    [self.textField_Mobile resignFirstResponder];
    [self.textField_Code resignFirstResponder];
    
    self.btnGetCode.enabled = NO;
}

//下一步
- (IBAction)btnNextAction:(id)sender {
    
//    LoginSecondViewController *secondVC = [[LoginSecondViewController alloc] initWithNibName:@"LoginSecondViewController" bundle:nil];
//    
//    [self pushVC:secondVC animated:YES];
//    
//    return;
    
    if (self.textField_Mobile.text.trim.isNilOrEmpty) {
        [UIAlertView say:@"请输入手机号!"];
        return;
    }else if (self.textField_Code.text.trim.isNilOrEmpty) {
        
        [UIAlertView say:@"请输入密码!"];
        return;
    }
    
    [self.textField_Mobile resignFirstResponder];
    [self.textField_Code resignFirstResponder];
    
    [[BBInterFace interfaceWithFinshBlock:^(PBUser *responseObje) {
        [responseObje synchronize];
        [PBUser changeWithUser:responseObje];
        [PBUser lginOK];
        NSLog(@"responseObje:%@",responseObje);
        
        [self dismissVC:YES];
        if (self.loginCallBlock) {
            self.loginCallBlock(YES,self);
        }
        
    } faildBlock:^(NSError *err) {
        
    } HUDBackgroundView:self.view tag:self.tagWithInterFace] UserLogin:self.textField_Mobile.text password:self.textField_Code.text];
}

//账号登陆
//- (IBAction)btnLoginAction:(id)sender {
//
//    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    
//    [loginVC setLoginCallBlock:^(BOOL loginOK) {
//        [self dismissVC:NO];
//
//        if (self.loginCallBlock) {
//            self.loginCallBlock(YES,self);
//        }
//    }];
//    
//    [self pushVC:loginVC animated:YES];
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
