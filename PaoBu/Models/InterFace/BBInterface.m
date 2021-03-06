#import "BBInterface.h"
#import "QXPNetWorkTools.h"
#import "EGOCache.h"
#import "NSObject+JSON.h"
#import "ObjectBuilder.h"
#import "OpenUDID.h"
//#import "SysInfoOBJ.h"
#import "QXPCacheUtility.h"
#import "QXPCacheForUser.h"
#import "PBSaveMapTrace.h"

@implementation BBInterface

- (instancetype)init{
    if ((self = [super init])){
        self.isShowErrorHUDView = YES;
    }
    return self;
}

#pragma   -mark 1 UserLogin
-(void)UserLogin:(NSString *)userID password:(NSString *)password{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSDictionary *tempDict=[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"];
        return [MTLJSONAdapter modelOfClass:PBUser.class fromJSONDictionary:tempDict error:nil];
    }];
    NSMutableArray *muArr=[NSMutableArray new];
    [muArr addParameter:@"account" parameterValue:userID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"password" parameterValue:password parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=user&method=login" connectType:QXPNetWorkTypePost];
}

#pragma   -mark 37 UserLogin
- (void)UserGetUserInfo{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSDictionary *tempDict=[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"];
        return [MTLJSONAdapter modelOfClass:PBUser.class fromJSONDictionary:tempDict error:nil];
    }];
    NSMutableArray *muArr=[NSMutableArray new];
    [muArr addParameter:@"userID" parameterValue:[PBUser userID] parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"authonToken" parameterValue:[PBUser sharedUser].AuthonToken parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=user&method=getUserInfo" connectType:QXPNetWorkTypePost];
}
#pragma   -mark  62-uploadPhoto
- (void)uploadPhoto:(UIImage *)photo{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSDictionary *tempDict=[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"];
        return tempDict;
    }];
    
    NSMutableArray *muArr=[NSMutableArray new];
    if (photo) {
        NSData *data=UIImageJPEGRepresentation(photo, 0.5);
        [muArr addParameter:@"photo" parameterValue:data fileName:@"file.jpg" contentType:@"image/jpg" parameterType:QXPNetWorkParameterTypeForm];
    }
    
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=user&method=uploadPhoto" connectType:QXPNetWorkTypePost];
}
#pragma   -mark  58-editPersonalInfo - (更新个人信息)
- (void)editPersonalInfo:(NSString *)displayName genderID:(NSString *)genderID ageID:(NSString *)ageID hobbies:(NSString *)hobbies hobbiesDetail:(NSString *)hobbiesDetail signature:(NSString *)signature height:(NSString *)height weight:(NSString *)weight{
    NSMutableArray *muArr = [NSMutableArray new];
    [muArr addParameter:@"displayName" parameterValue:displayName parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"genderID" parameterValue:genderID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"ageID" parameterValue:ageID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"hobbies" parameterValue:hobbies parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"hobbiesDetail" parameterValue:hobbiesDetail parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"signature" parameterValue:signature parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"height" parameterValue:height parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"weight" parameterValue:weight parameterType:QXPNetWorkParameterTypeDefault];

    [self startLoadInformationWithParameters:muArr URLPath:@"interface=user&method=editPersonalInfo" connectType:QXPNetWorkTypePost];
}
#pragma   -mark  57-getAgeGroup - (获取用户年龄组信息)
- (void)getAgeGroup{
    NSMutableArray *muArr = [NSMutableArray new];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=user&method=getAgeGroup" connectType:QXPNetWorkTypePost];
}

#pragma   -mark  54-getRecommendTraceInfo - (获取首页推荐图形轨迹)
- (void)getRecommendTraceInfo{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSArray *arr = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"];
        NSString *str = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"timeStamp"];
       // getRecommendTraceInfoOBJ
        [QXPCacheUtility sharedCacheUtility].home_images_timestamp=str;
        [[QXPCacheUtility sharedCacheUtility] synchronize];
        NSArray *OBJArr = [MTLJSONAdapter modelsOfClass:getRecommendTraceInfoOBJ.class fromJSONArray:arr error:nil];
        [getRecommendTraceInfoOBJ removeAll];
        for (getRecommendTraceInfoOBJ *OBJ in OBJArr) {
            [OBJ saveSelf:^(BOOL yes) {
                
            }];
        }
        return OBJArr;
    }];
    NSMutableArray *muArr = [NSMutableArray new];
    //验证缓存是否失效
