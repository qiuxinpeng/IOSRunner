//
//  PhotoMainViewController.h
//  PaoBu
//
//  Created by 邱玲 on 15/8/28.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoMainViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_leibie;
@property (weak, nonatomic) IBOutlet UIButton *btn_city;
- (IBAction)btn_city_click:(UIButton *)sender;
- (IBAction)btn_leibie_click:(UIButton *)sender;

@end
