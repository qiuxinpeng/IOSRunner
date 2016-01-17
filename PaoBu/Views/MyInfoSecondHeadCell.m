//
//  MyInfoSecondHeadCell.m
//  PaoBu
//
//  Created by Mr.Qiu on 15/9/1.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "MyInfoSecondHeadCell.h"

@implementation MyInfoSecondHeadCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.ImgV_head addRoundWithRadius:self.ImgV_head.ui_width/2];
    [self.lab_nianling_1 addRoundWithRadius:4];
    [self.lab_xingqu_2 addRoundWithRadius:4];
    [self.lab_xingqu_3 addRoundWithRadius:4];
    [self.lab_xingqu_4 addRoundWithRadius:4];
    self.lab_nianling_1.backgroundColor=[UIColor colorWithRed:0.92 green:0.38 blue:0.36 alpha:1];
    
    self.lab_xingqu_2.backgroundColor=[UIColor colorWithRed:0.22 green:0.73 blue:0.47 alpha:1];
    self.lab_xingqu_3.backgroundColor=[UIColor colorWithRed:0.29 green:0.66 blue:0.88 alpha:1];
    self.lab_xingqu_4.backgroundColor=[UIColor colorWithRed:0.93 green:0.58 blue:0.31 alpha:1];
}
- (void)reloadWithInfo:(PBUser *)user{
    [self.ImgV_head sd_setImageWithURL:[NSURL URLWithString:user.PhotoUrl]];
    self.Lab_name.text=user.DisplayName;
    
    self.lab_qianming.text=(!user.Signature || [user.Signature isNilOrEmpty])?@"没签名才是真个性":user.Signature;
    self.lab_pengyou.text=user.FriendsNum;
    self.lab_mapcount.text=user.MapRunNum;
    
    self.lab_nianling_1.text=user.AgeGroupDescription;
    
    NSArray *tempArr=[user.HobbiesDetail componentsSeparatedByString:@","];
    
    self.lab_xingqu_2.hidden=YES;
    self.lab_xingqu_3.hidden=YES;
    self.lab_xingqu_4.hidden=YES;

    for (int i=0; i<tempArr.count; i++) {
        NSString *tempStr=tempArr[i];
        
        if (i==0) {
            self.lab_xingqu_2.hidden=NO;
            self.lab_xingqu_2.text=tempStr;
        }else if (i==1){
            self.lab_xingqu_3.hidden=NO;
            self.lab_xingqu_3.text=tempStr;
        }else if (i==2){
            self.lab_xingqu_4.hidden=NO;
            self.lab_xingqu_4.text=tempStr;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
