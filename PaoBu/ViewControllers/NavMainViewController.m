#import "NavMainViewController.h"

@interface NavMainViewController ()
@end

@implementation NavMainViewController

@synthesize commonPolyline;
@synthesize collectionID;

- (NSString *)tabImageName{
    return @"cion3.png";
}
- (NSString *)tabTitle{
    return @"导航";
}
- (NSString *)activeTabImageName{
    return @"cion3.png";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar = YES;
    self.title = @"导航";
    
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.delegate = self;
//    self.search = [[AMapSearchAPI alloc] init];
//    self.search.delegate = self;
    
    QXPDispatch_after(0.3, ^{
        //MAUserTrackingModeFollow 是否追踪用户定位，并在地图上显示（需要与showsUserLocation配合使用）
        self.mapView.userTrackingMode = MAUserTrackingModeNone;
        self.mapView.zoomEnabled = YES; //是否支持缩放地图，模拟器使用 option键模拟双指缩小，双击放大
        self.mapView.showsUserLocation = YES;   //是否显示用户定位
        
        //允许后台运行
        self.mapView.pausesLocationUpdatesAutomatically = NO;
        self.mapView.allowsBackgroundLocationUpdates = YES; //iOS9以上系统必须配置
        
//        AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
//        request.address = @"外滩";
//        [self.search AMapGeocodeSearch:request];
    });
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.mapView removeOverlay:commonPolyline];
    
    //已有轨迹点 ID
    if(self.collectionID != 0){
        [[BBInterFace interfaceWithFinshBlock:^(getMapTraceSystemObject *responseObj) {
            self.mapTraceSystem = responseObj;
            [self showMapTrace];
            self.collectionID = 0;
        } faildBlock:^(NSError *err) {
            NSLog(@"%@", err);
        } HUDBackgroundView:self.view tag:self.tagWithInterFace] getMapTraceSystem:[NSString stringWithFormat:@"%d", self.collectionID]];
    }else{//MAUserTrackingModeFollow 是否追踪用户定位，并在地图上显示（需要与showsUserLocation配合使用）
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        //self.mapView.centerCoordinate = CLLocationCoordinate2DMake(31.0632270000, 121.5270620000);
    }
    
    //大头针标注
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(31.0632270000, 121.5270620000);
//    //pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"我的标注";
//    pointAnnotation.subtitle = @"阜通东大街6号";
//    
//    [self.mapView addAnnotation:pointAnnotation];
    
}

//大头针标注
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        return annotationView;
//    }
//    return nil;
//}
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation updatingLocation:(BOOL)updatingLocation{
    CLLocation *currentLocation = userLocation.location;
    if (currentLocation) {
        NSLog(@"Test -- currentLocation");
    }
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    }
}
//折线回调函数
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 10.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6];
        polylineView.lineJoinType = kMALineJoinRound;//连接类型
        polylineView.lineCapType =  kMALineCapRound;//端点类型
        
        return polylineView;
    }
    return nil;
}
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView{
}

/*!
 @brief 在地图View停止定位后，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    [self.mapView removeFromSuperview];
//    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) showMapTrace{
    //构造折线数据对象
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    int traceCount = self.mapTraceSystem.Points.count;
    CLLocationCoordinate2D point;
    for (int i=0; i<traceCount; i++) {
        int count = [(NSArray *)self.mapTraceSystem.Points[i] count];
        CLLocationCoordinate2D commonPolylineCoords[count];
        for (int j=0; j<count; j++) {
            PointOBJ *pointObj = self.mapTraceSystem.Points[i][j];
            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
            point = CLLocationCoordinate2DMake([pointObj.Latitude doubleValue], [pointObj.Longtitude doubleValue]);
            annotation.coordinate = point;
            [annotations addObject:annotation];
            commonPolylineCoords[j] = point;
        }
        //构造折线对象
        commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:count];
        
        //在地图上添加折线对象
        [_mapView addOverlay: commonPolyline];
    }
    [_mapView showAnnotations:annotations animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
