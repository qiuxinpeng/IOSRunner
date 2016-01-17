//
//  PingLunMainView.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/16.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "PingLunMainView.h"
#import "PingLunCell.h"
@interface PingLunMainView()
@property(nonatomic,strong)NSArray *CommentRanking;
@property(nonatomic,strong)NSArray *Comment;
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSMutableDictionary *dict_heigh;
@end
@implementation PingLunMainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
    self.dict_heigh=[NSMutableDictionary dictionary];
    
    [self.tabV_list registerNib:[UINib nibWithNibName:@"PingLunCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PingLunCell"];

}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)willShow{
    if (!self.Comment) {
        
        [[BBInterFace interfaceWithFinshBlock:^(NSDictionary *responseObje) {
            self.CommentRanking=responseObje[@"CommentRanking"];
            self.Comment=responseObje[@"Comment"];
            self.count=responseObje[@"count"];
            [self reloadData];
            
        } faildBlock:^(NSError *err) {
            
        } HUDBackgroundView:self tag:nil] getCommentInfo:self.OBJ.ID start:@"1" pageNum:@"100"];
    }
    
}
- (void)reloadData{
    
    [self.tabV_list reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([self.dict_heigh objectForKey:indexPath]) {
        
        
        return [[self.dict_heigh objectForKey:indexPath] floatValue];
    }
    
    BestCommentOBJ *OBJ=nil;

    PingLunCell *cell=[PingLunCell instancetWihtXIB];
    
    
    if (indexPath.section==0) {
        OBJ=self.CommentRanking[indexPath.row];
    }else if (indexPath.section==1){
        OBJ=self.Comment[indexPath.row];
    }
       cell.lab_info.text=OBJ.Content;
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height += 1;
    
    [self.dict_heigh setObject:[NSNumber numberWithFloat:height] forKey:indexPath];
    
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 0;

    if (section==0) {
        return self.CommentRanking.count;
    }else{
        return self.Comment.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PingLunCell *cell=(PingLunCell*)[tableView dequeueReusableCellWithIdentifier:@"PingLunCell" forIndexPath:indexPath];
    
    BestCommentOBJ *OBJ=nil;
    
    if (indexPath.section==0) {
        OBJ=self.CommentRanking[indexPath.row];
    }else if (indexPath.section==1){
        OBJ=self.Comment[indexPath.row];
    }

    if ([OBJ.IsLiked boolValue]) {
        [cell.btn_can setImage:[UIImage imageNamed:@"praisePre.png"] forState:UIControlStateNormal];
        
    }else{
        [cell.btn_can setImage:[UIImage imageNamed:@"praiseFinsh"] forState:UIControlStateNormal];
    }
    
    [cell.btn_can setTitle:OBJ.LikeCount forState:UIControlStateNormal];
    [cell.img_head sd_setImageWithURL:[NSURL URLWithString:OBJ.PhotoUrl]];
    
    cell.lab_name.text=OBJ.DisplayName;
    cell.lab_title.text=OBJ.PublishTime;
    cell.lab_info.text=OBJ.Content;

    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return @"周边评论";
    }else if (section==1){
        
        return @"最新评论";
    }
    return nil;
}

@end
