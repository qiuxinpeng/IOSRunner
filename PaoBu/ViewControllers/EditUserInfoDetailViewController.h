//
//  EditUserInfoDetailViewController.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/3.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "BaseViewController.h"

@interface EditUserInfoDetailViewController : BaseViewController
@property(nonatomic, assign)UserEditType type;
@property (weak, nonatomic) IBOutlet UITextView *textV_text;

@end
