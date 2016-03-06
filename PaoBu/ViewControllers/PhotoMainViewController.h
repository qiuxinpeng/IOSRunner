#import "BaseViewController.h"

@interface PhotoMainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btn_leibie;
@property (weak, nonatomic) IBOutlet UIButton *btn_city;
@property (weak, nonatomic) IBOutlet UIButton *btn_near;
@property (weak, nonatomic) IBOutlet UILabel *lab_city;
@property (weak, nonatomic) IBOutlet UICollectionView *collectV_list;

- (IBAction)btn_city_click:(UIButton *)sender;
- (IBAction)btn_leibie_click:(UIButton *)sender;
- (IBAction)btn_near_click:(UIButton *)sender;

@end
