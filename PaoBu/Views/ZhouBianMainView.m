//
//  ZhouBianMainView.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/16.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "ZhouBianMainView.h"
#import "ZhouBianCell.h"
@interface ZhouBianMainView ()
@property(nonatomic,strong)NSArray *NearbyRanking;
@property(nonatomic,strong)NSArray *Nearby;
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSMutableDictionary *dict_heigh;



@end
@implementation ZhouBianMainView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self =[super initWithCoder:aDecoder]) {
        //
        [self loadView];
    }
    return self;
}
- (void)loadView{
    
    UIView *view=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil][0];
    [self addSubview:view];
    
    [self.tabV_list registerNib:[UINib nibWithNibName:@"ZhouBianCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZhouBianCell"];

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)willShow{
    if (!self.Nearby) {
        
        [[BBInterFace interfaceWithFinshBlock:^(NSDictionary *responseObje) {
            self.NearbyRanking=responseObje[@"NearbyRanking"];
            self.Nearby=responseObje[@"Nearby"];
            self.count=responseObje[@"count"];
            [self reloadData];
            
        } faildBlock:^(NSError *err) {
            
        } HUDBackgroundView:self tag:nil] getNearbyInfo:self.OBJ.ID start:@"1" pageNum:@"100"];
    }

}
- (void)reloadData{

    [self.tabV_list reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 161;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        return self.NearbyRanking.count;
    }else{
        return self.Nearby.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    getNearbyInfoOBJ *OBJ=nil;
    
    ZhouBianCell *cell=(ZhouBianCell*)[tableView dequeueReusableCellWithIdentifier:@"ZhouBianCell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        OBJ=self.NearbyRanking[indexPath.row];
    }else if (indexPath.section==1){
        OBJ=self.Nearby[indexPath.row];
    }
    [cell reloadWihtOBJ:OBJ];
    
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return @"周边排行";
    }else if (section==1){
        
        return @"最新周边";
    }
    return nil;
}

@end
