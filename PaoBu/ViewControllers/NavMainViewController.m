#import "NavMainViewController.h"
#import "TraceMap.h"
#import "BlankMap.h"
#import "MutableArrayManager.h"
#import "PBSavemapTrace.h"

@interface NavMainViewController ()
@property double overallLength;
@end

@implementation NavMainViewController

@synthesize traceMapPolyline;
@synthesize collectionID;
@synthesize labOverallLength;
@synthesize btnOperation;
@synthesize timeDistanceView;
@synthesize completeUploadView;
@synthesize timer;

- (NSString *)tabImageName{ return @"navigation.png"; }
- (NSString *)tabTitle{ return @"导航"; }
- (NSString *)activeTabImageName{ return @"navigation1.png"; }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar = YES;
    self.title = @"导航";
    
    //解决文本框被遮挡的问题
    [self.mapView bringSubviewToFront:self.labOverallLength];
    [self.mapView bringSubviewToFront:self.btnOperation];   //开始按钮
    
    self.labOverallLength.hidden = YES;
    
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.delegate = self;
    self.mapView.showsScale = NO;
    
    //初始化时间距离 View
    if (!self.timeDistanceView) {
        self.timeDistanceView = [TimeDistanceView instancetWihtXIB];
        //self.timeDistanceView.frame = CGRectMake(0, 0, self.view.ui_width, 140);
        [self.view addSubview:self.timeDistanceView];
        //跑步计时器
        timer = [[MZTimerLabel alloc] initWithLabel:self.timeDistanceView.labRunngingTime];
        timer.textAlignment = NSTextAlignmentCenter;
    }
    
    //初始化完成上传 View
    self.completeUploadView = [CompleteUploadView instancetWihtXIB];
    [self.completeUploadView setHidden:YES];
    [self.view addSubview:self.completeUploadView];
    
    QXPDispatch_after(0.3, ^{
        //MAUserTrackingModeFollow 是否追踪用户定位，并在地图上显示（需要与showsUserLocation配合使用）
        self.mapView.userTrackingMode = MAUserTrackingModeNone;
        self.mapView.zoomEnabled = YES; //是否支持缩放地图，模拟器使用 option键模拟双指缩小，双击放大
        self.mapView.showsUserLocation = YES;   //是否显示用户定位
        self.mapView.pausesLocationUpdatesAutomatically = NO;   //允许后台运行
        self.mapView.allowsBackgroundLocationUpdates = YES; //iOS9以上系统必须配置
    });
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //已有轨迹点 ID
    if(self.collectionID != 0){
        self.map = [[TraceMap alloc] init];
        [[BBInterFace interfaceWithFinshBlock:^(getMapTraceSystemObject *responseObj) {
            self.mapTraceSystem = responseObj;
            [self showMapTrace];
            //self.collectionID = 0;
        } faildBlock:^(NSError *err) {
            NSLog(@"%@", err);
        } HUDBackgroundView:self.view tag:self.tagWithInterFace] getMapTraceSystem:[NSString stringWithFormat:@"%d", self.collectionID]];
    }else{//MAUserTrackingModeFollow 是否追踪用户定位，并在地图上显示（需要与showsUserLocation配合使用）
        self.map = [[BlankMap alloc] init];
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
}
//更新用户位置信息
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation updatingLocation:(BOOL)updatingLocation{
    if (self.map.runStatus == RunStatusIsRunning) {
        //CLLocation *currentLocation = userLocation.location;
        NSArray *point1;
        NSInteger count = self.map.arrLatLngs.count;
        if(count > 0){
            point1 = [MutableArrayManager getLastItem:self.map.arrLatLngs];
        }else{
            point1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:userLocation.location.coordinate.latitude], [NSNumber numberWithDouble:userLocation.location.coordinate.longitude], nil];
            [MutableArrayManager addMutableArray:self.map.arrLatLngs Lat:userLocation.location.coordinate.latitude Lng:userLocation.location.coordinate.longitude];
        }
        
        double distance = [MutableArrayManager getDistanceLat1:[point1[0] doubleValue] Lng1:[point1[1] doubleValue] Lat2:userLocation.coordinate.latitude Lng2:userLocation.coordinate.longitude];
        //NSLog(@"两点间距离：%f", distance);
        if(distance > twoPointsDistance){   //认为位置有移动
            //将最新位置坐标加入数组
            [MutableArrayManager addMutableArray:self.map.arrLatLngs Lat:userLocation.coordinate.latitude Lng:userLocation.coordinate.longitude];
            //绘画轨迹
            CLLocationCoordinate2D commonPolylineCoords[2];
            commonPolylineCoords[0] = CLLocationCoordinate2DMake([point1[0] doubleValue], [point1[1] doubleValue]);
            commonPolylineCoords[1] = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            
            //构造折线对象
            MAPolyline *polyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
            
            //在地图上添加折线对象
            [_mapView addOverlay: polyline];
        }
        
    }
}
//折线回调函数
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]]){
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

//在地图View停止定位后，会调用此函数
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    [self.mapView removeFromSuperview];
//    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void) showMapTrace{
    //构造折线数据对象
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    long traceCount = self.mapTraceSystem.Points.count;
    self.labOverallLength.text = [NSString stringWithFormat:@"里程：%@公里", self.mapTraceSystem.Collection.OverallLength];
    self.labOverallLength.layer.cornerRadius = 5;
    CLLocationCoordinate2D point;
    for (int i=0; i<traceCount; i++) {
        long count = [(NSArray *)self.mapTraceSystem.Points[i] count];
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
        traceMapPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:count];
        
        //在地图上添加折线对象
        [_mapView addOverlay: traceMapPolyline];
    }
    [_mapView showAnnotations:annotations animated:YES];
}

