//
//  ZhouBianMainView.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/16.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhouBianMainView : UIView
@property(nonatomic,strong) IBOutlet UIView  *view;
@property (weak, nonatomic) IBOutlet UITableView *tabV_list;

@property (strong, nonatomic)getRecommendTraceInfoOBJ *OBJ;
- (void)willShow;
@end
