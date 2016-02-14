#import "HomeDetailViewController.h"
@interface chooseBtn ()
@property(nonatomic, strong)UIView *V_line;

@end
@implementation chooseBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self _init];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self _init];
}
-(void)_init{
    self.V_line = [[UIView alloc] initWithFrame:CGRectMake(10, self.ui_height-5, self.ui_width-20, 3)];
    self.V_line.backgroundColor = self.backgroundColor;
    [self addSubview:self.V_line];
}
-(void)setChoose:(BOOL)choose{
    _choose=choose;
    if (_choose) {
        [self setTitleColor:[UIColor colorWithHexString:@"00c4ff"] forState:UIControlStateNormal];
        self.V_line.backgroundColor=[UIColor colorWithHexString:@"00c4ff"];
    }else{
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.V_line.backgroundColor=self.backgroundColor;
    }
}
@end

@interface HomeDetailViewController ()
@property(nonatomic,strong)chooseBtn *chooseTemp;
@property(nonatomic,strong)getTraceLineInfoOBJ *traceLineInfoOBJ;
@property(nonatomic, strong)UIView *tempView;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lab_name.text = self.OBJ.Name;
    [self choose_click:self.btn_1];
    self.title = @"线路信息";

    [[BBInterFace interfaceWithFinshBlock:^(getTraceLineInfoOBJ *responseObje) {
        self.traceLineInfoOBJ=responseObje;
        [self reloadData];
    } faildBlock:^(NSError *err) {
        
    } HUDBackgroundView:self.view tag:self.tagWithInterFace] getTraceLineInfo:self.OBJ.ID];

    self.V_zhoubian.OBJ = self.OBJ;
    self.V_pinglun.OBJ = self.OBJ;
    self.V_JiLu.OBJ = self.OBJ;
}
- (void)reloadData{
    [self.V_xianlu reloadWithOBJ:self.traceLineInfoOBJ];
}
- (IBAction)btn_go_click:(UIButton *)sender {
}
- (IBAction)choose_click:(chooseBtn *)sender {
    if (self.chooseTemp==sender) {
        return;
    }
    self.chooseTemp.choose=NO;
    sender.choose=YES;
    self.chooseTemp=sender;
    
    [self showViewWihtIndex:sender.tag];
}
- (void)showViewWihtIndex:(NSInteger )index{
    self.tempView.hidden=YES;
    if (index==0) {
        self.tempView=self.V_xianlu;
        self.tempView.hidden=NO;
    }else if (index==1){
        self.tempView=self.V_zhoubian;
        self.tempView.hidden=NO;
        [self.V_zhoubian willShow];
    }else if (index==2){
        self.tempView=self.V_JiLu;
        self.tempView.hidden=NO;
        [self.V_JiLu willShow];
    }else if (index==3){
        self.tempView=self.V_pinglun;
        self.tempView.hidden=NO;
        [self.V_pinglun willShow];
    }
}

@end
