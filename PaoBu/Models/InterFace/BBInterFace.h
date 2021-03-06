#import "QXPNetWorkInterface.h"
#import "InterfaceModels.h"

#define LUOJI_ERROR_CODE 40000
#define SERVICE_URL @"http://interface.paoditu.com/index.php?format=json&source=ios&encrypt=1&"
//#define SERVICE_URL @"http://interf.minsubnb.com/index.php?format=json&source=ios&encrypt=1&"
#define makeURLString(path) [NSString stringWithFormat:@"%@%@", SERVICE_URL, path]

@class PBSaveMapTrace;

@interface NSMutableArray(addParameter)
- (void)addParameter:(NSString *)name   parameterValue:(id)value  parameterType:(QXPNetWorkParameterType)Type;
- (void)addParameter:(NSString *)name   parameterValue:(id)value  fileName:(NSString *)fileName   parameterType:(QXPNetWorkParameterType)type;
- (void)addParameter:(NSString *)name   parameterValue:(id)value  fileName:(NSString *)fileName   contentType:(NSString *)contentType    parameterType:(QXPNetWorkParameterType)type;
- (void)joinParameters; //合并参数统一加密
@end

typedef id (^InterfaceModelBlock)(id object,NSError **err);

@interface BBInterface : QXPNetWorkInterface
@property (nonatomic, strong) InterfaceModelBlock modelBlock;
@property (nonatomic, assign) BOOL                isShowErrorHUDView;
- (void)setModelBlock:(id (^)(id object,NSError **err))modelBlock;
- (void)startLoadInformationWithParameters:(NSMutableArray *)arr URLPath:(NSString *)string connectType:(QXPNetWorkType)type;

#pragma   -mark 1 UserLogin
-(void)UserLogin:(NSString *)userID password:(NSString *)password;
#pragma   -mark 37 UserLogin
- (void)UserGetUserInfo;
#pragma   -mark  62-uploadPhoto
- (void)uploadPhoto:(UIImage *)photo;
#pragma   -mark  58-editPersonalInfo - (更新个人信息)
- (void)editPersonalInfo:(NSString *)displayName genderID:(NSString *)genderID ageID:(NSString *)ageID hobbies:(NSString *)hobbies hobbiesDetail:(NSString *)hobbiesDetail signature:(NSString *)signature height:(NSString *)height weight:(NSString *)weight;
#pragma   -mark  57-getAgeGroup - (获取用户年龄组信息)
- (void)getAgeGroup;
#pragma   -mark  54-getRecommendTraceInfo - (获取首页推荐图形轨迹)
- (void)getRecommendTraceInfo;
#pragma   -mark  51-getNotice - (获取首页通知内容)
- (void)getNotice;
#pragma   -mark  75-getTraceLineInfo - 获取线路详情信息
- (void)getTraceLineInfo:(NSString *)collectionID;
#pragma   -mark  77-getNearbyInfo - (获取周边信息)
- (void)getNearbyInfo:(NSString *)collectionID start:(NSString *)start pageNum:(NSString *)pageNum;
#pragma   -mark  79-getCommentInfo - (获取评论信息)
- (void)getCommentInfo:(NSString *)collectionID start:(NSString *)start pageNum:(NSString *)pageNum;
#pragma   -mark  78-getRecordInfo - (获取历史记录信息)
- (void)getRecordInfo:(NSString *)collectionID start:(NSString *)start pageNum:(NSString *)pageNum;
#pragma   -mark  82-getProvinceAndCity - (获取城市信息)
- (void)getProvinceAndCity:(NSString *)timeStamp;
#pragma   -mark  80-getCategory - (获取类别信息)
- (void)getCategory:(NSString *)timeStamp;
#pragma   -mark  66-getMapTraceSystem - (获取平台轨迹)
- (void) getMapTraceSystem:(NSString *)collectionID;
#pragma   -mark  40-UserSaveCustomMapTrace - (保存用户跑步轨迹)
- (void) saveCustomMapTrace:(PBSaveMapTrace *)pbSaveMapTrace;
#pragma   -mark  84-getGalleryMapTrace - (获取图库图形轨迹信息)
- (void) getGalleryMapTrace:(NSString *)timeStamp categoryID:(NSString *)categoryID cityID:(NSString *)cityID provinceID:(NSString *)provinceID startPage:(NSString *)startPage pageNum:(NSString *)pageNum;
@end