//    [muArr addParameter:@"timeStamp" parameterValue:[QXPCacheUtility sharedCacheUtility].home_images_timestamp parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"timeStamp" parameterValue:0 parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=index&method=getRecommendTraceInfo" connectType:QXPNetWorkTypePost];
    self.isShowErrorHUDView = NO;
}

#pragma   -mark  51-getNotice - (获取首页通知内容)
- (void)getNotice{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSArray *arr = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"];
        NSDictionary *dict = arr.count>0?arr[0]:nil;
        NSString *str = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"timeStamp"];
        // getRecommendTraceInfoOBJ
        NSString *title = [dict objectForKey:@"Content"];
        [QXPCacheUtility sharedCacheUtility].home_notice_timestamp = str;
        [QXPCacheUtility sharedCacheUtility].home_notice_title = title;
        [[QXPCacheUtility sharedCacheUtility] synchronize];
        return title;
    }];
    NSMutableArray *muArr = [NSMutableArray new];
    [muArr addParameter:@"timeStamp" parameterValue:[QXPCacheUtility sharedCacheUtility].home_notice_timestamp parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=index&method=getNotice" connectType:QXPNetWorkTypePost];
    self.isShowErrorHUDView = NO;
}
#pragma   -mark  75-getTraceLineInfo - 获取线路详情信息
- (void)getTraceLineInfo:(NSString *)collectionID{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSDictionary *dict = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"];
        NSString *str = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"timeStamp"];
        getTraceLineInfoOBJ *tempOBJ=[MTLJSONAdapter modelOfClass:getTraceLineInfoOBJ.class fromJSONDictionary:dict error:nil];
        tempOBJ.ID=collectionID;
        
        if ([dict objectForKey:@"TraceLineInfo"]) {
            [TraceLineInfoOBJ delWithID:tempOBJ.TraceLineInfo.ID];
            tempOBJ.TraceLineInfo.DetelID = collectionID;
            if ([tempOBJ.TraceLineInfo saveSelf]) {
                NSLog(@"2222");
            }
        }
        [QXPCacheUtility sharedCacheUtility].home_detail_timestamp = str;
        [[QXPCacheUtility sharedCacheUtility] synchronize];
        return tempOBJ;
    }];
    NSMutableArray *muArr=[NSMutableArray new];
    [muArr addParameter:@"collectionID" parameterValue:collectionID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"timeStamp" parameterValue:[QXPCacheUtility sharedCacheUtility].home_detail_timestamp parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=trace&method=getTraceLineInfo" connectType:QXPNetWorkTypePost];
    self.isShowErrorHUDView = NO;
}
#pragma   -mark  77-getNearbyInfo - (获取周边信息)
- (void)getNearbyInfo:(NSString *)collectionID start:(NSString *)start pageNum:(NSString *)pageNum{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSArray *arr_NearbyRanking = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"NearbyRanking"];
        NSArray *arr_Nearby = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"Nearby"];
        NSString *count = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"Count"];
        
        NSArray *arr_r = [MTLJSONAdapter modelsOfClass:getNearbyInfoOBJ.class fromJSONArray:arr_NearbyRanking error:nil];
        NSArray *arr_n = [MTLJSONAdapter modelsOfClass:getNearbyInfoOBJ.class fromJSONArray:arr_Nearby error:nil];

        return @{@"NearbyRanking":arr_r?arr_r:@[],@"Nearby":arr_n?arr_n:@[],@"count":count};
        return nil;
    }];
    NSMutableArray *muArr = [NSMutableArray new];
    [muArr addParameter:@"collectionID" parameterValue:collectionID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"start" parameterValue:start parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"pageNum" parameterValue:pageNum parameterType:QXPNetWorkParameterTypeDefault];

    [self startLoadInformationWithParameters:muArr URLPath:@"interface=trace&method=getNearbyInfo" connectType:QXPNetWorkTypePost];
    self.isShowErrorHUDView = NO;
}
#pragma   -mark  79-getCommentInfo - (获取评论信息)
- (void)getCommentInfo:(NSString *)collectionID start:(NSString *)start pageNum:(NSString *)pageNum{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSArray *arr_CommentRanking = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"CommentRanking"];
        NSArray *arr_Comment = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"Comment"];
        
        NSString *count = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"Count"];
        
        NSArray *arr_r = [MTLJSONAdapter modelsOfClass:BestCommentOBJ.class fromJSONArray:arr_CommentRanking error:nil];
        NSArray *arr_n = [MTLJSONAdapter modelsOfClass:BestCommentOBJ.class fromJSONArray:arr_Comment error:nil];
        
        return @{@"CommentRanking":arr_r?arr_r:@[],@"Comment":arr_n?arr_n:@[],@"count":count};
    }];
    NSMutableArray *muArr=[NSMutableArray new];
    [muArr addParameter:@"collectionID" parameterValue:collectionID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"start" parameterValue:start parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"pageNum" parameterValue:pageNum parameterType:QXPNetWorkParameterTypeDefault];
    
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=trace&method=getCommentInfo" connectType:QXPNetWorkTypePost];
    self.isShowErrorHUDView = NO;
}

