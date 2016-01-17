//
//  NavMainViewController.m
//  PaoBu
//
//  Created by 邱玲 on 15/8/28.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "NavMainViewController.h"

@interface NavMainViewController ()

@end

@implementation NavMainViewController
- (NSString *)tabImageName
{
    return @"cion3.png";
}
- (NSString *)tabTitle
{
    return @"导航";
}
- (NSString *)activeTabImageName
{
    return @"cion3.png";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar = YES;
    self.title = @"导航";
    
//    [[BBInterFace interfaceWithFinshBlock:^(id responseObje) {
//        NSLog(@"responseObje:%@",responseObje);
//        
//    } faildBlock:^(NSError *err) {
//    } HUDBackgroundView:self.view tag:[NSString stringWithFormat:@"%d", self.collectionID]] getMapTraceSystem];
    
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.delegate = self;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.mapView.centerCoordinate =CLLocationCoordinate2DMake(31.0632270000, 121.5270620000);
    
    QXPDispatch_after(0.3, ^{
        self.mapView.userTrackingMode = MAUserTrackingModeNone;
        //self.mapView.zoomEnabled =
        self.mapView.showsUserLocation = YES;
        
        //允许后台运行
        self.mapView.pausesLocationUpdatesAutomatically = NO;
        self.mapView.allowsBackgroundLocationUpdates = YES; //iOS9以上系统必须配置
        
        AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
        request.address = @"外滩";
        [self.search AMapGeocodeSearch:request];
        
        
    });

}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(31.0632270000, 121.5270620000);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [self.mapView addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation updatingLocation:(BOOL)updatingLocation
{
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
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView{


}

/*!
 @brief 在地图View停止定位后，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
