#import "BaseViewController.h"

@interface PhotoMainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btn_leibie;
@property (weak, nonatomic) IBOutlet UIButton *btn_city;

- (IBAction)btn_city_click:(UIButton *)sender;
- (IBAction)btn_leibie_click:(UIButton *)sender;

@end