#pragma   -mark  78-getRecordInfo - (获取历史记录信息)
- (void)getRecordInfo:(NSString *)collectionID start:(NSString *)start pageNum:(NSString *)pageNum{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSArray *arr_recordRanking = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"RecordRanking"];
        NSArray *arr_record = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"Record"];
        
        NSString *count = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey:@"Count"];
        
        NSArray *arr_r = [MTLJSONAdapter modelsOfClass:BestRecordOBJ.class fromJSONArray:arr_recordRanking error:nil];
        NSArray *arr_n = [MTLJSONAdapter modelsOfClass:BestRecordOBJ.class fromJSONArray:arr_record error:nil];
        
        return @{@"RecordRanking":arr_r?arr_r:@[],@"Record":arr_n?arr_n:@[],@"count":count};
    }];
    NSMutableArray *muArr = [NSMutableArray new];
    [muArr addParameter:@"collectionID" parameterValue:collectionID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"start" parameterValue:start parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"pageNum" parameterValue:pageNum parameterType:QXPNetWorkParameterTypeDefault];
    
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=trace&method=getRecordInfo" connectType:QXPNetWorkTypePost];
    self.isShowErrorHUDView = NO;
}
#pragma   -mark  82-getProvinceAndCity - (获取城市信息)
- (void)getProvinceAndCity:(NSString *)timeStamp{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSArray *arr_provinceAndCity=[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] ;
        NSArray *arr_r=[MTLJSONAdapter modelsOfClass:getProvinceAndCityOBJ.class fromJSONArray:arr_provinceAndCity error:nil];
        return arr_r;
    }];
    NSMutableArray *muArr=[NSMutableArray new];
    
    [muArr addParameter:@"timeStamp" parameterValue:@"0" parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"countryID" parameterValue:@"CN" parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=common&method=getProvinceAndCity" connectType:QXPNetWorkTypePost];
    //self.isShowErrorHUDView = NO;
}

#pragma   -mark  80-getCategory - (获取类别信息)
- (void)getCategory:(NSString *)timeStamp{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSArray *arr_category = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] ;
        NSArray *arr_r = [MTLJSONAdapter modelsOfClass:getCategoryOBJ.class fromJSONArray:arr_category error:nil];
        return arr_r;
    }];
    NSMutableArray *muArr=[NSMutableArray new];
    [muArr addParameter:@"timeStamp" parameterValue:@"0" parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=trace&method=getCategory" connectType:QXPNetWorkTypePost];
}

