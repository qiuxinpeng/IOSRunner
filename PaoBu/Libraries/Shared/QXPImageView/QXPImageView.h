#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#if __has_feature(objc_arc)
#define QXP_IMAGEVIEW_STRONG strong
#define QXP_IMAGEVIEW_WEAK weak
#else
#define QXP_IMAGEVIEW_STRONG retain
#define QXP_IMAGEVIEW_WEAK assign
#endif

typedef NS_ENUM(NSInteger, QXPImageViewQualityTpye) {
    QXPImageViewQualityLow =15,       //较低质量
    QXPImageViewQualityNormal,    //默认质量
    QXPImageViewQualityModerate,  //中等质量
};
typedef NS_ENUM(NSInteger, QXPImageViewProportionState) {
    QXPImageViewProportionWidth =5,       //根据宽度等比绘制,图片不会变形
    QXPImageViewProportionNormal,         //默认绘制
    QXPImageViewProportionHeigh,          //根据高度等比绘制
    QXPImageViewProportionAuto          //根据高度等比绘制
};
typedef NS_ENUM(NSInteger, QXPImageViewStyle) {
    QXPImageViewStyleNone =1,       //默认imageView
    QXPImageViewStyleHighlighted =2        //Highlighted
};

@interface QXPImageView : UIControl;
@property(nonatomic, strong) UIImage  *image;
@property(nonatomic, strong) UIImage  *placeholder;
@property(nonatomic) QXPImageViewQualityTpye     qualityTpye;
@property(nonatomic) QXPImageViewProportionState proportionState;
@property(nonatomic) QXPImageViewStyle           style;

@property(nonatomic, assign) BOOL  showLoadView;

//点击事件
@property(nonatomic, copy)void (^QXPClickBlock)(QXPImageView *view);
//图片下载完成事件
@property(nonatomic, copy)void (^QXPFinshBlock)(QXPImageView *view);
//图片下载失败事件
@property(nonatomic, copy)void (^QXPFaildBlock)(QXPImageView *view);

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image style:(QXPImageViewStyle)style;
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;
- (id)initWithFrame:(CGRect)frame style:(QXPImageViewStyle)style;
- (void)setImageURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url  options:(SDWebImageOptions)options;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;


- (void)setBackgroundViewColor:(UIColor *)color;
/**
 * Cancel the current download
 */
- (void)cancelCurrentImageLoad;

@end
