#import "TraceMap.h"

@implementation TraceMap

- (void) run{
    [super run];    //基类判断当前网络是否可以开始定位
    NSLog(@"TraceMap run");
    //如果当前位置是轨迹起点位置，则可以开始
    self.runStatus = RunStatusIsRunning;
}
@end
