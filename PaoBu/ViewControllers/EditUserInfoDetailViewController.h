#import "BaseViewController.h"

@interface EditUserInfoDetailViewController : BaseViewController
@property(nonatomic, assign)UserEditType type;
@property (weak, nonatomic) IBOutlet UITextView *textV_text;

@end
