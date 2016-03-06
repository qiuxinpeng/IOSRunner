//
//  PhotoCollectionViewCell.m
//  PaoBu
//
//  Created by 邱玲 on 16/3/6.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    [self addRoundWithRadius:3];
    
    self.lab_feiyong.transform = CGAffineTransformMakeRotation((-45 * M_PI) / 180.0f);
    [self.lab_feiyong addRoundWithRadius:2];
    [self.lab_juli addRoundWithRadius:2];
    [self.lab_liebie addRoundWithRadius:2];
    [self.lab_zan addRoundWithRadius:2];

}

@end
