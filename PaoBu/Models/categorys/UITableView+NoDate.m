//
//  UITableView+NoDate.m
//  YouPlayNew
//
//  Created by Mr.Qiu on 14/11/16.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import "UITableView+NoDate.h"
#import "TableNoDateView.h"
@implementation UITableView (NoDate)

- (TableNoDateView *)noDteView {
    return objc_getAssociatedObject(self, @selector(noDteView));
}

- (void)setNoDteView:(TableNoDateView *)value {
    objc_setAssociatedObject(self, @selector(noDteView), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)addNoDteView{
    
    if (!self.noDteView) {
        self.noDteView=[TableNoDateView instancetWihtXIB];
        [self addSubview:self.noDteView];
    }
    
    
}
- (void)removeNoDateView{
    
    
    if (self.noDteView) {
        [self.noDteView removeFromSuperview];
        self.noDteView=nil;
    }
    
}

@end
