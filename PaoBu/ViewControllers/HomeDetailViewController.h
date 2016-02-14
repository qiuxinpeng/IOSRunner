#import "BaseViewController.h"
#import "XianLuMainView.h"
#import "ZhouBianMainView.h"
#import "PingLunMainView.h"
#import "JiLuMainView.h"
@interface chooseBtn:UIButton
@property(nonatomic, assign)BOOL choose;
@end
@interface HomeDetailViewController : BaseViewController

@property (strong, nonatomic)getRecommendTraceInfoOBJ *OBJ;
@property (weak, nonatomic) IBOutlet chooseBtn *btn_1;
@property (weak, nonatomic) IBOutlet chooseBtn *btn_2;
@property (weak, nonatomic) IBOutlet chooseBtn *btn3;
@property (weak, nonatomic) IBOutlet chooseBtn *btn4;

@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UIButton *btn_go;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;

@property (weak, nonatomic) IBOutlet XianLuMainView *V_xianlu;
@property (weak, nonatomic) IBOutlet ZhouBianMainView *V_zhoubian;
@property (weak, nonatomic) IBOutlet PingLunMainView *V_pinglun;
@property (weak, nonatomic) IBOutlet JiLuMainView *V_JiLu;


- (IBAction)btn_go_click:(UIButton *)sender;
- (IBAction)choose_click:(chooseBtn *)sender;

@end
