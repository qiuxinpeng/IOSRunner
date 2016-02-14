#import <Foundation/Foundation.h>

@interface Map : NSObject

@property (nonatomic) RunStatus runStatus;  //跑步状态
@property (nonatomic, strong) NSDate *startTime;   //开始跑步时间
@property (nonatomic, strong) NSDate *finishTime;  //结束跑步时间
@property (nonatomic) int totalTimeSecond;   //跑步用时秒数
@property (nonatomic, strong) NSMutableArray *arrLatLngs;   //定位点集合

- (void) run;
- (void) pause;
- (void) stop;

@end