//开始跑步按钮点击事件
- (IBAction)btnOperationClick:(id)sender {
    if(self.map.runStatus == RunstatusIsStop){   //开始跑步
        self.showNavBar = NO;
        [self.map run];
        [self updateTopConstaint:60];
        //[self.mapView setFrame:CGRectMake(0, 100, 200, self.mapView.frame.size.height-100)];
        self.timeDistanceView.hidden = NO;
        self.timeDistanceView.ui_height = 10;
        [timer start];
        self.labOverallLength.hidden = YES;
        self.showTabBar = NO;
        [self.btnOperation setTitle:@"下拉\n暂停" forState:UIControlStateNormal];
        [self.btnOperation setBackgroundImage:[UIImage imageNamed:@"navPauseButton"] forState:UIControlStateNormal];
    }else if(self.map.runStatus == RunStatusIsRunning){  //跑步状态由正在跑步到暂停
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否完成跑步?" delegate:self cancelButtonTitle:@"继续" destructiveButtonTitle:@"完成" otherButtonTitles:nil, nil];
        [sheet showInView:self.view];
        [self.map pause];
        [timer pause];
    }
}
//完成跑步按钮点击事件
- (IBAction)btnCompleteClick:(id)sender {
    self.labOverallLength.hidden = YES;
    self.completeUploadView.hidden = YES;
    self.showNavBar = YES;
    self.showTabBar = YES;
    self.btnOperation.hidden = NO;
    [self.btnOperation setTitle:@"开始\n跑步" forState:UIControlStateNormal];
    [self.btnOperation setBackgroundImage:[UIImage imageNamed:@"navStartButton"] forState:UIControlStateNormal];
    [self updateTopConstaint:0];
}
//上传跑步轨迹事件
- (IBAction)btnUploadClick:(id)sender {
    //[MBProgressHUD showError:@"密码错误"];
    [MBProgressHUD showMessage:@"正在上传..."];
    
    PBSaveMapTrace *pbSaveMapTrace = [[PBSaveMapTrace alloc] init];
    pbSaveMapTrace.startTime = self.map.startTime;
    pbSaveMapTrace.finishTime = self.map.finishTime;
    pbSaveMapTrace.totalTimeSecond = [NSString stringWithFormat:@"%d", self.map.totalTimeSecond ];
    pbSaveMapTrace.overallLength = [NSString stringWithFormat:@"%f", self.overallLength];
    
    pbSaveMapTrace.countryID = @"CN";
    pbSaveMapTrace.areaID = @"300000";
    pbSaveMapTrace.cityID = @"310100";
    pbSaveMapTrace.provinceID = @"310000";
    
    NSArray *arr = [MutableArrayManager getCollections:[NSMutableArray arrayWithObjects:self.map.arrLatLngs, nil]];
    //NSArray *arr = [NSArray arrayWithObjects:@"12.3333,145.6674|12.6664,123.5644|13.3333,144.6674|15.6664,127.5644", nil];
    pbSaveMapTrace.collections = arr;
    [[BBInterFace interfaceWithFinshBlock:^(NSNumber *responseObj) {
        if ([responseObj intValue] == 0) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessage:@"上传成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 移除HUD
                [MBProgressHUD hideHUD];
                // 提醒有没有新数据
                //[MBProgressHUD showError:@"没有新数据"];
            });
            // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            // [alert show];
        }
    } faildBlock:^(NSError *err) {
        NSLog(@"%@", err);
        [MBProgressHUD hideHUD];
    } HUDBackgroundView:self.view tag:self.tagWithInterFace] saveCustomMapTrace:pbSaveMapTrace];
    
}
//下拉暂停 - 完成、继续按钮选择事件 
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){   //完成 跑步状态由暂停到完成
        [self.map stop];
        self.map.totalTimeSecond = (int)[timer getTime];
        [self.timeDistanceView setHidden:YES];
        [self updateTopConstaint:30];
        self.labOverallLength.hidden = NO;
        self.completeUploadView.hidden = NO;
        self.completeUploadView.ui_height = 30;
        //self.completeUploadView.hidden = NO;
        self.btnOperation.hidden = YES;
        [timer reset];
    }else{  //继续，计时器恢复
        //[self.timer getTime];
        self.map.runStatus = RunStatusIsRunning;
        [timer start];
    }
}
//alert view 按钮点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"%ld", (long)buttonIndex);
}
- (void) updateTopConstaint:(int)constant{
    //删除原有约束，增加新约束，使 mapview 可以改变显示高度
    long count = self.view.constraints.count;
    NSLog(@"%@", self.view.constraints);
    for(int i=0; i<count; i++){
        NSLayoutConstraint *constraint = self.view.constraints[i];
        if([constraint.identifier isEqual: @"mapViewTop"]){
            [self.view removeConstraint: constraint];
            break;
        }
    }
    NSLog(@"%@", self.view.constraints);
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    constraint.identifier = @"mapViewTop";
    [self.view addConstraint:constraint];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.collectionID = 0;
    if(traceMapPolyline != nil){
        [self.mapView removeOverlay:traceMapPolyline];
    }
}
@end
