#import "MyInfoHeadFirstCell.h"

@implementation MyInfoHeadFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.ImgV_head addRoundWithRadius:self.ImgV_head.ui_width/2];
}
- (void)reloadWithInfo:(PBUser *)user{
    [self.ImgV_head sd_setImageWithURL:[NSURL URLWithString:user.PhotoUrl]];
    self.Lab_name.text=user.DisplayName;
    self.Lab_ID.text=[NSString stringWithFormat:@"跑者ID:%@",[user userID]];
    [self.Btn_dengji setTitle:[NSString stringWithFormat:@"%@级",user.Grade] forState:UIControlStateNormal];
    [self.Btn_jifen setTitle:[NSString stringWithFormat:@"%@积分",user.Integral] forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
