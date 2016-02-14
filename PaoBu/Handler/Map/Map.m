#import "Map.h"

@interface Map()

@end

@implementation Map

@synthesize runStatus;
@synthesize startTime;
@synthesize finishTime;
@synthesize totalTimeSecond;
@synthesize arrLatLngs;

- (void) run{
    //基类判断当前网络是否可以开始定位
    self.runStatus = RunStatusIsRunning;
    self.totalTimeSecond = 0;
    if(self.arrLatLngs.count > 0) [self.arrLatLngs removeAllObjects];
    self.startTime = [[NSDate alloc] init];
    //self.arrLatLngs = [[NSMutableArray alloc] init];
}

- (void) pause{
    self.runStatus = RunStatusIsPause;
}

- (void) stop{
    self.runStatus = RunstatusIsStop;
    self.finishTime = [[NSDate alloc] init];
}

@end
