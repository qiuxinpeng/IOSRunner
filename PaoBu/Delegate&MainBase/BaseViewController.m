//
//  BaseViewController.m
//  YouPlay
//
//  Created by 小白 on 13-8-21.
//  Copyright (c) 2013年 邱新鹏. All rights reserved.
//

#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BaseNavigationController.h"
#import "LoginFirstViewController.h"
//#import "LoginViewController.h"
//#import "QXPLoginBtn.h"
//#import "MyViewController.h"
#import "AKTabBarController.h"

@interface BackParentView : UIView

@property(nonatomic, strong)UIView *backView;
@property(nonatomic, strong)UITapGestureRecognizer* singleRecognizer;

@property(nonatomic, strong)void (^willRemoveBlock)();
@property(nonatomic, assign)BOOL isRemove;

@property(nonatomic, weak)UIView *parentView;
@property (nonatomic, getter = isUseTouchDismissParentView)BOOL useTouchDismissParentView;

- (void)removed;
@end

@implementation BackParentView

- (id)initWithFrame:(CGRect)frame parentView:(UIView *)view{
    if ((self=[super initWithFrame:frame])) {
        self.backgroundColor=[UIColor clearColor];
        self.parentView=view;
        self.backView=[[UIView alloc] initWithFrame:self.bounds];
        self.backView.autoresizingMask=UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        self.backView.autoresizesSubviews=YES;
        self.backView.backgroundColor=[UIColor blackColor];
        self.backView.alpha=0.1;
        [self addSubview:self.backView];
        [self addSubview:self.parentView];
        self.parentView.center=self.center;
        self.isRemove=NO;
        if (self.isUseTouchDismissParentView) {
            self.singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
            self.singleRecognizer.numberOfTapsRequired = 1; // 单击
            [self.backView addGestureRecognizer:self.singleRecognizer];
        }
    }
    return self;
}
- (void)WillDismiss{
    if ([self.parentView respondsToSelector:@selector(WillDismiss)]) {
        [self.parentView performSelector:@selector(WillDismiss)];
    }
}

- (void)setUseTouchDismissParentView:(BOOL)useTouchDismissParentView{
    _useTouchDismissParentView=useTouchDismissParentView;
    [self.backView removeGestureRecognizer:self.singleRecognizer];
    
    if (_useTouchDismissParentView) {
        self.singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
        self.singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self.backView addGestureRecognizer:self.singleRecognizer];
    }
}
- (void)dealloc{
    [self.backView removeGestureRecognizer:self.singleRecognizer];
     self.backView=nil;
}
- (void)handleSingleTapFrom{
    if (self.willRemoveBlock && !self.isRemove) {
        self.isRemove=YES;
        self.willRemoveBlock();
    }
}
- (void)removed{
    [self.parentView removeFromSuperview];
}

@end

@interface BaseViewController ()
@property (nonatomic, strong)BackParentView *parentView;

