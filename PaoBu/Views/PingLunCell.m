#import "PingLunCell.h"

@implementation PingLunCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.img_head addRoundWithRadius:self.img_head.ui_height/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