#pragma   -mark  66-getMapTraceSystem - (获取平台轨迹)
- (void) getMapTraceSystem:(NSString *)collectionID{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        NSDictionary *dict = [[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"];
        getMapTraceSystemObject *mapTraceSystemOBJ = [MTLJSONAdapter modelOfClass:getMapTraceSystemObject.class fromJSONDictionary:dict error:nil];
        return mapTraceSystemOBJ;
    }];
    NSMutableArray *muArr = [NSMutableArray new];
    [muArr addParameter:@"collectionID" parameterValue:collectionID parameterType:QXPNetWorkParameterTypeDefault];
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=trace&method=getMapTraceSystem" connectType:QXPNetWorkTypePost];
}

#pragma   -mark  40-UserSaveCustomMapTrace - (保存用户跑步轨迹)
- (void) saveCustomMapTrace:(PBSaveMapTrace *)pbSaveMapTrace{
    [self setModelBlock:^id(id object, NSError *__autoreleasing *err) {
        //int ret = [[object objectForKey:@"ret"] intValue];
        return [object objectForKey:@"ret"];
    }];
    NSMutableArray *muArr=[NSMutableArray new];
    [muArr addParameter:@"startTime" parameterValue:pbSaveMapTrace.startTime parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"finishTime" parameterValue:pbSaveMapTrace.finishTime parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"totalTimeSecond" parameterValue:pbSaveMapTrace.totalTimeSecond parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"overallLength" parameterValue:pbSaveMapTrace.overallLength parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"countryID" parameterValue:pbSaveMapTrace.countryID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"areaID" parameterValue:pbSaveMapTrace.areaID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"cityID" parameterValue:pbSaveMapTrace.cityID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"provinceID" parameterValue:pbSaveMapTrace.provinceID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"collections" parameterValue:pbSaveMapTrace.collections parameterType:QXPNetWorkParameterTypeDefault];
    
    [self startLoadInformationWithParameters:muArr URLPath:@"interface&interface=user&method=saveCustomMapTrace" connectType:QXPNetWorkTypePost];
}

#pragma   -mark  84-getGalleryMapTrace - (获取图库图形轨迹信息)
- (void) getGalleryMapTrace:(NSString *)timeStamp categoryID:(NSString *)categoryID cityID:(NSString *)cityID provinceID:(NSString *)provinceID startPage:(NSString *)startPage pageNum:(NSString *)pageNum{
   
    [self setModelBlock:^id(NSDictionary *object, NSError *__autoreleasing *err) {
        
        NSString *Count=[[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey4JsonForKey:@"Count"];
        NSArray *GalleryMapTrace = [[[object objectForKey4JsonForKey:@"result"] objectForKey4JsonForKey:@"data"] objectForKey4JsonForKey:@"GalleryMapTrace"];
        
        NSArray *arr_r = [MTLJSONAdapter modelsOfClass:getGalleryMapTraceOBJ.class fromJSONArray:GalleryMapTrace error:nil];
        
        return @{@"count":Count,@"data":arr_r};


    }];
    
    NSMutableArray *muArr = [NSMutableArray new];
    [muArr addParameter:@"timeStamp" parameterValue:timeStamp parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"categoryID" parameterValue:categoryID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"cityID" parameterValue:cityID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"provinceID" parameterValue:provinceID parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"startPage" parameterValue:startPage parameterType:QXPNetWorkParameterTypeDefault];
    [muArr addParameter:@"pageNum" parameterValue:pageNum parameterType:QXPNetWorkParameterTypeDefault];
    
    [self startLoadInformationWithParameters:muArr URLPath:@"interface=trace&method=getGalleryMapTrace" connectType:QXPNetWorkTypePost];
}












#pragma -mark 辅助方法
- (void)setModelBlock:(id (^)(id object,NSError **err))modelBlock{
        _modelBlock = modelBlock;
}
- (void)startLoadInformationWithParameters:(NSMutableArray *)arr URLPath:(NSString *)string connectType:(QXPNetWorkType)type{
    [self startLoadInformationWithParameters:arr URLPath:string connectType:type userID:nil];
}
- (NSString *)generateSign{
    NSString *randNum = stringWithInt((arc4random()%5001) + 5000);
    //TODO:App第一次启动时需要和服务器同步时间，内置一个时钟，以后请求时的时间戳从这个时钟取，并将时间戳减掉3600秒, 服务端判断时间是否过期  &check=serverTime
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970] - 3600];
    NSString *signText = [NSString stringWithFormat:@"%@@%@*%@", AppSecretKey, randNum, timestamp];
    NSString *md5SignText = [signText md5];
    return [NSString stringWithFormat:@"sign=%@&randNum=%@&timestamp=%@", md5SignText, randNum, timestamp];
}
- (void)startLoadInformationWithParameters:(NSMutableArray *)arr URLPath:(NSString *)string connectType:(QXPNetWorkType)type userID:(NSString *)userID{
    [self addVersinInfo:arr userid:userID];
    self.isShowErrorHUDView = YES;
    NSString *sign = [self generateSign];
    NSString *param = [NSString stringWithFormat:@"%@&%@", sign, string];
    [self startLoadInformationWithParameters:arr URLString:makeURLString(param) connectType:type];
}

