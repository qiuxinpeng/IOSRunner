//
//  MKMapView+Helper.h
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-7-24.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (Helper)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

//计算两经纬度距离
+(double)distanceBetweenOrderBy:(double)lat1 :(double)lng1 :(double)lat2 :(double)lng2;
@end
