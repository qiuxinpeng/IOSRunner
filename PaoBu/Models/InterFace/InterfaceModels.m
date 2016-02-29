#import "InterfaceModels.h"
//#import "SysInfoOBJ.h"
@implementation InterfaceModels

@end

@implementation getAgeGroupOBJ

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

@end
@implementation getRecommendTraceInfoOBJ
+(BOOL)isContainParent{
    return YES;
}
+(NSString *)getPrimaryKey{
    return @"ID";
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+ (void)initialize{
    [super initialize];
    [[MainManager LKDBglobalHelper] createTableWithModelClass:[self class]];
}
//所有的数据
+ (NSArray *)allOBJS{
   return [[MainManager LKDBglobalHelper] search:[self class] where:nil orderBy:nil offset:0 count:0];
}
//根据ID获取缓存数据
+ (id)OBJWihtID:(NSString *)ID{
    id temp =[[MainManager LKDBglobalHelper] searchSingle:[self class] where:@{@"ID":ID} orderBy:nil ];
    return temp;
}
//保存自己
- (void)saveSelf:(void (^)(BOOL))block{
    return [[MainManager LKDBglobalHelper] insertToDB:self callback:block];;
}
//保存自己
- (BOOL)saveSelf{
    return [[MainManager LKDBglobalHelper] insertToDB:self];
}
//删除自己
- (BOOL)delSelf{
    return [[MainManager LKDBglobalHelper] deleteToDB:self];
}
//更新
- (BOOL)updataSelf{
    [[MainManager LKDBglobalHelper] updateToDB:self where:@{@"ID":self.ID} callback:^(BOOL result) {
        
    }];
    return YES;
    //return [[MainManager LKDBglobalHelper] updateToDB:self where:@{[self.class getPrimaryKey]:self.ID}];
}
//删除所有
+ (void)removeAll{
    [[MainManager LKDBglobalHelper] deleteWithClass:[self class] where:nil];
}

@end


@implementation BestCommentOBJ

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

@end
@implementation TraceLineInfoOBJ

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+(NSString *)getPrimaryKey{
    return @"DetelID";
}
+ (void)initialize{
    [super initialize];
    [[MainManager LKDBglobalHelper] createTableWithModelClass:[self class]];
}
//根据ID获取缓存数据
+ (id)OBJWihtID:(NSString *)ID{
//    NSArray *arr=[[MainManager LKDBglobalHelper] search:[self class] where:@{@"DetelID":ID} orderBy:nil offset:0 count:0];
//    if (arr.count>0) {
//        return arr[0];
//    }
    id temp =[[MainManager LKDBglobalHelper] searchSingle:[self class] where:@{@"DetelID":ID} orderBy:nil ];
    return temp;
}
//删除自己
+ (BOOL)delWithID:(NSString *)ID{
   return [[MainManager LKDBglobalHelper] deleteWithClass:[self class] where:@{@"DetelID":ID}];
}
//保存自己
- (BOOL)saveSelf{
    return [[MainManager LKDBglobalHelper] insertToDB:self];
}
@end
@implementation BestRecordOBJ

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

@end
@implementation getTraceLineInfoOBJ
- (TraceLineInfoOBJ *)TraceLineInfo{
    if (!_TraceLineInfo) {
        _TraceLineInfo=[TraceLineInfoOBJ OBJWihtID:self.ID];
    }
    return _TraceLineInfo;
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+ (NSValueTransformer *)BestCommentJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BestCommentOBJ.class];
}
+ (NSValueTransformer *)TraceLineInfoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:TraceLineInfoOBJ.class];
}
+ (NSValueTransformer *)BestRecordJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BestRecordOBJ.class];
}
@end
@implementation getNearbyInfoOBJ
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
@end
@implementation CitiesOBJ
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
@end
@implementation getProvinceAndCityOBJ
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+ (NSValueTransformer *)CitiesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CitiesOBJ.class];
}
@end

@implementation SubCategoryOBJ
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
@end
@implementation getCategoryOBJ
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+ (NSValueTransformer *)SubCategoryJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:SubCategoryOBJ.class];
}
@end

@implementation PointOBJ

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
@end
//@implementation PointsObject
//
//+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return nil;
//}
//+ (NSValueTransformer *)TraceJSONTransformer {
//    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:TraceOBJ.class];
////    return [MTLValueTransformer transformerWithBlock:^id(id value) {
////        NSDictionary *dic = value;
////        
////        return [MTLJSONAdapter modelOfClass:[PointsObject class] fromJSONDictionary:dic error:nil];
////        
////    }];
//}
//@end

@implementation CollectionOBJ

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
@end

//获取平台轨迹
@implementation getMapTraceSystemObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+ (NSValueTransformer *)PointsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:PointOBJ.class];
//    return [MTLValueTransformer transformerWithBlock:^id(id value) {
//        NSDictionary *dic = value;
//        NSArray *array = [NSArray arrayWithObjects:[dic],nil];
//        NSDictionary *points = [NSDictionary with]
//        return [MTLJSONAdapter modelOfClass:[PointsObject class] fromJSONDictionary:dic error:nil];
//        
//    }];
}
+ (NSValueTransformer *)CollectionJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:CollectionOBJ.class];
}
@end

