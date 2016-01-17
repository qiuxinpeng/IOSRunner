//
//  PingLunCell.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/15.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingLunCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_info;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_can;

@end
