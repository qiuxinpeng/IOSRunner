//
//  UIViewAdditions.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "UIViewAdditions.h"
#import "QXPImageView.h"


// Remove GSEvent and UITouchAdditions from Release builds
#ifdef DEBUG

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * A private API class used for synthesizing touch events. This class is compiled out of release
 * builds.
 *
 * This code for synthesizing touch events is derived from:
 * http://cocoawithlove.com/2008/10/synthesizing-touch-event-on-iphone.html
 */
@interface GSEventFake : NSObject {
@public
    int ignored1[5];
    float x;
    float y;
    int ignored2[24];
}
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation GSEventFake
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface UIEventFake : NSObject {
@public
    CFTypeRef               _event;
    NSTimeInterval          _timestamp;
    NSMutableSet*           _touches;
    CFMutableDictionaryRef  _keyedTouches;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIEventFake

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface UITouch (TTCategory)

///**
// *
// */
//- (id)initInView:(UIView *)view location:(CGPoint)location;
//
///**
// *
// */
//- (void)changeToPhase:(UITouchPhase)phase;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UITouch (TTCategory)
//xcode4.5中编译出错，暂时注释

///////////////////////////////////////////////////////////////////////////////////////////////////
//- (id)initInView:(UIView *)view location:(CGPoint)location {
//  if (self = [super init]) {
//    _tapCount = 1;
//    _locationInWindow = location;
//    _previousLocationInWindow = location;
//
//    UIView *target = [view.window hitTest:_locationInWindow withEvent:nil];
//    _view = [target retain];
//    _window = [view.window retain];
//    _phase = UITouchPhaseBegan;
//    _touchFlags._firstTouchForView = 1;
//    _touchFlags._isTap = 1;
//    _timestamp = [NSDate timeIntervalSinceReferenceDate];
//  }
//  return self;
//}
//
//
///////////////////////////////////////////////////////////////////////////////////////////////////////
//- (void)changeToPhase:(UITouchPhase)phase {
//  _phase = phase;
//  _timestamp = [NSDate timeIntervalSinceReferenceDate];
//}


@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIEvent (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTouch:(UITouch *)touch {
    //    if (self == [super init]) {   //facebook习惯写法，但是是苹果不建议的，代码检查会有问题。wh see:http://stackoverflow.com/questions/7840535/should-init-be-assigning-or-testing-equality-on-self-init
    if (self = [super init]) {
        UIEventFake *selfFake = (UIEventFake*)self;
        selfFake->_touches = [NSMutableSet setWithObject:touch] ;
        selfFake->_timestamp = [NSDate timeIntervalSinceReferenceDate];
        
        CGPoint location = [touch locationInView:touch.window];
        GSEventFake* fakeGSEvent = [[GSEventFake alloc] init];
        fakeGSEvent->x = location.x;
        fakeGSEvent->y = location.y;
        selfFake->_event = (__bridge CFTypeRef)(fakeGSEvent);
        
        CFMutableDictionaryRef dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 2,
                                                                &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        CFDictionaryAddValue(dict, (__bridge const void *)(touch.view), (__bridge const void *)(selfFake->_touches));
        CFDictionaryAddValue(dict, (__bridge const void *)(touch.window), (__bridge const void *)(selfFake->_touches));
        selfFake->_keyedTouches = dict;
    }
    return self;
}


@end

#endif


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Additions.
 */

@implementation UIView (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ui_height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.ui_left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.ui_top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.ui_left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.ui_top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.ui_width, self.ui_height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)ui_origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)ui_size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUi_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.ui_height : self.ui_width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.ui_width : self.ui_height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


#ifdef DEBUG

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)simulateTapAtPoint:(CGPoint)location {
    //  UITouch *touch = [[[UITouch alloc] initInView:self location:location] autorelease];
    //
    //  UIEvent *eventDown = [[[UIEvent alloc] initWithTouch:touch] autorelease];
    //  [touch.view touchesBegan:[NSSet setWithObject:touch] withEvent:eventDown];
    //
    //  [touch changeToPhase:UITouchPhaseEnded];
    //
    //  UIEvent *eventUp = [[[UIEvent alloc] initWithTouch:touch] autorelease];
    //  [touch.view touchesEnded:[NSSet setWithObject:touch] withEvent:eventUp];
}

#endif


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.ui_left;
        y += view.ui_top;
    }
    return CGPointMake(x, y);
}


@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIView (XYNavigation)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (UINavigationController *)navigationController{
    UIViewController *viewController = [self viewController];
    if (viewController) {
        if (viewController.navigationController) {
            return viewController.navigationController;
        }
    }
    return nil;
}
@end

@implementation UIView (xib)
+(instancetype)instancetWihtXIB{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil];
    return [nib objectAtIndex:0];
}
@end
// UIActionSheet扩展
@implementation UIActionSheet(UIActionSheetShowInAppWindow)

- (void)showInMyAppDelegateWindow
{
    //    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self showInView:[UIApplication sharedApplication].delegate.window];
}

@end
