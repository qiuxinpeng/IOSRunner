#import <UIKit/UIKit.h>
#import "CRNavigationController.h"

//@interface UINavigationController (Orientations)
//-(BOOL)shouldAutorotate;
//-(NSUInteger)supportedInterfaceOrientations;
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;
//
//@end
//
//
//
//@implementation UINavigationController (Orientations)
//-(BOOL)shouldAutorotate
//{
//    return [[self topViewController] shouldAutorotate];
//}
//-(NSUInteger)supportedInterfaceOrientations
//
//{
//    return [[self topViewController] supportedInterfaceOrientations];
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//
//{
//    return [[self topViewController] preferredInterfaceOrientationForPresentation];
//}
//@end

@interface BaseNavigationController : CRNavigationController

@property(nonatomic, assign)BOOL isShowTheme;

@end
