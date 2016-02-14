#import "BlankMap.h"

@implementation BlankMap

- (void) run{
    [super run];    //基类判断当前网络是否可以开始定位
    NSLog(@"BlankMap run");
    self.runStatus = RunStatusIsRunning;
}
@end
