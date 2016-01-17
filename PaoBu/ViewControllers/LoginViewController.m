//
//  LoginViewController.m
//  NewBaLa
//
//  Created by Mr.Qiu on 15/8/10.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "LoginViewController.h"

#import "SVWebViewController.h"
#import "SysInfoOBJ.h"
#import "LoginSecondViewController.h"
@interface LoginViewController ()



@property (weak, nonatomic) IBOutlet UIView *viewTextBackGround;

@property (weak, nonatomic) IBOutlet UITextField *textField_Account;//账号

@property (weak, nonatomic) IBOutlet UITextField *textField_Password; //密码



@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"欢迎回家";
}

- (IBAction)loginAction:(id)sender {
    
    
    if (self.textField_Account.text.trim.isNilOrEmpty) {
        [UIAlertView say:@"请输入手机号!"];
        return;
    }else if (self.textField_Password.text.trim.isNilOrEmpty) {
        
        [UIAlertView say:@"请输入验证码!"];
        return;
    }
    
    [self.textField_Account resignFirstResponder];
    [self.textField_Password resignFirstResponder];
    
    
        
    
}

- (IBAction)forgetPasswordAction:(id)sender {
    
    
    SVModalWebViewController *webVC=[[SVModalWebViewController alloc] initWithAddress:[SysInfoOBJ sharedInfo].forgotpwd];
    webVC.view.backgroundColor=[UIColor colorWithHexString:@"F2F2F2"];
    
    [self presentVC:webVC animated:YES];
    
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
