#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "ObjectBuilder.h"

@interface InterfaceModels : NSObject

@end

@interface getAgeGroupOBJ: MTLModel<MTLJSONSerializing>
@end

//首页图详情
@interface getRecommendTraceInfoOBJ : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *MapCategoryID;
@property (nonatomic,strong) NSString *CountryID;
@property (nonatomic,strong) NSString *ThumbnailSimpleUrl;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *CityID;
@property (nonatomic,strong) NSString *UseCount;
@property (nonatomic,strong) NSString *UnlikeCount;
@property (nonatomic,strong) NSString *ThumbnailDetailUrl;
@property (nonatomic,strong) NSString *AreaID;
@property (nonatomic,strong) NSString *UseCompleteCount;
@property (nonatomic,strong) NSString *ThumbnailUrl;
@property (nonatomic,strong) NSString *CreateTime;
@property (nonatomic,strong) NSString *ThumbnailSmallUrl;
@property (nonatomic,strong) NSString *LikeCount;
@property (nonatomic,strong) NSString *OverallLength;
@property (nonatomic,strong) NSString *ProvinceID;
@property (nonatomic,strong) NSString *RecommendCount;

//所有的数据
+ (NSArray *)allOBJS;
//根据ID获取缓存数据
+ (id)OBJWihtID:(NSString *)ID;
//保存自己
- (void)saveSelf:(void (^)(BOOL))block;
//保存自己
- (BOOL)saveSelf;
//删除自己
- (BOOL)delSelf;
//更新
- (BOOL)updataSelf;
//删除所有
+ (void)removeAll;
@end

//评论信息
@interface BestCommentOBJ: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *PublishTime;
@property (nonatomic,strong) NSString *AudioUrl;
@property (nonatomic,strong) NSString *Content;
@property (nonatomic,strong) NSString *DisplayName;
@property (nonatomic,strong) NSString *PhotoUrl;
@property (nonatomic,strong) NSString *IsLiked;
@property (nonatomic,strong) NSString *LikeCount;

@end

//交通信息
@interface TraceLineInfoOBJ: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *DetelID;
@property (nonatomic,strong) NSString *TrafficInfoDetails;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *UseCount;
@property (nonatomic,strong) NSString *LineInfoSummary;
@property (nonatomic,strong) NSString *ThumbnailDetailUrl;
@property (nonatomic,strong) NSString *SupplyInfoWater;
@property (nonatomic,strong) NSString *LineInfoDetails;
@property (nonatomic,strong) NSString *LikeCount;
@property (nonatomic,strong) NSString *OverallLength;
@property (nonatomic,strong) NSString *EstimateTime;
@property (nonatomic,strong) NSString *SupplyInfoSummary;
@property (nonatomic,strong) NSString *SupplyInfoWC;
@property (nonatomic,strong) NSString *TrafficInfoSummary;

//根据ID获取缓存数据
+ (id)OBJWihtID:(NSString *)ID;
//删除自己
+ (BOOL)delWithID:(NSString *)ID;
//保存自己
- (BOOL)saveSelf;
@end
//最佳记录
@interface BestRecordOBJ: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *StartTime;
@property (nonatomic,strong) NSString *LikeCount;
@property (nonatomic,strong) NSString *TotalTime;
@property (nonatomic,strong) NSString *DisplayName;
@property (nonatomic,strong) NSString *OverallLength;
@property (nonatomic,strong) NSString *FinishTime;
@property (nonatomic,strong) NSString *IsLiked;
@property (nonatomic,strong) NSString *PhotoUrl;
@property (nonatomic,strong) NSString *PublishTime;

@end

//详情信息
@interface getTraceLineInfoOBJ: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) BestCommentOBJ *BestComment;
@property (nonatomic,strong) TraceLineInfoOBJ *TraceLineInfo;
@property (nonatomic,strong) NSString *UseCount;
@property (nonatomic,strong) NSString *LikeCount;
@property (nonatomic,strong) BestRecordOBJ *BestRecord;
@end


//周边信息
@interface getNearbyInfoOBJ : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *LikeCount;
@property (nonatomic,strong) NSString *PictureOriginalUrl;
@property (nonatomic,strong) NSString *DisplayName;
@property (nonatomic,strong) NSString *PublishTime;
@property (nonatomic,strong) NSString *PhotoUrl;
@property (nonatomic,strong) NSString *PictureUrl;
@property (nonatomic,strong) NSString *Description;

@end

//城市信息
@interface CitiesOBJ : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *CityID;
@property (nonatomic,strong) NSString *City;
@end
//省份信息
@interface getProvinceAndCityOBJ : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString  *ProvinceID;
@property (nonatomic,strong) NSString  *Province;
@property (nonatomic,strong) NSMutableArray *Cities;
@end

//类别详细信息
@interface SubCategoryOBJ : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *CategoryName;
@property (nonatomic,strong) NSString *ParentID;
@property (nonatomic,strong) NSString *SearchCount;
@end
//类别
@interface getCategoryOBJ : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString  *ID;
@property (nonatomic,strong) NSString  *CategoryName;
@property (nonatomic,strong) NSString  *ParentID;
@property (nonatomic,strong) NSString  *SearchCount;
@property (nonatomic,strong) NSMutableArray *SubCategory;
@end

//平台轨迹对应不同的轨迹线路
@interface PointOBJ: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *GraphPathCollectID;
@property (nonatomic,strong) NSString *Latitude;
@property (nonatomic,strong) NSString *Longtitude;
@property (nonatomic,strong) NSString *TraceID;
@property (nonatomic,strong) NSString *SN;
@property (nonatomic,strong) NSString *Weight;
@property (nonatomic,strong) NSString *Color;
@end
//平台轨迹基本信息
@interface CollectionOBJ: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *CreateTime;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *LikeCount;
@property (nonatomic,strong) NSString *MapCategoryID;
@property (nonatomic,strong) NSString *MapParCategoryID;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSString *OverallLength;
@property (nonatomic,strong) NSString *RecommendCount;
@property (nonatomic,strong) NSString *ThumbnailDetailUrl;
@property (nonatomic,strong) NSString *ThumbnailSimpleUrl;
@property (nonatomic,strong) NSString *ThumbnailSmallUrl;
@property (nonatomic,strong) NSString *ThumbnailUrl;
@property (nonatomic,strong) NSString *UnlikeCount;
@property (nonatomic,strong) NSString *UseCompleteCount;
@property (nonatomic,strong) NSString *UseCount;
@end
//平台轨迹
@interface getMapTraceSystemObject: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *CollectionID;
@property (nonatomic,strong) NSMutableArray *Points;
@property (nonatomic,strong) CollectionOBJ *Collection;
@end
