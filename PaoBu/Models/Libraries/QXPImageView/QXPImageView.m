//
//  QXPImageView.m
//  text
//
//  Created by mac on 13-1-7.
//
//

#import "QXPImageView.h"
#import "UIImage+Resize.h"
#import "objc/runtime.h"


static char operationKeyQXP;


@interface QXPImageView()<SDWebImageManagerDelegate>{

    CGRect  tempRect;
}

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *backgroundView;
@property (strong, nonatomic) UIActivityIndicatorView *activWaitNetWork;

@end

@implementation QXPImageView

- (void)awakeFromNib{

    [super awakeFromNib];
    
    _proportionState=QXPImageViewProportionNormal;
    _qualityTpye=QXPImageViewQualityNormal;
    self.imageView=[[UIImageView alloc] initWithFrame:self.bounds];
    self.style=QXPImageViewStyleNone;
    self.clipsToBounds=YES;
}

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image style:(QXPImageViewStyle)style{

    if ((self=[super initWithFrame:frame])) {
        self.image=image;
        tempRect=frame;
        _proportionState=QXPImageViewProportionNormal;
        _qualityTpye=QXPImageViewQualityNormal;
        self.imageView=[[UIImageView alloc] initWithFrame:self.bounds];
        self.style=style;
        self.clipsToBounds=YES;        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame style:(QXPImageViewStyle)style{

    return [self initWithFrame:frame image:nil style:style];
}
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image{

     return [self initWithFrame:frame image:image style:QXPImageViewStyleNone];
}
- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame image:nil style:QXPImageViewStyleNone];
}
- (id)init {
   return [self initWithFrame:CGRectZero image:nil style:QXPImageViewStyleNone];
}
- (id)initWithImage:(UIImage *)image {
    return [self initWithFrame:CGRectZero image:image style:QXPImageViewStyleNone];
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}
- (void)setStyle:(QXPImageViewStyle)style{
    _style=style;
    
    if (_style==QXPImageViewStyleNone) {

        self.selected=NO;
        self.userInteractionEnabled=NO;
    }else if (_style==QXPImageViewStyleHighlighted){
        self.selected=YES;
        self.userInteractionEnabled=YES;
        if (!self.backgroundView) {
            _backgroundView=[[UIView alloc]initWithFrame:self.imageView.bounds];
            _backgroundView.autoresizesSubviews = YES;
            _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _backgroundView.backgroundColor=[UIColor blackColor];
            _backgroundView.alpha=0.5;
            _backgroundView.hidden=YES;
            [self.imageView addSubview:_backgroundView];
        }
    }
}
- (void)setImageView:(UIImageView *)imageView{

    [_imageView removeFromSuperview];
    _imageView=imageView;
    [self addSubview:_imageView];
}
- (void)setPlaceholder:(UIImage *)placeholder{
    
#if !__has_feature(objc_arc)
    [_placeholder release];
    _placeholder=[placeholder retain];
#else
    _placeholder=placeholder;
#endif
//    if (!self.image && _style==QXPImageViewStyleNone) {
//        [(UIImageView *)self.imageView setImage:_placeholder];
//    }else if (!self.image && _style==QXPImageViewStyleHighlighted){
//        [(UIButton *)self.imageView setImage:_placeholder forState:UIControlStateNormal];
//    }
    self.image=_placeholder;
}
- (void)setImage:(UIImage *)image {

#if !__has_feature(objc_arc)
    [_image release];
    _image=[image retain];
#else
    _image=image;
#endif
    tempRect=[self rectWithProportions];
    self.imageView.frame=tempRect;
    // [self setNeedsDisplay];
//    if (_image && _style==QXPImageViewStyleNone) {
//        [(UIImageView *)self.imageView setImage:_image];
//    }else if (_image && _style==QXPImageViewStyleHighlighted){
//        [(UIButton *)self.imageView setBackgroundImage:_image forState:UIControlStateNormal];
//        [(UIButton *)self.imageView setShowsTouchWhenHighlighted:YES ];
//        [(UIButton *)self.imageView setAdjustsImageWhenHighlighted:YES];
//    }
    
    [self.imageView setImage:_image];
}
- (void)setBackgroundViewColor:(UIColor *)color{

    [_backgroundView setBackgroundColor:color];
}
- (UIActivityIndicatorView *)activWaitNetWork{


    if (!_activWaitNetWork) {
        
        _activWaitNetWork = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];//指定进度轮的大小
        
        [_activWaitNetWork setCenter:CGPointMake(self.ui_width/2, self.ui_height/2)];//指定进度轮中心点
        
        [_activWaitNetWork setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        
        [self addSubview:_activWaitNetWork];
    }
    
    return _activWaitNetWork;
    
}
- (void)setShowLoadView:(BOOL)showLoadView{

    _showLoadView=showLoadView;

    

}
- (void)setImageURL:(NSURL *)url{
   
    [self setImageWithURL:url placeholderImage:_placeholder options:0 success:nil failure:nil];
}
- (void)setImageWithURL:(NSURL *)url  options:(SDWebImageOptions)options{

     [self setImageWithURL:url placeholderImage:_placeholder options:options success:nil failure:nil];
}
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
{
    /**/

    [self cancelCurrentImageLoad];
    
    if (self.showLoadView){
        [self.activWaitNetWork startAnimating];
    }

    self.image = placeholder;
    if (url)
    {
        __weak QXPImageView *wself = self;
        
        id<SDWebImageOperation> operation =[SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^
                                    {
                                        if (!wself) return;
                                        if (image)
                                        {
                                            [wself setQualityImage:image];
                                            [wself setNeedsLayout];
                                        }
                                        if (self.QXPFinshBlock && finished && !error)
                                        {
                                            [wself setQualityImage:image];
                                            if (self.QXPFinshBlock) {self.QXPFinshBlock(self);}
                                            
                                            
                                        }
                                        else if (self.QXPFaildBlock && finished)
                                        {
                                            [wself setQualityImage:placeholder];
                                            if (self.QXPFaildBlock) {self.QXPFaildBlock(self);}
                                            
                                        }
                                        
                                        if (self.showLoadView && finished){
                                            
                                            [self.activWaitNetWork stopAnimating];
                                            
                                        }
                                        
                                    });
        }];
        
        objc_setAssociatedObject(self, &operationKeyQXP, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    
     
    
}
- (CGRect)rectWithProportions{

    if (_proportionState==QXPImageViewProportionNormal) {
        
        return self.bounds;
        
    }else if (_proportionState==QXPImageViewProportionWidth){
        
        if (!self.image)return self.bounds;
        else{
            CGFloat weidth=self.bounds.size.width;
            CGFloat height=0;
            height=CGRectGetWidth(self.bounds)/self.image.size.width*self.image.size.height;
            return CGRectMake(0, (CGRectGetHeight(self.bounds)-height)/2, weidth, height);
        }
    }else if (_proportionState==QXPImageViewProportionHeigh){
        
        if (!self.image)return self.bounds;
        else{
            CGFloat height=self.bounds.size.height;
            CGFloat weidth=0;
            weidth=CGRectGetHeight(self.bounds)/self.image.size.height*self.image.size.width;
            return CGRectMake((CGRectGetWidth(self.bounds)-weidth)/2, 0, weidth, height);
        }
    }else if (_proportionState==QXPImageViewProportionAuto){
        
        if (!self.image)return self.bounds;
        else{
            
            if (self.image.size.height>self.image.size.width) {
                CGFloat weidth=self.bounds.size.width;
                CGFloat height=0;
                height=CGRectGetWidth(self.bounds)/self.image.size.width*self.image.size.height;
                return CGRectMake(0, (CGRectGetHeight(self.bounds)-height)/2, weidth, height);
            }else{
                CGFloat height=self.bounds.size.height;
                CGFloat weidth=0;
                weidth=CGRectGetHeight(self.bounds)/self.image.size.height*self.image.size.width;
                return CGRectMake((CGRectGetWidth(self.bounds)-weidth)/2, 0, weidth, height);
                
            }
        }
    }

    return CGRectZero;
}
- (void)setProportionState:(QXPImageViewProportionState)proportionState{
    _proportionState=proportionState;
    tempRect=[self rectWithProportions];
    self.imageView.frame=tempRect;
    // [self setNeedsDisplay];
    self.image=_image;
}
- (void)setQualityTpye:(QXPImageViewQualityTpye)qualityTpye{
    _qualityTpye=qualityTpye;

}
//- (void)setQXPClickBlock:(void (^)(QXPImageView *))QXPClickBlock{
//    _QXPClickBlock=[QXPClickBlock copy];
//}
- (void)cancelCurrentImageLoad{
    // Cancel in progress downloader from queue
    id<SDWebImageOperation> operation = objc_getAssociatedObject(self, &operationKeyQXP);
    if (operation)
    {
        [operation cancel];
        objc_setAssociatedObject(self, &operationKeyQXP, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (void)webImageManager:(SDWebImageManager *)imageManager didProgressWithPartialImage:(UIImage *)image forURL:(NSURL *)url
{
    
    [self setQualityImage:image];
    
}
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    [self setQualityImage:image];
    if (self.QXPFinshBlock) {self.QXPFinshBlock(self);}
}
- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error{

    self.image = _placeholder;
    if (self.QXPFaildBlock) {self.QXPFaildBlock(self);}
}
- (void)btn_didclick:(id)sender{

    if (self.QXPClickBlock) {self.QXPClickBlock(self);}
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [super touchesBegan:touches withEvent:event];
    if((CGRectContainsPoint([self.imageView bounds], [touches.anyObject locationInView:self.imageView]))){
         _backgroundView.hidden=NO;
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    [super touchesMoved:touches withEvent:event];
    if(!(CGRectContainsPoint([self.imageView bounds], [touches.anyObject locationInView:self.imageView]))){
    
        _backgroundView.hidden=YES;
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    if (!_backgroundView.hidden && self.QXPClickBlock) {self.QXPClickBlock(self);}
    _backgroundView.hidden=YES;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesCancelled:touches withEvent:event];
    if (!_backgroundView.hidden && self.QXPClickBlock) {self.QXPClickBlock(self);}
    _backgroundView.hidden=YES;
}
*/
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{

    if((CGRectContainsPoint([self.imageView bounds], [touch locationInView:self.imageView]))){
        _backgroundView.hidden=NO;
    }
    return [super beginTrackingWithTouch:touch withEvent:event];
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(!(CGRectContainsPoint([self.imageView bounds], [touch locationInView:self.imageView]))){
        
        _backgroundView.hidden=YES;
    }
    return [super continueTrackingWithTouch:touch withEvent:event];
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{

    if (!_backgroundView.hidden && self.QXPClickBlock) {self.QXPClickBlock(self);}
    _backgroundView.hidden=YES;
    
    [super endTrackingWithTouch:touch withEvent:event];
    
}
- (void)cancelTrackingWithEvent:(UIEvent *)event{
    _backgroundView.hidden=YES;
    [super cancelTrackingWithEvent:event];
    
}
- (void)setQualityImage:(UIImage *)image{

    if (image.size.width<self.ui_size.width*2 && image.size.height<self.ui_size.width*2) {
        self.image = image;
    }else if (_qualityTpye==QXPImageViewQualityNormal){
        self.image = image;
    }else if (_qualityTpye==QXPImageViewQualityLow){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            CGFloat weidth=self.ui_size.width;
            CGFloat height=weidth/image.size.width*image.size.height;
            UIImage *imged=[self resizeImageWithNewSize:CGSizeMake(weidth, height) image:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image=imged;
            });
        });
        
        
        //weidth/image.size.width*self.image.size.height;
        
        
    }else if (_qualityTpye==QXPImageViewQualityModerate){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            CGFloat weidth=self.ui_size.width*2;
            CGFloat height=weidth/image.size.width*image.size.height;
            UIImage *imged=[self resizeImageWithNewSize:CGSizeMake(weidth, height) image:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image=imged;
            });
        });
    }
}
- (UIImage*)resizeImageWithNewSize:(CGSize)newSize image:(UIImage*)image;
{
	CGFloat newWidth = newSize.width;
	CGFloat newHeight = newSize.height;
    // Resize image if needed.
    float width  = self.ui_size.width;
    float height = self.ui_size.height;
    // fail safe
    if (width == 0 || height == 0)
		return image;
    
    //float scale;
	
    if (width != newWidth || height != newHeight) {
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
        [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
		
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //NSData *jpeg = UIImageJPEGRepresentation(image, 0.8);
        return resized;
    }
    return image;
}
- (void)dealloc{
    
    
    self.QXPClickBlock=nil;
    self.QXPFinshBlock=nil;
    self.QXPFaildBlock=nil;
    [self cancelCurrentImageLoad];
    [_backgroundView removeFromSuperview],_backgroundView=nil;
    
#if !__has_feature(objc_arc)
    [_placeholder release],_placeholder=nil;
    [_image release];_image=nil;
    if (self.imageView) {[_imageView removeFromSuperview],[_imageView release],_imageView=nil;}
    [super dealloc];
#endif
    
}

@end
