#import <UIKit/UIKit.h>

@interface XianLuPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QXPImageView *QimgV_image;
@property (weak, nonatomic) IBOutlet UIButton *btn_count;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;

- (IBAction)btn_zan_click:(UIButton *)sender;
@end
