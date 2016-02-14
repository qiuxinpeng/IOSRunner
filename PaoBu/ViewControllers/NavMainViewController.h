#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchkit/AMapSearchKit.h>
#import <MAMapKit/MALineDrawType.h>
#import <UIKit/UIActionSheet.h>
#import "Map.h"
#import "TimeDistanceView.h"
#import "CompleteUploadView.h"

@interface NavMainViewController : BaseViewController<MAMapViewDelegate, AMapSearchDelegate, UIActionSheetDelegate, UIAlertViewDelegate>


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@property (weak, nonatomic) IBOutlet UILabel *labOverallLength; //里程
@property (weak, nonatomic) IBOutlet UIButton *btnOperation;    //操作按钮
@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@property (nonatomic, strong) MAPolyline *traceMapPolyline;   //导航页轨迹折线
@property (nonatomic, weak) getMapTraceSystemObject *mapTraceSystem;   //导航页轨迹点信息
@property (nonatomic, strong) Map *map;
@property (nonatomic, strong) TimeDistanceView *timeDistanceView;
@property (nonatomic, strong) CompleteUploadView *completeUploadView;
@property (nonatomic, strong) MZTimerLabel *timer;  //跑步计时器
@property int collectionID; //当前轨迹 collectionID

- (IBAction)btnOperationClick:(id)sender;
- (IBAction)btnCompleteClick:(id)sender;
- (IBAction)btnUploadClick:(id)sender;

@end
