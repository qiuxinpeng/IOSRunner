#import "BaseNavigationController.h"
//#import <HexColor.h>

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)init{
    if ((self=[super init])) {
        [self _init];
        return self;
    }
    return nil;
}
- (id)initWithRootViewController:(UIViewController *)rootViewController{
    if ((self=[super initWithRootViewController:rootViewController])) {
        [self _init];
        return self;
    }
    return nil;
}
- (void)_init{
    [self applyTheme];
}
- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}
- (void)applyTheme{
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"f2f2f2.png"] forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    if (QXPSystemVersionGreaterOrEqualThan(7)) {
        //[self.navigationBar setTintColor:[UIColor colorWithRed:0.16 green:0.55 blue:0.86 alpha:1]];
        [self.navigationBar setBarTintColor:[UIColor colorWithRed:21.0/255.0 green:194.0/255.0 blue:179.0/255.0 alpha:0.5]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];

        [UIColor colorWithRed:0.16 green:0.55 blue:0.86 alpha:1];

        if (self.isShowTheme) {
            [self.navigationBar setBarTintColor:[UIColor YPMainBlueColor]];
        }else{
            [self.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#26B7B0"]];
        }
        //[self.navigationBar setBarTintColor:[MainTool navColor]];
    }else{
        [self.navigationBar setTintColor:[UIColor colorWithRed:0.16 green:0.55 blue:0.86 alpha:1]];

        if (self.isShowTheme) {
            [self.navigationBar setTintColor:[UIColor YPMainBlueColor]];
        }else{
            [self.navigationBar setTintColor:[UIColor colorWithHexString:@"#26B7B0"]];
        }
    }
    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    [self.navigationBar setTitleTextAttributes:@{   UITextAttributeTextColor:[UIColor whiteColor],
                                                    UITextAttributeFont :[UIFont boldSystemFontOfSize:19],
                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                    }];
}

- (void)setIsShowTheme:(BOOL)isShowTheme{
    _isShowTheme=isShowTheme;
    [self applyTheme];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    //[BBInterface cancelForTag:self.visibleViewController.tagWithInterface];
    return [super popViewControllerAnimated:animated];
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    return [super popToViewController:viewController animated:animated];
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    return [super popToRootViewControllerAnimated:animated];
}

- (void)loadView{
    [super loadView];
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
