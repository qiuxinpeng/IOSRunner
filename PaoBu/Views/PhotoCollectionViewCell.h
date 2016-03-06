//
//  PhotoCollectionViewCell.h
//  PaoBu
//
//  Created by 邱玲 on 16/3/6.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV_back;
@property (weak, nonatomic) IBOutlet UILabel *lab_feiyong;
@property (weak, nonatomic) IBOutlet UILabel *lab_juli;
@property (weak, nonatomic) IBOutlet UILabel *lab_liebie;
@property (weak, nonatomic) IBOutlet UILabel *lab_zan;

@end