- (void)dismissParentView;
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIImageView*)backGroundView{
    if (!_backGroundView) {
        _backGroundView=[[UIImageView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:_backGroundView atIndex:0];
    }
    return _backGroundView;
}
//添加消失Nav按钮
-(void)addDismissNav{

    //[self addLeftBar:Localize(@"Back") action:@selector(dissMiss)];
}
////添加9通logo
//- (void)add9TongLOGO{
//    
//}
////添加9通通用背景颜色
//- (void)add9TongBGColor{
//    //self.view.backgroundColor=COLOR_VIEW_BG;
//}
/*
//添加登陆按钮
- (void)addLoginBtn:(void(^)(BOOL isLogin, LoginViewController *loginVC))loginBlock loginOKBlock:(void (^)())loginOKBlock{

    
    __weak BaseViewController *wself=self;
    QXPLoginBtn *loginBtn=[[QXPLoginBtn alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    loginBtn.backgroundColor=[UIColor clearColor];
    [loginBtn addloginAction:^{
        [wself login:loginBlock];
    } loginOKAction:loginOKBlock];
    //[loginBtn addTarget:self loginAction:@selector(doLogin) loginOKAction:@selector(LoginOK)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:loginBtn];
    
}
 */
//添加登陆按钮简化版本
/*
- (void)addLoginBtn{

    __weak BaseViewController *wslf=self;
    [self addLoginBtn:^(BOOL isLogin, LoginViewController *loginVC) {
        
    } loginOKBlock:^{
        MyViewController *myVC=[[MyViewController alloc]initWithNibName:@"MyViewController" bundle:nil];
        [wslf pushVC:myVC animated:YES];
    }];
}
*/
- (void)dissMiss{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
/**/
//登陆
- (void)login:(void(^)(BOOL isLogin, LoginFirstViewController *loginVC))loginBlock{
     
    QXPDispatch_after(0.1, ^{
        LoginFirstViewController *loginVC=[[LoginFirstViewController alloc]initWithNibName:@"LoginFirstViewController" bundle:nil];
        [loginVC setLoginCallBlock:loginBlock];
        //[loginVC addBackBtn];
        BaseNavigationController *nav=[[BaseNavigationController alloc]initWithRootViewController:loginVC];
        [self presentVC:nav animated:YES];
    });
    
}

- (void)_init{
    if (QXPSystemVersionGreaterOrEqualThan(7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self _init];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    //        CGRect viewBounds = self.view.bounds;
    //        CGFloat topBarOffset = self.topLayoutGuide.length;
    //        viewBounds.origin.y = topBarOffset * - 1;
    //        self.view.bounds = viewBounds;
    //    } 
}
- (void)loadView{
    
    [super loadView];
    _showNavBar=!self.navigationController.navigationBarHidden;
    _showTabBar=!self.akTabBarController.tabBar.hidden;
    _popViewController=@selector(popViewControllers);
    //self.showTabBar=YES;

    [self _init];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.showNavBar=YES;
    self.showTabBar=NO;
    self.useTouchDismissParentView=NO;
    //self.view.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.93 green:0.97 blue:0.99 alpha:1];
    
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    _navigationBarHidden=navigationBarHidden;
    self.navigationController.navigationBar.hidden=_navigationBarHidden;
}
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    //[_navigationBar setTitle:title textColor:[UIColor whiteColor]];
}
- (void)setShowNavBar:(BOOL)showNavBar{
    _showNavBar=showNavBar;
    if (self.navigationController.navigationBarHidden==_showNavBar) {
        self.navigationController.navigationBarHidden=!_showNavBar;
    }
    
}
- (void)setShowTabBar:(BOOL)showTabBar{
    _showTabBar=showTabBar;
    if (_showTabBar ) {
        [self.akTabBarController showTabBarAnimated:NO];
    }else{
        [self.akTabBarController hideTabBarAnimated:NO];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
//    if (_showTabBar ) {
//        [self.akTabBarController showTabBarAnimated:NO];
//    }else{
//        [self.akTabBarController hideTabBarAnimated:NO];
//    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_showNavBar) {
        self.navigationController.navigationBarHidden=NO;
    }else{
        self.navigationController.navigationBarHidden=YES;
        
    }
    if (_showTabBar ) {
        [self.akTabBarController showTabBarAnimated:NO];
    }else{
        [self.akTabBarController hideTabBarAnimated:NO];
    }
    
//    QXPDispatch_after(0.3, ^{
//        
//    });
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
//添加背景图片
- (void)addBackGroundImage:(NSString  *)iamgeName{
    self.backGroundView.image=[UIImage imageNamed:iamgeName];
}
//添加背景图片
- (void)addBackGroundImageWithImage:(UIImage *)iamgeName{
    self.backGroundView.image=iamgeName;
}
//跳转到第几个tab
- (void)setSelectedIndex:(int)index{
    [MainManager manager].VCMain.selectedIndex=index;

}
//添加返回按钮
- (void)addPopVCBarWithBtn{
    if (IS_IOS7_AND_UP) {
        UIImage *imageLeft=[CommonFn imageViaColor:[UIColor clearColor]];
        UIButton* aButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [aButton setBackgroundImage:imageLeft forState:UIControlStateNormal];
        aButton.frame=CGRectMake(0, 0 , 68, 30);//zhy 2014.1.20 Bizbook显示的按钮太小了，所以放大了一些。
        
        [aButton setTitle:@"返回" forState:UIControlStateNormal];
        [aButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [aButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [aButton addTarget:self action:self.popViewController forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton] ;
        
    }else{
        UILabel *lblTest = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] ;
        lblTest.font = [UIFont systemFontOfSize:17];
        lblTest.text = NSLocalizedString(@"返回" ,@"");
        [lblTest sizeToFit];
        int titleWidth = lblTest.frame.size.width;
        if (titleWidth > 100) {
            lblTest.text = NSLocalizedString(@"返回" ,@"");
            [lblTest sizeToFit];
            titleWidth = lblTest.frame.size.width;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, titleWidth + 9 + 12, 30);
        //backbutton4ios7
        [button setImage:[UIImage imageNamed:@"backButton4NoniOS7.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[CommonFn imageViaColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [button setTitle:lblTest.text forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [button addTarget:self action:self.popViewController forControlEvents:UIControlEventTouchUpInside];
        
       self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    //[self setLeftBarWithBtn:nil imageName:@"main_nav_back_new.png" action:self.popViewController];
}
//添加左边按钮
- (void)addLeftBar:(NSString *)title action:(SEL)action{
    [self setLeftBarWithBtn:title imageName:nil action:action];
}
//添加右边按钮
- (void)addRightBar:(NSString *)title action:(SEL)action{
     [self setRightBarWithBtn:title imageName:nil action:action];
}

- (void)showWithView:(UIView *)parentView{
    __weak __typeof(self) wself = self;
    self.parentView=[[BackParentView alloc] initWithFrame:self.view.bounds parentView:parentView];
    self.parentView.useTouchDismissParentView=self.useTouchDismissParentView;
   // self.parentView.center=CGPointMake(self.view.width/2, self.view.height/2);
    [self.parentView setWillRemoveBlock:^{
        [wself dismissParentView];
    }];
    [self.view addSubview:self.parentView];
    
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = 0.5;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [self.parentView.layer addAnimation:forwardAnimation forKey:BaseViewControllerAnimationKey];
    
//    __weak BaseViewController *wself=self;
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options:0
//                     animations:^{
//                         
//                     }
//                     completion:^(BOOL finished) {
//                     }];
    
}

- (void)dismissParentView{
    __weak BaseViewController *wself=self;
    
    CABasicAnimation *reverseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    reverseAnimation.duration = 0.5;
    reverseAnimation.beginTime = 0;
    reverseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    reverseAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    reverseAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    [self.parentView.layer addAnimation:reverseAnimation forKey:BaseViewControllerAnimationKey];
    
    double delayInSeconds = 0.4;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
//        if ([wself.parentView respondsToSelector:@selector(WillDismiss)]) {
//            [wself.parentView performSelector:@selector(WillDismiss)];
//        }
        [wself.parentView WillDismiss];
        wself.parentView.hidden=YES;
        [wself.parentView removed];
        [wself.parentView.layer removeAnimationForKey:BaseViewControllerAnimationKey];
        [wself.parentView removeFromSuperview];
        wself.parentView=nil;
    });
}

-(void)setLeftBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action{
    /*
    UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 7, 32, 32)];
    [mybtn setTitle:title forState:UIControlStateNormal];
    [mybtn setBackgroundImage:[UIImage imageNamed:inmageName] forState:UIControlStateNormal];
    [mybtn addTarget:self action:action forControlEvents:UIControlEventTouchDown];
    self.navigationBar.leftBarButtonItem=mybtn;
     */
    
    if (inmageName) {
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:inmageName] style:UIBarButtonItemStylePlain target:self action:action];
    }else{
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    }
}
-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action isRoand:(BOOL)roand{
    /*
    UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 7, roand?32:42, 32)];
    [mybtn setTitle:title forState:UIControlStateNormal];
    mybtn.titleLabel.font  = [UIFont systemFontOfSize:13];
    [mybtn setBackgroundImage:[UIImage imageNamed:inmageName] forState:UIControlStateNormal];
    [mybtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButtonItem=mybtn;
     */
    
    if (inmageName) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:inmageName] style:UIBarButtonItemStylePlain target:self action:action];
    }else{
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    }
    
}
-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action
{
    [self setRightBarWithBtn:title imageName:inmageName action:action isRoand:NO];
}

