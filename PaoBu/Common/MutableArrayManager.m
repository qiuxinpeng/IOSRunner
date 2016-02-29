#import "MutableArrayManager.h"

@implementation MutableArrayManager

//向数组中添加坐标点
+(void)addMutableArray:(NSMutableArray *)array Lat:(double)lat Lng:(double)lng{
    NSArray *point = [NSArray arrayWithObjects:[NSNumber numberWithDouble:lat], [NSNumber numberWithDouble:lng], nil];
    if(array == nil){
        array = [NSMutableArray arrayWithObjects:point, nil];
    }else{
        [array addObject:point];
    }
}

//获取数组中最后一个坐标点元素
+(NSArray *)getLastItem:(NSMutableArray *)array{
    return [array objectAtIndex:(array.count - 1)];
}

//获取两点间距离
+(double)getDistanceLat1:(double)lat1 Lng1:(double)lng1 Lat2:(double)lat2 Lng2:(double)lng2 {
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(lat1, lng1));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(lat2, lng2));
    
    return MAMetersBetweenMapPoints(point1, point2);
}

//将数组中的坐标点集转换成 collections 格式字符串
+(NSMutableArray *)getCollections:(NSMutableArray *)arr{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSMutableArray *a in arr) {
        NSMutableArray * newArr = [[NSMutableArray alloc] init];
        for (NSMutableArray *point in a) {
            [newArr addObject:[NSMutableString stringWithFormat:@"%@,%@", point[0], point[1]]];
        }
        [result addObject:[newArr componentsJoinedByString:@"|"]];
    }
    return result;
}

@end
