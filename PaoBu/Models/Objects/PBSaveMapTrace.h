//  保存用户跑步轨迹时的参数对象 Model

#import <Foundation/Foundation.h>

@interface PBSaveMapTrace : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSDate *startTime;
@property (nonatomic,strong) NSDate *finishTime;
@property (nonatomic,strong) NSString *totalTimeSecond;
@property (nonatomic,strong) NSString *overallLength;
@property (nonatomic,strong) NSString *countryID;
@property (nonatomic,strong) NSString *areaID;
@property (nonatomic,strong) NSString *cityID;
@property (nonatomic,strong) NSString *provinceID;
@property (nonatomic,strong) NSArray *collections;

@end
