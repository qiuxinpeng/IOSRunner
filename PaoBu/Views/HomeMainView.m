//
//  HomeMainView.m
//  PaoBu
//
//  Created by Mr.Qiu on 15/9/7.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "HomeMainView.h"

@implementation HomeMainView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation HomeMainSmallView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        self.QimgV_image=[[QXPImageView alloc]initWithFrame:self.bounds];
        
        [self addSubview:self.QimgV_image];
    }

    return self;
}
- (void)setChoose:(BOOL)choose{

    if (choose) {
        [self addBorderWithColor:[UIColor yellowColor] Width:2];
    }else{
        [self addBorderWithColor:[UIColor clearColor] Width:2];

    }
}
@end