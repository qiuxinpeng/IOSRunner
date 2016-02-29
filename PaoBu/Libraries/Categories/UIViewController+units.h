#import <UIKit/UIKit.h>

@interface UIViewController (barItem)
//根据Btn来创建barItem
-(void)setLeftBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;
-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;

- (NSString *)tagWithInterface;

@end