- (void)startLoadInformationWithParameters:(NSArray *)arr URLString:(NSString *)string connectType:(QXPNetWorkType)type{
    [self setSerializeType:QXPNetWorkSerializeTypeCustom];
    [self setCacheType:QXPNetWorkCacheTypeSystem];
    
    __block QXPLoadFailedBlock tempBlock = [self.loadFaildBlock copy];
    __weak __typeof(self)wself = self;
    [self setLoadFaildBlock: ^(NSError *error){
        __weak __typeof(wself)sself = wself;
        if (sself.isShowErrorHUDView && error.code == LUOJI_ERROR_CODE) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.domain]];
            });
        }else if(sself.isShowErrorHUDView){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"亲,您的网络好像有问题,请重试!"];
            });
        }
        tempBlock(error);
        tempBlock = nil;
    }];
    [super startLoadInformationWithParameters:arr URLString:string connectType:type];
}

//Albert - 这里处理响应数据
#pragma -mack DataSource
- (id)QXPNetWorkManager:(QXPNetWorkManager *)manager serializeWithData:(NSData *)data error:(NSError **)error{
    NSString *tempStr2 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!tempStr2) {
        *error = [NSError errorWithDomain:@"ERROR" code:LUOJI_ERROR_CODE userInfo:nil];
        return nil;
    }
    NSString *tempStr= [CommonFn decryptDES:tempStr2];
    tempStr2 = nil;
    if (!tempStr) {
        *error = [NSError errorWithDomain:@"ERROR" code:LUOJI_ERROR_CODE userInfo:nil];
        return nil;
    }
    
    NSDictionary *tempObject = [NSJSONSerialization JSONObjectWithData:[[tempStr removeSpecialCharacters] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:error];
    
    tempStr = nil;
    if (tempObject && [tempObject isKindOfClass:[NSDictionary class]]) {
        if ([[tempObject objectForKey4JsonForKey:@"ret"] intValue] == 0) {
            if (self.modelBlock) {
                id obj = self.modelBlock(tempObject,error);
                if (obj) {
                    return obj;
                }else{
                    *error = [NSError errorWithDomain:@"封装错误" code:LUOJI_ERROR_CODE userInfo:nil];
                }
            }else{
                return tempObject;
            }
        }else{
            __block NSString *tempStr = [[tempObject objectForKey:@"result"] objectForKey:@"errorMsg"];
            *error = [NSError errorWithDomain:tempStr?tempStr:@"ERROR" code:LUOJI_ERROR_CODE userInfo:nil];
            tempObject = nil;
        }
    }else{
        *error = [NSError errorWithDomain:@"解析错误" code:LUOJI_ERROR_CODE userInfo:nil];
        tempObject = nil;
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //
        //        });
    }
    return nil;
}
- (void)addVersinInfo:(NSMutableArray *)dict{
    [self addVersinInfo:dict userid:nil];
}
- (void)addVersinInfo:(NSMutableArray *)dict userid:(NSString *)userid{
    //[dict addParameter:@"Model" parameterValue:@"IOS" parameterType:QXPNetWorkParameterTypeDefault];
    [dict addParameter:@"version" parameterValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] parameterType:QXPNetWorkParameterTypeDefault];
    [dict addParameter:@"machineCode" parameterValue:[OpenUDID value] parameterType:QXPNetWorkParameterTypeDefault];
    [dict addParameter:@"systemVersion" parameterValue:[[UIDevice currentDevice] systemVersion] parameterType:QXPNetWorkParameterTypeDefault];
    [dict addParameter:@"userID" parameterValue:userid ? userid:[PBUser sharedUser].UserID parameterType:QXPNetWorkParameterTypeDefault];
    //TODO:token，需要加密保存到本地，并用公钥私钥存取
    [dict addParameter:@"authonToken" parameterValue:[PBUser sharedUser].AuthonToken parameterType:QXPNetWorkParameterTypeDefault];
    
    //合并参数统一加密
    [dict joinParameters];
}
@end

