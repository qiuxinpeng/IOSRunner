//
//  HomeMainViewController.h
//  PaoBu
//
//  Created by 邱玲 on 15/8/28.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "BaseViewController.h"
#import "iCarousel.h"

@interface HomeMainViewController : BaseViewController<iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *ICarousel1;
@property (weak, nonatomic) IBOutlet iCarousel *ICarousel2;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@end
