#import "PhotoMainViewController.h"
#import "ActionSheetPicker.h"
#import "QXPActionSheetPickerDelegate.h"

@interface PhotoMainViewController ()
@property(nonatomic,strong)NSArray *arr_citys;
@property(nonatomic,strong)NSArray *arr_category;

@property(nonatomic,strong)getProvinceAndCityOBJ *ProvinceOBJ;
@property(nonatomic,strong)CitiesOBJ *cityOBJ;

@property(nonatomic,strong)getCategoryOBJ *categoryOBJ;
@property(nonatomic,strong)SubCategoryOBJ *subOBJ;

@end

@implementation PhotoMainViewController

- (NSString *)tabImageName{ return @"gallery.png"; }
- (NSString *)tabTitle{ return @"图库"; }
- (NSString *)activeTabImageName{ return @"gallery1.png"; }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar=YES;
    [self getData];
}
- (void)getData{
    if (!self.arr_citys) {
        [[BBInterFace interfaceWithFinshBlock:^(NSArray *responseObje) {
            self.arr_citys=responseObje;
        } faildBlock:^(NSError *err) {
            
        } HUDBackgroundView:self.view tag:nil] getProvinceAndCity:nil];
    }
    if (!self.arr_category) {
        [[BBInterFace interfaceWithFinshBlock:^(NSArray *responseObje) {
            self.arr_category=responseObje;
        } faildBlock:^(NSError *err) {
            
        } HUDBackgroundView:self.view tag:nil] getCategory:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_city_click:(UIButton *)sender {
    if (!self.arr_citys) {
        [self getData];
        [UIAlertView say:@"正在获取数据!"];
        return;
    }
    
    QXPActionSheetPickerDelegate *qxpDelegate=[QXPActionSheetPickerDelegate delegateWihtBlock:^NSInteger{
        return 2;
    } numberOfRowsInComponent:^NSInteger(NSInteger component, NSInteger row) {
        if (component==0) {
            return self.arr_citys.count;
        }else {
            getProvinceAndCityOBJ *obj=self.arr_citys[row];
            return obj.Cities.count;
        }
    } titleForRow:^NSString *(NSInteger row,NSInteger component,NSInteger choiceComponent) {
        if (component==0) {
            getProvinceAndCityOBJ *cityobj=self.arr_citys[row];
            return cityobj.Province;
        }else{
            getProvinceAndCityOBJ *obj=self.arr_citys[choiceComponent];
            CitiesOBJ *cityobj=obj.Cities[row];
            NSLog(@"%@",cityobj);
            return cityobj.City;
        }
        return @"1111";
    }];
    //滑动时候事件
    [qxpDelegate setDidSelectRowBlock:^(UIPickerView *view, NSInteger row, NSInteger component) {
        if (component==0) {
            [view reloadComponent:1];
        }else if (component == 1){
           
        }
    }];
    //确定选择时间;
    [qxpDelegate setActionSheetPickerDidSucceedBlock:^(AbstractActionSheetPicker *piker, NSInteger oneRow, NSInteger twoRow) {
        
        self.ProvinceOBJ=self.arr_citys[oneRow];
        self.cityOBJ=self.ProvinceOBJ.Cities[twoRow];
        [self.btn_city setTitle:self.cityOBJ.City forState:UIControlStateNormal];
    }];
    NSString *titleStr = @"选择地区";
    ActionSheetCustomPicker *customPicker=[[ActionSheetCustomPicker alloc]initWithTitle:titleStr delegate:qxpDelegate showCancelButton:YES origin:sender];
    [customPicker showActionSheetPicker];
}

- (IBAction)btn_leibie_click:(UIButton *)sender {
    QXPActionSheetPickerDelegate *qxpDelegate=[QXPActionSheetPickerDelegate delegateWihtBlock:^NSInteger{
        return 2;
    } numberOfRowsInComponent:^NSInteger(NSInteger component, NSInteger row) {
        if (component==0) {
            return self.arr_category.count;
        }else {
            getCategoryOBJ *obj=self.arr_category[row];
            return obj.SubCategory.count;
        }
    } titleForRow:^NSString *(NSInteger row,NSInteger component,NSInteger choiceComponent) {
        if (component==0) {
            getCategoryOBJ *cityobj=self.arr_category[row];
            return cityobj.CategoryName;
        }else{
            getCategoryOBJ *obj=self.arr_category[choiceComponent];
            SubCategoryOBJ *cityobj=obj.SubCategory[row];
            NSLog(@"%@",cityobj);
            return cityobj.CategoryName;
        }
        return @"1111";
    }];
    //滑动时候事件
    [qxpDelegate setDidSelectRowBlock:^(UIPickerView *view, NSInteger row, NSInteger component) {
        if (component==0) {
            [view reloadComponent:1];
        }else if (component == 1){
            
        }
    }];
    //确定选择时间;
    [qxpDelegate setActionSheetPickerDidSucceedBlock:^(AbstractActionSheetPicker *piker, NSInteger oneRow, NSInteger twoRow) {
        self.categoryOBJ=self.arr_category[oneRow];
        self.subOBJ=self.categoryOBJ.SubCategory[twoRow];
        [self.btn_leibie setTitle:self.subOBJ.CategoryName forState:UIControlStateNormal];
    }];
    NSString *titleStr = @"选择类别";
    ActionSheetCustomPicker *customPicker=[[ActionSheetCustomPicker alloc]initWithTitle:titleStr delegate:qxpDelegate showCancelButton:YES origin:sender];
    [customPicker showActionSheetPicker];
}
@end
