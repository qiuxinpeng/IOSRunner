#import <UIKit/UIKit.h>

@interface HomeMainView : UIView
@property (weak, nonatomic) IBOutlet QXPImageView *QimgV_image;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_show;

@end

@interface HomeMainSmallView : UIView
@property (strong, nonatomic) QXPImageView *QimgV_image;
@property (assign, nonatomic) NSInteger index;
- (void)setChoose:(BOOL)choose;
@end