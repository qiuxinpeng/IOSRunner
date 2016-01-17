//
//  EditUserInfoTextTableViewCell.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/3.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditUserInfoTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_detail;
@property(nonatomic, assign)UserEditType type;
@end
