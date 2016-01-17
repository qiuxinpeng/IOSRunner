//
//  ZhouBianCell.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/16.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "ZhouBianCell.h"

@implementation ZhouBianCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.img_head addRoundWithRadius:self.img_head.ui_height/2];
    
    self.img_img1.clipsToBounds=YES;
    self.img_img2.clipsToBounds=YES;
    self.img_img3.clipsToBounds=YES;


}
- (void)reloadWihtOBJ:(getNearbyInfoOBJ *)OBJ{

    [self.img_head sd_setImageWithURL:[NSURL URLWithString:OBJ.PhotoUrl]];
    self.lab_name.text=OBJ.DisplayName;
    self.lab_time.text=OBJ.PublishTime;
    self.lab_pinglun.text=OBJ.Description;

    [self.btn_zan setTitle:OBJ.LikeCount forState:UIControlStateNormal];
    
    NSArray *imageArr=[OBJ.PictureUrl componentsSeparatedByString:@","];
    
    for (int i=0; i<imageArr.count; i++) {
        
        NSString *url=imageArr[i];
        if (i==0) {
            [self.img_img1 sd_setImageWithURL:[NSURL URLWithString:url]];

        }else if (i==1){
         [self.img_img2 sd_setImageWithURL:[NSURL URLWithString:url]];
        }else if (i==2){
         [self.img_img3 sd_setImageWithURL:[NSURL URLWithString:url]];
        }
    }
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
