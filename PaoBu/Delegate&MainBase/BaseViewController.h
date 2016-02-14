#import "UIViewController+AKTabBarController.h"

@class LoginFirstViewController;
static NSString * const BaseViewControllerAnimationKey = @"BaseViewControllerAnimationKey";

@interface BaseViewController : UIViewController{

}
//@property (nonatomic, strong)QXPNavgationBar  *navigationBar;
@property (nonatomic) BOOL navigationBarHidden;
@property (nonatomic, strong) UIImageView *backGroundView;
@property (nonatomic) SEL popViewController;

@property (nonatomic, getter = isShowNavBar) BOOL showNavBar;
@property (nonatomic, getter = isShowTabBar) BOOL showTabBar;
@property (nonatomic, getter = isUseTouchDismissParentView) BOOL useTouchDismissParentView;

//跳转到第几个tab
- (void)setSelectedIndex:(int)index;
//添加左边返回按钮
- (void)addPopVCBarWithBtn;
//添加左边按钮
- (void)addLeftBar:(NSString *)title action:(SEL)action;
//添加右边按钮
- (void)addRightBar:(NSString *)title action:(SEL)action;
//显示当前视图
- (void)showWithView:(UIView *)parentView;
//消失视图
- (void)dismissParentView;

//添加背景图片
- (void)addBackGroundImage:(NSString  *)iamgeName;
//添加背景图片
- (void)addBackGroundImageWithImage:(UIImage *)iamgeName;
////添加9通logo
//- (void)add9TongLOGO;
////添加9通通用背景颜色
//- (void)add9TongBGColor;
//登陆
- (void)login:(void(^)(BOOL isLogin, LoginFirstViewController *loginVC))loginBlock;
//添加消失Nav按钮
-(void)addDismissNav;

//隐藏底部线条
- (void)hideNavBatBottomLine;
//显示底部线条
- (void)showNavBatBottomLine;

//添加登陆按钮
//- (void)addLoginBtn:(void(^)(BOOL isLogin, LoginViewController *loginVC))loginBlock loginOKBlock:(void (^)())loginOKBlock;
//添加登陆按钮简化版本
//- (void)addLoginBtn;

-(void)setLeftBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;
-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;
-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action isRoand:(BOOL)roand;
/*****
 set  rightBarButton
 *****/
-(void)setrightBarButtonItem:(NSString *)imageName Event:(SEL)_event;

- (void)presentVC:(UIViewController *)vc animated:(BOOL)animated;
- (void)dismissVC:(BOOL)animated;
- (void)pushVC:(UIViewController *)vc animated:(BOOL)animated;
- (void)popVC:(BOOL)animated;
- (void)popToRoot:(BOOL)animated;
- (void)popToInderx:(int)index animated:(BOOL)animated;
//IOS7无状态栏高度
float originY(float Originy);

@end
