//
//  XianLuJiaoTongCell.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/15.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "XianLuJiaoTongCell.h"

@implementation XianLuJiaoTongCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    [self.img_head addRoundWithRadius:self.img_head.ui_height/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadWithOBJ:(BestRecordOBJ *)OBJ{

    if ([OBJ.IsLiked boolValue]) {
        [self.btn_can setImage:[UIImage imageNamed:@"praisePre.png"] forState:UIControlStateNormal];
        
    }else{
        [self.btn_can setImage:[UIImage imageNamed:@"praiseFinsh"] forState:UIControlStateNormal];
    }
    
    [self.img_head sd_setImageWithURL:[NSURL URLWithString:OBJ.PhotoUrl]];
    
    self.lab_name.text=OBJ.DisplayName;
    self.lab_Ctime.text=OBJ.StartTime;
    
    self.lab_Ttime.text=[NSString stringWithFormat:@"时间:%@ ~ %@ ",OBJ.StartTime,OBJ.FinishTime];
    
    
    self.lab_alllong.text=[NSString stringWithFormat:@"全长:%@",OBJ.OverallLength ];
    self.lab_alltime.text=[NSString stringWithFormat:@"总时长:%@",OBJ.TotalTime ];

    [self.btn_can setTitle:OBJ.LikeCount forState:UIControlStateNormal];

}
@end
