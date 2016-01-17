//
//  NavMainViewController.h
//  PaoBu
//
//  Created by 邱玲 on 15/8/28.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface NavMainViewController : BaseViewController<MAMapViewDelegate, AMapSearchDelegate>
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (strong, nonatomic) IBOutlet AMapSearchAPI *search;

@property int collectionID;

@end
