#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface MutableArrayManager : NSObject

//向数组中添加坐标点
+(void)addMutableArray:(NSMutableArray *)array Lat:(double)lat Lng:(double)lng;

//获取数组中最后一个坐标点元素
+(NSArray *)getLastItem:(NSMutableArray *)array;

//获取两点间距离
+(double)getDistanceLat1:(double)lat1 Lng1:(double)lng1 Lat2:(double)lat2 Lng2:(double)lng2;

//将数组中的坐标点集转换成 collections 格式字符串
+(NSArray *)getCollections:(NSMutableArray *)arr;

@end
