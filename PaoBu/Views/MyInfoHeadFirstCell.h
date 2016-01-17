//
//  MyInfoHeadFirstCell.h
//  PaoBu
//
//  Created by 邱玲 on 15/8/30.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoHeadFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgV_head;
@property (weak, nonatomic) IBOutlet UILabel *Lab_name;
@property (weak, nonatomic) IBOutlet UILabel *Lab_ID;
@property (weak, nonatomic) IBOutlet UIButton *Btn_dengji;
@property (weak, nonatomic) IBOutlet UIButton *Btn_jifen;
- (void)reloadWithInfo:(PBUser *)user;
@end
