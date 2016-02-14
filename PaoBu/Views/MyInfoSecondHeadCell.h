#import <UIKit/UIKit.h>

@interface MyInfoSecondHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgV_head;
@property (weak, nonatomic) IBOutlet UILabel *Lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_nianling_1;
@property (weak, nonatomic) IBOutlet UILabel *lab_xingqu_2;
@property (weak, nonatomic) IBOutlet UILabel *lab_xingqu_3;
@property (weak, nonatomic) IBOutlet UILabel *lab_xingqu_4;
@property (weak, nonatomic) IBOutlet UILabel *lab_pengyou;
@property (weak, nonatomic) IBOutlet UILabel *lab_mapcount;
@property (weak, nonatomic) IBOutlet UILabel *lab_qianming;
- (void)reloadWithInfo:(PBUser *)user;
@end
