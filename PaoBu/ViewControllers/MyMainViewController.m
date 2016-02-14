#import "MyMainViewController.h"
#import "MyInfoHeadFirstCell.h"
#import "MyInfoSecondViewController.h"

@interface MyMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MyMainViewController

- (NSString *)tabImageName{ return @"me.png"; }
- (NSString *)tabTitle{ return @"我"; }
- (NSString *)activeTabImageName{ return @"me1.png"; }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar = YES;
    self.title = @"我";
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    self.tableV_list.tableFooterView = view;
    //self.tableV_list.sectionFooterHeight = 10;
    [self.tableV_list registerNib:[UINib nibWithNibName:@"MyInfoHeadFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyInfoHeadFirstCell"];
    self.tableV_list.backgroundColor = [UIColor clearColor];
    //self.tableV_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginOK) name:ZCUserLoginNotificationName object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadMyProfileView];
    
    //刷新用户基本信息
//    [self updateUserInfo];
//    [self getNewMessageCount];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else{
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyInfoHeadFirstCell *cell=(MyInfoHeadFirstCell*)[tableView dequeueReusableCellWithIdentifier:@"MyInfoHeadFirstCell" forIndexPath:indexPath];
        [cell reloadWithInfo:[PBUser sharedUser]];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myinfocell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myinfocell"];
        }
        if (indexPath.row == 0){
            cell.imageView.image=[UIImage imageNamed:@"lishi.png"];
            cell.textLabel.text = @"历史";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"shoucang.png"];
            cell.textLabel.text = @"收藏";
        }else if (indexPath.row == 2 ){
            cell.imageView.image = [UIImage imageNamed:@"paiming.png"];
            cell.textLabel.text = @"好友排行";
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        MyInfoSecondViewController  *VC = [[MyInfoSecondViewController alloc]initWithNibName:@"MyInfoSecondViewController" bundle:nil];
        [self pushVC:VC animated:YES];
    }
}

#pragma mark - MyInfoView

- (void)reloadMyProfileView {
    if ([PBUser isLogin]) {
        [[BBInterFace interfaceWithFinshBlock:^(PBUser *responseObje) {
            [responseObje synchronize];
            [PBUser changeWithUser:responseObje];
            [PBUser lginOK];
            [self.tableV_list reloadData];
        }faildBlock:^(NSError *err) {
            
        }tag:self.tagWithInterFace] UserGetUserInfo];
    }
}
- (void)LoginOK{
    [self.tableV_list reloadData];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
