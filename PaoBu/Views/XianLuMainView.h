//
//  XianLuMainView.h
//  PaoBu
//
//  Created by 邱玲 on 15/9/11.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XianLuMainView : UIView
@property(nonatomic,strong) IBOutlet UIView  *view;
@property (weak, nonatomic) IBOutlet UITableView *tableV_list;


@property(nonatomic,strong)getTraceLineInfoOBJ *traceLineInfoOBJ;

- (void)reloadWithOBJ:(getTraceLineInfoOBJ *)OBJ;
@end