@implementation NSMutableArray(addParameter)
- (void)addParameter:(NSString *)name   parameterValue:(id)value    parameterType:(QXPNetWorkParameterType)type{
    NSString *tempValue = nil;
    if(type == QXPNetWorkParameterTypeDefault){
        tempValue = value; //[CommonFn encryptDES:(NSString *)value];   //不在单独参数上加密，而是在全部 post 参数上统一加密
    }else{
        tempValue = value;
    }
    
    if (tempValue && name) {
        QXPNetWorkParameter *par = [[QXPNetWorkParameter alloc] init];
        par.parameterName = name;
        par.parameterValue = tempValue;
        if (type)
            par.parameterType = type;
        else
            par.parameterType = QXPNetWorkParameterTypeDefault;
        [self addObject:par];
        par = nil;
    }
}
- (void)addParameter:(NSString *)name   parameterValue:(id)value    fileName:(NSString *)fileName   parameterType:(QXPNetWorkParameterType)type{
    NSString *tempValue = nil;
    if(type == QXPNetWorkParameterTypeDefault){
        tempValue = value; //[CommonFn encryptDES:(NSString *)value];   //不在单独参数上加密，而是在全部 post 参数上统一加密
    }else{
        tempValue = value;
    }
    if (tempValue && name) {
        QXPNetWorkParameter *par = [[QXPNetWorkParameter alloc] init];
        par.parameterName = name;
        par.parameterValue = tempValue;
        par.fileName = fileName;
        
        if (type)
            par.parameterType = type;
        else
            par.parameterType = QXPNetWorkParameterTypeDefault;
        [self addObject:par];
        par = nil;
    }
}
- (void)addParameter:(NSString *)name   parameterValue:(id)value  fileName:(NSString *)fileName   contentType:(NSString *)contentType    parameterType:(QXPNetWorkParameterType)type{
    NSString *tempValue = nil;
    if(type == QXPNetWorkParameterTypeDefault){
        tempValue = value; //[CommonFn encryptDES:(NSString *)value];   //不在单独参数上加密，而是在全部 post 参数上统一加密
    }else{
        tempValue = value;
    }
    
    if (tempValue && name) {
        QXPNetWorkParameter *par = [[QXPNetWorkParameter alloc] init];
        par.parameterName = name;
        par.parameterValue = tempValue;
        par.fileName = fileName;
        par.fileContentType = contentType;
        
        if (type)
            par.parameterType = type;
        else
            par.parameterType = QXPNetWorkParameterTypeDefault;
        [self addObject:par];
        par =nil;
    }
}
//合并参数统一加密
- (void)joinParameters{
    NSMutableString *value = [[NSMutableString alloc] init];
    NSString *flag = @"";
    for (int i=0; i<[self count]; i++) {
        if(i>0) flag = @"&";
        QXPNetWorkParameter *parameter = [self objectAtIndex:i];
        [value appendFormat:@"%@%@=%@", flag, parameter.parameterName, parameter.parameterValue];
    }
    [self removeAllObjects];
    QXPNetWorkParameter *encryptData = [[QXPNetWorkParameter alloc] init];
    encryptData.parameterName = @"encryptData";
    encryptData.parameterValue = [CommonFn encryptDES: value];
    encryptData.parameterType = QXPNetWorkParameterTypeDefault;
    [self addObject:encryptData];
    encryptData = nil;
}
@end