//
//  YPShereToll.m
//  YouPlayNew
//
//  Created by Mr.Qiu on 14/11/23.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import "YPShereToll.h"
#import "UMSocialSnsService.h"
#import "SDWebImageManager.h"
#import "RMTSNSInfo.h"

@implementation YPShereToll

//录音分享
+ (void)ShareMP3:(NSString *)path mp3name:(NSString *)name
        shareURL:(NSString *)shareURL shareTitle:(NSString *)shareTitle
       shareText:(NSString *)shareText shareImage:(UIImage *)shareImage sheetController:(UIViewController *)VC{
    
    
    
    
    if ([CommonFn IsEnable3G]) {
        
        
        [UIAlertView ask:@"您现在未使用WIFI" EventBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex==1) {
                
                /*
                [[YPInterFace interfaceWithFinshBlock:^(id responseObje) {
                    
                    NSString *shareURL=responseObje[@"ShareURL"];
                    NSString *shareText=name;
                    
                    [MainConfig changeShereURL:shareURL];
                    
                    //如果得到分享完成回调，需要设置delegate为self
                    [UMSocialSnsService presentSnsIconSheetView:VC appKey:UMENG_APPKEY shareText:shareText shareImage:shareImage shareToSnsNames:UMENG_SnsNames delegate:nil];
                    
                } faildBlock:^(NSError *err) {
                    
                } interFaceHUD:QXPLoadHUDStyleDefault HUDString:@"数据上传中,请耐心等待" HUDBackgroundView:VC.view tag:VC.tagWithInterFace] ShareMP3:path mp3name:name];
                 */
            }
            
        } message:@"分享可能需要数分钟或失败" cancelTitle:nil otherButtonTitles:@[@"取消",@"继续分享"]];
        
        
    }else if ([CommonFn IsEnableWIFI]){
        
        /*
        [[YPInterFace interfaceWithFinshBlock:^(id responseObje) {
            
            NSString *shareURL=responseObje[@"ShareURL"];
            NSString *shareText=name;
            
            [MainConfig changeShereURL:shareURL];
            
            //如果得到分享完成回调，需要设置delegate为self
            [UMSocialSnsService presentSnsIconSheetView:VC appKey:UMENG_APPKEY shareText:shareText shareImage:shareImage shareToSnsNames:UMENG_SnsNames delegate:nil];
            
        } faildBlock:^(NSError *err) {
            
        } interFaceHUD:QXPLoadHUDStyleDefault HUDString:@"数据上传中,请耐心等待" HUDBackgroundView:VC.view tag:VC.tagWithInterFace] ShareMP3:path mp3name:name];
        */
    }
    
    

    
    

}
//曲谱分享
+ (void)ShareTab:(NSString *)shareURL shareTitle:(NSString *)shareTitle
       shareText:(NSString *)shareText shareImage:(UIImage *)shareImage sheetController:(UIViewController *)VC
           tabid:(NSString *)tabid userid:(NSString *)userid{
    
    
    /*
    [[YPInterFace interfaceWithFinshBlock:^(id responseObje) {
        NSString *shareURL=responseObje[@"ShareURL"];
        
        [MainConfig changeShereURL:shareURL];
        //如果得到分享完成回调，需要设置delegate为self
        [UMSocialSnsService presentSnsIconSheetView:VC appKey:UMENG_APPKEY shareText:shareText shareImage:shareImage shareToSnsNames:UMENG_SnsNames delegate:nil];
        
    } faildBlock:^(NSError *err) {
        
    } HUDBackgroundView:VC.view tag:VC.tagWithInterFace] IFShareTab:tabid userid:userid];
    
    */
    
}
// 详情分享
+ (void)ShareTheme:(NSString *)shareURL shareTitle:(NSString *)shareTitle
       shareText:(NSString *)shareText shareImage:(UIImage *)shareImage sheetController:(UIViewController *)VC
           themeID:(NSString *)themeID userid:(NSString *)userid  {
    
  
    /*
    [[YPInterFace interfaceWithFinshBlock:^(id responseObje) {
        NSString *shareURL=responseObje[@"ShareURL"];
        
        QXPDispatch_after(0.1, ^{
            [MainConfig changeShereURL:shareURL];
            
            //如果得到分享完成回调，需要设置delegate为self
            [UMSocialSnsService presentSnsIconSheetView:VC appKey:UMENG_APPKEY shareText:shareText shareImage:shareImage shareToSnsNames:UMENG_SnsNames delegate:nil];
        });
        
        
        
    } faildBlock:^(NSError *err) {
        
    } interFaceHUD:QXPLoadHUDStyleDefault HUDString:@"数据上传中,请耐心等待" HUDBackgroundView:VC.view tag:VC.tagWithInterFace] IFShareTheme:themeID userid:userid];
     */
}


@end
