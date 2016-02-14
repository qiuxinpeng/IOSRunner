#import "ActivityMainViewController.h"

@interface ActivityMainViewController ()

@end

@implementation ActivityMainViewController
- (NSString *)tabImageName{ return @"activity.png"; }
- (NSString *)tabTitle{ return @"活动"; }
- (NSString *)activeTabImageName{ return @"activity1.png"; }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
