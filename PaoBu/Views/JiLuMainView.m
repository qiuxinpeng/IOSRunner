#import "JiLuMainView.h"
#import "XianLuJiaoTongCell.h"

@interface JiLuMainView()

@property(nonatomic,strong)NSArray *RecordRanking;
@property(nonatomic,strong)NSArray *Record;
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSMutableDictionary *dict_heigh;

@end

@implementation JiLuMainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self =[super initWithCoder:aDecoder]) {
        [self loadView];
    }
    return self;
}
- (void)loadView{
    UIView *view=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil][0];
    [self addSubview:view];
    self.dict_heigh=[NSMutableDictionary dictionary];
    [self.tabV_list registerNib:[UINib nibWithNibName:@"XianLuJiaoTongCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XianLuJiaoTongCell"];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)willShow{
    if (!self.Record) {
        [[BBInterFace interfaceWithFinshBlock:^(NSDictionary *responseObje) {
            self.RecordRanking=responseObje[@"RecordRanking"];
            self.Record=responseObje[@"Record"];
            self.count=responseObje[@"count"];
            [self reloadData];
        } faildBlock:^(NSError *err) {
            
        } HUDBackgroundView:self tag:nil] getRecordInfo:self.OBJ.ID start:@"1" pageNum:@"100"];
    }
}
- (void)reloadData{
    [self.tabV_list reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.RecordRanking.count;
    }else{
        return self.Record.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XianLuJiaoTongCell *cell=(XianLuJiaoTongCell*)[tableView dequeueReusableCellWithIdentifier:@"XianLuJiaoTongCell" forIndexPath:indexPath];
    BestRecordOBJ *OBJ=nil;
    if (indexPath.section==0) {
        OBJ=self.RecordRanking[indexPath.row];
    }else if (indexPath.section==1){
        OBJ=self.Record[indexPath.row];
    }
    [cell reloadWithOBJ:OBJ];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"周边补给";
    }else if (section==1){
        return @"最新补给";
    }
    return nil;
}

@end
