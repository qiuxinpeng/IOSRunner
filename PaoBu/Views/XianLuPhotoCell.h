//
//  XianLuPhotoCell.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/11.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XianLuPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QXPImageView *QimgV_image;
@property (weak, nonatomic) IBOutlet UIButton *btn_count;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;

- (IBAction)btn_zan_click:(UIButton *)sender;
@end
