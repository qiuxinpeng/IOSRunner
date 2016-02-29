#import "UIViewController+units.h"
#import <objc/runtime.h>

@implementation UIViewController (barItem)

const char InterfaceTagKey;

-(void)setLeftBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action{
    UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 7, 40, 25)];
    [mybtn setTitle:title forState:UIControlStateNormal];
    //[mybtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [mybtn setBackgroundImage:[UIImage imageNamed:inmageName] forState:UIControlStateNormal];
    [mybtn addTarget:self action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mybtn];
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;
}

-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action{
    UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 7, 40, 25)];
    [mybtn setTitle:title forState:UIControlStateNormal];
    mybtn.titleLabel.font  = [UIFont systemFontOfSize:12];
    [mybtn setBackgroundImage:[UIImage imageNamed:inmageName] forState:UIControlStateNormal];
    [mybtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mybtn];
    self.navigationItem.rightBarButtonItem=temporaryBarButtonItem;
}

- (NSString *)tagWithInterface{
    NSString *tegStr = objc_getAssociatedObject(self, &InterfaceTagKey);
    if(tegStr == nil){
        tegStr = [NSString stringWithFormat:@"%@_%d_%d",NSStringFromClass([self class]),rand(),rand()];
        objc_setAssociatedObject(self, &InterfaceTagKey, tegStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return tegStr;
}

@end
