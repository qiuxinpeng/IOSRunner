#import <UIKit/UIKit.h>

@interface EditUserInfoTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_detail;
@property(nonatomic, assign)UserEditType type;
@end
