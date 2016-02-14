#import "XianLuMainView.h"
#import "XianLuPhotoCell.h"
#import "XianLuBasicCell.h"
#import "XianLuDetailsCell.h"
#import "XianLuDetailsWebCell.h"
#import "XianLuJiaoTongCell.h"
#import "PingLunCell.h"
#import "XianLuBuJiCell.h"

@interface XianLuMainView()

@property (strong, nonatomic) NSMutableDictionary *muDict_cell;
@property (assign, nonatomic) NSInteger xianlu_webHeigh;
@property (assign, nonatomic)BOOL xianlu_isGetHeigh;
@property (assign, nonatomic) NSInteger jiaotong_webHeigh;
@property (assign, nonatomic)BOOL jiaotong_isGetHeigh;

@end
@implementation XianLuMainView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadView];
    }
    return self;
}
- (void)loadView{
    self.xianlu_isGetHeigh = NO;
    self.jiaotong_isGetHeigh = NO;

    self.muDict_cell=[NSMutableDictionary dictionary];
    [self.muDict_cell setObject:[XianLuDetailsCell instancetWihtXIB] forKey:@"XianLuDetailsCell1"];
    [self.muDict_cell setObject:[XianLuDetailsCell instancetWihtXIB] forKey:@"XianLuDetailsCell2"];
    [self.muDict_cell setObject:[XianLuDetailsCell instancetWihtXIB] forKey:@"XianLuDetailsCell3"];

    [self.muDict_cell setObject:[XianLuDetailsWebCell instancetWihtXIB] forKey:@"XianLuDetailsWebCell1"];
    [self.muDict_cell setObject:[XianLuDetailsWebCell instancetWihtXIB] forKey:@"XianLuDetailsWebCell2"];
    [self.muDict_cell setObject:[XianLuDetailsWebCell instancetWihtXIB] forKey:@"XianLuDetailsWebCell2"];

    [self.muDict_cell setObject:[PingLunCell instancetWihtXIB] forKey:@"PingLunCell"];
    
    [self.muDict_cell setObject:[XianLuBuJiCell instancetWihtXIB] forKey:@"XianLuBuJiCell1"];
    [self.muDict_cell setObject:[XianLuBuJiCell instancetWihtXIB] forKey:@"XianLuBuJiCell2"];

    UIView *view=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil][0];
    [self addSubview:view];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"XianLuPhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianLuPhotoCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"XianLuBasicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianLuBasicCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"XianLuDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianLuDetailsCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"XianLuDetailsWebCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianLuDetailsWebCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"XianLuJiaoTongCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianLuJiaoTongCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"PingLunCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PingLunCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"XianLuBuJiCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianLuBuJiCell"];
}
- (void)reloadView{
    [self.tableV_list reloadData];
}
- (void)reloadWithOBJ:(getTraceLineInfoOBJ *)OBJ{
    self.traceLineInfoOBJ=OBJ;
    [self reloadView];
}
#pragma mark __TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 266;
    }else if (indexPath.section==1){
        return 70;
    }else if (indexPath.section==2){
        //return 80;
        NSString *tempStr=self.traceLineInfoOBJ.TraceLineInfo.LineInfoSummary;
        if (tempStr && ![tempStr isNilOrEmpty] && (indexPath.row==0)) {
            XianLuDetailsCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsCell1"];
            cell.lab_detail.text=tempStr;
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            height += 1;
            return height;
        }
        else{
            XianLuDetailsWebCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsWebCell1"];
            [cell.webV_info loadHTMLString:self.traceLineInfoOBJ.TraceLineInfo.LineInfoDetails baseURL:nil];
            __weak __typeof(self) wself= self;
            [cell.webV_info bk_setDidFinishLoadBlock:^(UIWebView * web) {
                if (!wself.xianlu_webHeigh) {
                    NSString *height_str= [web stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
                    int height = [height_str intValue];
                    wself.xianlu_webHeigh=height;
                    wself.xianlu_isGetHeigh=YES;
                    [wself.tableV_list reloadData];
                }
            }];
            //return 1800;
            if (!self.xianlu_isGetHeigh) {
                return 600;
            }
            return self.xianlu_webHeigh;
        }
    }else if (indexPath.section==3){
        NSString *tempStr=self.traceLineInfoOBJ.TraceLineInfo.TrafficInfoSummary;
        if (tempStr && ![tempStr isNilOrEmpty] && (indexPath.row==0)) {
            XianLuDetailsCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsCell2"];
            cell.lab_detail.text=tempStr;
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            height += 1;
            return height;
        }
        else{
            XianLuDetailsWebCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsWebCell2"];
            [cell.webV_info loadHTMLString:self.traceLineInfoOBJ.TraceLineInfo.TrafficInfoDetails baseURL:nil];
            __weak __typeof(self) wself= self;
            [cell.webV_info bk_setDidFinishLoadBlock:^(UIWebView * web) {
                if (!wself.jiaotong_webHeigh) {
                    NSString *height_str= [web stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
                    int height = [height_str intValue];
                    wself.jiaotong_webHeigh=height;
                    wself.jiaotong_isGetHeigh=YES;
                    [wself.tableV_list reloadData];
                }
            }];
            if (!self.jiaotong_isGetHeigh) {
                return 300;
            }
            return self.jiaotong_webHeigh;
        }
    }else if (indexPath.section==4){
        return 140;
    }else if (indexPath.section==5){
        PingLunCell *cell=[self.muDict_cell objectForKey:@"PingLunCell"];
        cell.lab_info.text=self.traceLineInfoOBJ.BestComment.Content;
        if ([self.traceLineInfoOBJ.BestComment.IsLiked boolValue]) {
            [cell.btn_can setImage:[UIImage imageNamed:@"praisePre.png"] forState:UIControlStateNormal];
        }else{
            [cell.btn_can setImage:[UIImage imageNamed:@"praiseFinsh"] forState:UIControlStateNormal];
        }
        [cell.btn_can setTitle:self.traceLineInfoOBJ.BestComment.LikeCount forState:UIControlStateNormal];
        [cell.img_head sd_setImageWithURL:[NSURL URLWithString:self.traceLineInfoOBJ.BestComment.PhotoUrl]];
        cell.lab_name.text=self.traceLineInfoOBJ.BestComment.DisplayName;
        cell.lab_title.text=self.traceLineInfoOBJ.BestComment.PublishTime;
        
        // self.lab_name.text=OBJ.DisplayName;
        // self.lab_Ctime.text=OBJ.StartTime;
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1;
        return height;
    }else if (indexPath.section==6){
        if (indexPath.row==0) {
            XianLuDetailsCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsCell3"];
            cell.lab_detail.text=self.traceLineInfoOBJ.TraceLineInfo.SupplyInfoSummary;
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            height += 1;
            return height;
        }else if (indexPath.row==1){
            XianLuBuJiCell *cell=[self.muDict_cell objectForKey:@"XianLuBuJiCell1"];
            cell.lab_info.text=self.traceLineInfoOBJ.TraceLineInfo.SupplyInfoWater;
            [cell.img_image setImage:[UIImage imageNamed:@"water.png"]];
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            height += 1;
            return height;
        }else if (indexPath.row==2){
            XianLuBuJiCell *cell=[self.muDict_cell objectForKey:@"XianLuBuJiCell2"];
            cell.lab_info.text=self.traceLineInfoOBJ.TraceLineInfo.SupplyInfoWC;
            [cell.img_image setImage:[UIImage imageNamed:@"wc.png"]];
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            height += 1;
            return height;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.traceLineInfoOBJ) {
        return 0;
    }
    return 7    ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        NSString *tempStr=self.traceLineInfoOBJ.TraceLineInfo.LineInfoSummary;
        if (tempStr && ![tempStr isNilOrEmpty] ) {
            return 2;
        }else{
            return 1;
        }
    }else if (section==3){
        NSString *tempStr=self.traceLineInfoOBJ.TraceLineInfo.TrafficInfoSummary;
        if (tempStr && ![tempStr isNilOrEmpty] ) {
            return 2;
        }else{
            return 1;
        }
    }else if (section==4){
        if (!self.traceLineInfoOBJ.BestRecord.UserID || [self.traceLineInfoOBJ.BestRecord.UserID isNilOrEmpty]) {
            return 0;
        }
        return 1;
    }else if (section==5){
        if (!self.traceLineInfoOBJ.BestComment.UserID || [self.traceLineInfoOBJ.BestComment.UserID isNilOrEmpty]) {
            return 0;
        }
        return 1;
    }else if (section==6){
        if (!self.traceLineInfoOBJ.TraceLineInfo.SupplyInfoSummary || [self.traceLineInfoOBJ.TraceLineInfo.SupplyInfoSummary isNilOrEmpty]) {
            return 0;
        }
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        XianLuPhotoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"XianLuPhotoCell" forIndexPath:indexPath];
        [cell.QimgV_image setImageURL:[NSURL URLWithString:self.traceLineInfoOBJ.TraceLineInfo.ThumbnailDetailUrl]];
        [cell.btn_count setTitle:self.traceLineInfoOBJ.UseCount forState:UIControlStateNormal];
        [cell.btn_zan setTitle:self.traceLineInfoOBJ.LikeCount forState:UIControlStateNormal];
        return cell;
    }else if (indexPath.section==1){
        XianLuBasicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"XianLuBasicCell" forIndexPath:indexPath];
        cell.lab_quanchang.text=[NSString stringWithFormat:@"全长:%@KM",self.traceLineInfoOBJ.TraceLineInfo.OverallLength];
        cell.lab_haoshi.text=[NSString stringWithFormat:@"全长:%@KM",self.traceLineInfoOBJ.TraceLineInfo.EstimateTime];
        return cell;
    }else if (indexPath.section==2){
        NSString *tempStr=self.traceLineInfoOBJ.TraceLineInfo.LineInfoSummary;
        if (tempStr && ![tempStr isNilOrEmpty] && (indexPath.row==0)) {
            XianLuDetailsCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsCell1"];
            return cell;
        }else{
            XianLuDetailsWebCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsWebCell1"];
            return cell;
        }
    }else if (indexPath.section==3){
        NSString *tempStr=self.traceLineInfoOBJ.TraceLineInfo.TrafficInfoSummary;
        if (tempStr && ![tempStr isNilOrEmpty] && (indexPath.row==0)) {
            XianLuDetailsCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsCell2"];
            return cell;
        }else{
            XianLuDetailsWebCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsWebCell2"];
            return cell;
        }
    }else if (indexPath.section==4){
        XianLuJiaoTongCell *cell=(XianLuJiaoTongCell*)[tableView dequeueReusableCellWithIdentifier:@"XianLuJiaoTongCell" forIndexPath:indexPath];
        BestRecordOBJ *OBJ=self.traceLineInfoOBJ.BestRecord;
        [cell reloadWithOBJ:OBJ];
        return cell;
    }else if (indexPath.section==5){
        PingLunCell *cell=[self.muDict_cell objectForKey:@"PingLunCell"];
        return cell;
    }else if (indexPath.section==6){
        if (indexPath.row==0) {
            XianLuDetailsCell *cell=[self.muDict_cell objectForKey:@"XianLuDetailsCell3"];
            return cell;
        }else if (indexPath.row==1){
            XianLuBuJiCell *cell=[self.muDict_cell objectForKey:@"XianLuBuJiCell1"];
            return cell;
        }else if (indexPath.row==2){
            XianLuBuJiCell *cell=[self.muDict_cell objectForKey:@"XianLuBuJiCell2"];
            return cell;
        }
    }
//    XianLuBasicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"XianLuBasicCell" forIndexPath:indexPath];
//    cell.lab_quanchang.text=[NSString stringWithFormat:@"全长:%@KM",self.traceLineInfoOBJ.TraceLineInfo.OverallLength];
//    cell.lab_haoshi.text=[NSString stringWithFormat:@"全长:%@KM",self.traceLineInfoOBJ.TraceLineInfo.EstimateTime];
//    return cell;
    
    return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return @"线路详情";
    }else if (section==3){
        return @"交通信息";
    }else if (section==4){
        return @"最佳记录";
    }else if (section==5){
        return @"最佳评论";
    }else if (section==6){
        return @"周边补给";
    }
    return nil;
}
- (void)dealloc{ }
@end
