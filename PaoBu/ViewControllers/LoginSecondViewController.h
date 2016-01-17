//
//  LoginSecondViewController.h
//  NewBaLa
//
//  Created by Mr.Qiu on 15/8/10.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginSecondViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *textF_nick;//昵称

@property (weak, nonatomic) IBOutlet UITextField *textF_guoji;//国籍

@property (weak, nonatomic) IBOutlet UITextField *textF_Muyu;//母语

@property (weak, nonatomic) IBOutlet UITextField *textF_xingbie;//性别


@property (weak, nonatomic) IBOutlet UITextField *textF_xingzuo;//星座

@property (weak, nonatomic) IBOutlet UITextField *textF_suozaidi;//所在地

@property (weak, nonatomic) IBOutlet UITextField *textF_yaoqingma;//邀请码


@property (weak, nonatomic) IBOutlet UILabel *lab_blaNo;//吧啦号
@property (weak, nonatomic) IBOutlet UIButton *btn_logo;//头像


@property (weak, nonatomic) IBOutlet UIButton *btn_OK;//确认

@property (nonatomic, copy)void (^loginCallBlock) (BOOL isLogin );

//头像
- (IBAction)btnLogoAction:(id)sender;

//确认
- (void)btnOKAction:(id)sender;

//跳过
- (IBAction)btnContuneAction:(id)sender;


@end