/*****
 set  rightBarButton
 *****/
-(void)setrightBarButtonItem:(NSString *)imageName Event:(SEL)_event{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 34, 34);
   
    if ([imageName length] && imageName != nil) {
        [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }else{
        QLog(@"imagenamed==%@",imageName);
    }
    [backButton addTarget:self action:_event forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, backNavigationItem];
    }else{
        self.navigationItem.rightBarButtonItem = backNavigationItem;
    }
}

- (void)hideNavBatBottomLine{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"f2f2f2.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)showNavBatBottomLine{

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)popViewControllers{
    //[BBInterFace cancelForTag:self.tagWithInterFace];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)presentVC:(UIViewController *)vc animated:(BOOL)animated{
    UIViewController *av=[self akTabBarController]?(UIViewController *)[self akTabBarController]:self;
    [av presentViewController:vc animated:animated completion:nil];
}
- (void)dismissVC:(BOOL)animated{
    [self dismissViewControllerAnimated:animated completion:nil];
}
- (void)pushVC:(UIViewController *)vc animated:(BOOL)animated{
    [self.navigationController pushViewController:vc animated:animated];;
}
- (void)popVC:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:animated];;
}
- (void)popToRoot:(BOOL)animated{
    [self.navigationController popToRootViewControllerAnimated:animated];;
}
- (void)popToInderx:(int)index animated:(BOOL)animated{

    UIViewController *tempVC=[self.navigationController.viewControllers objectAtIndex:index];
    [self.navigationController popToViewController:tempVC animated:animated];
    tempVC=nil;
}
//float originY(float Originy){
//    return HEIGHT_STATUSBAR+Originy;
//}

-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;  // 可以修改为任何方向
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{

    return  UIInterfaceOrientationPortrait;
}
-(BOOL)shouldAutorotate{
    
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
