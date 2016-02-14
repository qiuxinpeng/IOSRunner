#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "MyMainViewController.h"
#import "HomeMainViewController.h"
#import "PhotoMainViewController.h"
#import "NavMainViewController.h"
#import "ActivityMainViewController.h"
//#import "ProgramViewController.h"
//#import "MYViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)dealloc {
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    @catch (NSException *exception) {
        // do nothing, only unregistering self from notifications
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewControllers = [self mainViewControllers];
        // Custom initialization
        //[self hideTabBarAnimated:NO];
        [self _init];
    }
    return self;
}
- (void)_init{
    [self applyTheme];
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

- (void)applyTheme{
    self.textFont = [UIFont systemFontOfSize:14];
    [self setBackgroundImageName:@"20-20w1"];
    [self setSelectedBackgroundImageName:@"20-20w1"];
    
    UIColor *color = [UIColor grayColor];
    UIColor *selectColor = [UIColor YPMainBlueColor];

    //设置未选中的Icon颜色
    [self setIconColors:@[color,color]]; // MAX 2 Colors
    //设置选中的Icon颜色
    [self setSelectedIconColors:@[selectColor,selectColor]]; // MAX 2 Colors
    //设置未选中的文字颜色
    [self setTextColor:color];
    //设置选中的文字颜色
    [self setSelectedTextColor:selectColor];
    
    self.iconGlossyIsHidden = NO;
    self.iconShadowColor = [UIColor clearColor];
//    self.tabIconPreRendered = NO;
//    self.isGradient = NO;
    self.isFillBackgroundNoisePattern = YES;
    
    [self setTabEdgeColor:[UIColor clearColor]];
    [self setTabInnerStrokeColor:[UIColor clearColor]];
    [self setTabStrokeColor:[UIColor clearColor]];
    [self setTopEdgeColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]];
    [self setTabColors:@[[UIColor clearColor],[UIColor clearColor]]]; // MAX 2 Colors
    [self setSelectedTabColors:@[[UIColor clearColor],[UIColor clearColor]]];
//    [self loadTabs];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.selectedViewController;
}
- (NSMutableArray *)mainViewControllers{
    HomeMainViewController *VCHomeMain = [[HomeMainViewController alloc] initWithNibName:@"HomeMainViewController" bundle:nil];
    NavMainViewController *VCNavMain = [[NavMainViewController alloc] initWithNibName:@"NavMainViewController" bundle:nil];
    PhotoMainViewController *VCPhotoMain = [[PhotoMainViewController alloc] initWithNibName:@"PhotoMainViewController" bundle:nil];
    ActivityMainViewController *VCActivityMain = [[ActivityMainViewController alloc] initWithNibName:@"ActivityMainViewController" bundle:nil];
    MyMainViewController *VCMyMain = [[MyMainViewController alloc] initWithNibName:@"MyMainViewController" bundle:nil];

    NSMutableArray *viewControllers=[NSMutableArray arrayWithObjects:
                                     [self makeNavViewController:VCHomeMain],
                                     [self makeNavViewController:VCPhotoMain],
                                     [self makeNavViewController:VCNavMain],
                                     [self makeNavViewController:VCActivityMain],
                                     [self makeNavViewController:VCMyMain],
                                     nil];
    return viewControllers;
}
- (UINavigationController *)makeNavViewController:(UIViewController *)vc{
    __autoreleasing BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    nav.isShowTheme = YES;
    return nav;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
