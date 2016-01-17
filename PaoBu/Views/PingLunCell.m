//
//  PingLunCell.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/15.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "PingLunCell.h"

@implementation PingLunCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    [self.img_head addRoundWithRadius:self.img_head.ui_height/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
