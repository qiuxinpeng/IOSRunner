#import <UIKit/UIKit.h>

@interface XianLuJiaoTongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_Ctime;
@property (weak, nonatomic) IBOutlet UILabel *lab_Ttime;
@property (weak, nonatomic) IBOutlet UILabel *lab_alllong;
@property (weak, nonatomic) IBOutlet UILabel *lab_alltime;
@property (weak, nonatomic) IBOutlet UILabel *lab_peisu;
@property (weak, nonatomic) IBOutlet UIButton *btn_can;
- (void)reloadWithOBJ:(BestRecordOBJ *)OBJ;
@end
