#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchkit/AMapSearchKit.h>
#import <MAMapKit/MALineDrawType.h>
#import "PassValueDelegate.h"

@interface NavMainViewController : BaseViewController<MAMapViewDelegate, AMapSearchDelegate>
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
//@property (strong, nonatomic) IBOutlet AMapSearchAPI *search;

@property (nonatomic, strong) MAPolyline *commonPolyline;   //导航页折线
@property (nonatomic, weak) getMapTraceSystemObject *mapTraceSystem;   //导航页轨迹点信息
@property int collectionID;

@end
