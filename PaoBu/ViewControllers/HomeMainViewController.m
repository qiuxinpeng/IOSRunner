#import "HomeMainViewController.h"
#import "HomeMainView.h"
#import "HomeDetailViewController.h"
#import "NavMainViewController.h"
#import "BaseNavigationController.h"

@interface HomeMainViewController ()

@property(nonatomic, strong)HomeMainSmallView *selectSmallView;
@property(nonatomic, strong)NSArray *arr_info;

@end

@implementation HomeMainViewController

- (NSString *)tabImageName{
    return @"cion1.png";
}
- (NSString *)tabTitle{
    return @"首页";
}
- (NSString *)activeTabImageName{
    return @"cion1.png";
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.showTabBar = YES;
    self.title = @"跑者地图";

    self.ICarousel1.type = iCarouselTypeLinear;
    self.ICarousel2.type = iCarouselTypeLinear;
 
    //[self.webV_title loadHTMLString:@"最新版 IOS 已经上线了 <a href=\"http://www.ifeng.com\">点此下载</a>" baseURL:nil];
    
    [[BBInterFace interfaceWithFinshBlock:^(id responseObj) {
        self.arr_info = responseObj;
        [self.ICarousel1 reloadData];
        [self.ICarousel2 reloadData];
    } faildBlock:^(NSError *err) {
        //清除 getRecommendTraceInfoOBJ 缓存
        //[[MainManager LKDBglobalHelper] deleteWithClass:[getRecommendTraceInfoOBJ class] where:nil];
        self.arr_info = [getRecommendTraceInfoOBJ allOBJS];
        [self.ICarousel1 reloadData];
        [self.ICarousel2 reloadData];
    } HUDBackgroundView:self.view tag:self.tagWithInterFace] getRecommendTraceInfo];
    
    [[BBInterFace interfaceWithFinshBlock:^(id responseObj) {
        self.lab_title.text = responseObj;
    } faildBlock:^(NSError *err) {
        self.lab_title.text = [QXPCacheUtilit sharedCacheUtilit].home_notice_title;
    } HUDBackgroundView:self.view tag:self.tagWithInterFace] getNotice];
}
- (void)btn_show_click:(UIButton *)sender{
    getRecommendTraceInfoOBJ *OBJ = self.arr_info[sender.tag];
    HomeDetailViewController *VC = [[HomeDetailViewController alloc]initWithNibName:@"HomeDetailViewController" bundle:nil];
    VC.OBJ = OBJ;
    [self pushVC:VC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    //return the total number of items in the carousel
    return self.arr_info.count ;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    getRecommendTraceInfoOBJ *OBJ = self.arr_info[index];
    if (carousel==self.ICarousel1) {
        if (!view) {
            view = [HomeMainView instancetWihtXIB];
            view.frame = CGRectMake(0, 0, 200, 280);
        }
        HomeMainView *tempView = (HomeMainView *)view;
        tempView.lab_title.text = OBJ.Name;
        tempView.btn_show.tag = index;
        [tempView.btn_show addTarget:self action:@selector(btn_show_click:) forControlEvents:UIControlEventTouchDown];
       // tempView.lab_title.text=stringWithInt(index);
        [tempView.QimgV_image setImageURL:[NSURL URLWithString:OBJ.ThumbnailUrl]];

//        //设定UIView（或其子类）为可交互的
//        tempView.userInteractionEnabled = YES;
//        //添加tap手势
//        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pictureClick:)];
//        tempView.tag = [OBJ.ID intValue];
//        //将手势添加至需要相应的view中
//        [tempView addGestureRecognizer:tapGesture];
//        
//        //默认为单击触发事件.设置手指个数
//        //[tapGesture setNumberOfTapsRequired:2];
        
    }else{
        if (!view) {
            view = [[HomeMainSmallView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            view.backgroundColor = [UIColor redColor];
            if (index == 0) {
                self.selectSmallView = (HomeMainSmallView *)view;
                self.selectSmallView.index = index;
                [self.selectSmallView setChoose:YES];
            }
        }
        HomeMainSmallView *tempView = (HomeMainSmallView *)view;

        [tempView.QimgV_image setImageURL:[NSURL URLWithString:OBJ.ThumbnailSmallUrl]];
        if (self.selectSmallView.index == index) {
            [tempView setChoose:YES];
        }else{
            [tempView setChoose:NO];
        }
    }
    
//    UILabel *label = nil;
//    
//    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 250)];
//        //((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
//        view.contentMode = UIViewContentModeCenter;
//        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.backgroundColor = [UIColor redColor];
//        label.textAlignment = UITextAlignmentCenter;
//        label.font = [label.font fontWithSize:50];
//        [view addSubview:label];
//    }
//    else
//    {
//        label = [[view subviews] lastObject];
//    }
    return view;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (carousel == self.ICarousel1) {  //首页大图片点击事件
//        HomeMainView *tempView=(HomeMainView*)[self.ICarousel1 itemViewAtIndex:index];
        [MainManager manager].VCMain.selectedIndex = 2;
        getRecommendTraceInfoOBJ *OBJ = self.arr_info[index];
        BaseNavigationController *baseNavigationController = (BaseNavigationController *)[MainManager manager].VCMain.selectedViewController;
        NavMainViewController *VCNavMain = (NavMainViewController *)baseNavigationController.topViewController;
        //NavMainViewController **VCNavMain=[[NavMainViewController alloc]initWithNibName:@"NavMainViewController" bundle:nil];
        
        VCNavMain.collectionID = [OBJ.ID intValue];
    }else{  //首页小图片点击事件
        HomeMainSmallView *tempView = (HomeMainSmallView*)[self.ICarousel2 itemViewAtIndex:index];
        tempView.index = index;
        [self.selectSmallView setChoose:NO];
        self.selectSmallView = tempView;
        [self.selectSmallView setChoose:YES];
        //[self.ICarousel1 scrollToItemAtIndex:self.ICarousel2.currentItemIndex animated:YES];
        self.ICarousel1.currentItemIndex = index;
        //self.ICarousel2.currentItemIndex;
    }
}
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    if (carousel == self.ICarousel1) {
        HomeMainSmallView *tempView = (HomeMainSmallView*)[self.ICarousel2 itemViewAtIndex:self.ICarousel1.currentItemIndex];
        tempView.index = self.ICarousel1.currentItemIndex;
        [self.selectSmallView setChoose:NO];
        self.selectSmallView = tempView;
        [self.selectSmallView setChoose:YES];
        self.ICarousel2.currentItemIndex = self.ICarousel1.currentItemIndex;
    }else{
//        HomeMainSmallView *tempView=(HomeMainSmallView*)[self.ICarousel2 itemViewAtIndex:self.ICarousel1.currentItemIndex];
//        [self.selectView setChoose:NO];
//        self.selectView=tempView;
//        [self.selectView setChoose:YES];
//        //[self.ICarousel1 scrollToItemAtIndex:self.ICarousel2.currentItemIndex animated:YES];
//        self.ICarousel1.currentItemIndex=self.ICarousel2.currentItemIndex;

    }
}
//- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
//
//
//    return 300;
//}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    //customize carousel display
    switch (option){
        case iCarouselOptionSpacing:{
            if (carousel == self.ICarousel1){
                //add a bit of spacing between the item views
                return value * 1.5f;
            }
        }
        default:{
            return value* 1.05f;
        }
    }
}
////单击首页大图片事件 - 废弃
//- (void)pictureClick:(UITapGestureRecognizer *)gesture{
//    //HomeMainView *view = [[HomeMainView alloc] initWithFrame:gesture.view.frame];
//    [MainManager manager].VCMain.selectedIndex = 2;
//    BaseNavigationController *baseNavigationController = (BaseNavigationController *)[MainManager manager].VCMain.selectedViewController;
//    NavMainViewController *VCNavMain = (NavMainViewController *)baseNavigationController.topViewController;
//    //NavMainViewController **VCNavMain=[[NavMainViewController alloc]initWithNibName:@"NavMainViewController" bundle:nil];
//
//    VCNavMain.collectionID = gesture.view.tag;
//    //[VCNavMain viewDidLoad];
////    [self pushVC:VC animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
