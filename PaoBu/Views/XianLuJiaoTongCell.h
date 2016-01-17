//
//  XianLuJiaoTongCell.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/15.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XianLuJiaoTongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_Ctime;
@property (weak, nonatomic) IBOutlet UILabel *lab_Ttime;
@property (weak, nonatomic) IBOutlet UILabel *lab_alllong;
@property (weak, nonatomic) IBOutlet UILabel *lab_alltime;
@property (weak, nonatomic) IBOutlet UILabel *lab_peisu;
@property (weak, nonatomic) IBOutlet UIButton *btn_can;
- (void)reloadWithOBJ:(BestRecordOBJ *)OBJ;
@end
