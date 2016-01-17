//
//  XianLuDetailsCell.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/13.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "XianLuDetailsCell.h"

@implementation XianLuDetailsCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
//- (void)updateConstraints{
//    [super updateConstraints];
//}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
//    // need to use to set the preferredMaxLayoutWidth below.
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
//    
//    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
//    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
//   // self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLabel.frame);
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
