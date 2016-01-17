//
//  ZhouBianCell.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/16.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhouBianCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UIImageView *img_img1;
@property (weak, nonatomic) IBOutlet UIImageView *img_img2;
@property (weak, nonatomic) IBOutlet UIImageView *img_img3;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_pinglun;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;
- (void)reloadWihtOBJ:(getNearbyInfoOBJ *)OBJ;
@end
