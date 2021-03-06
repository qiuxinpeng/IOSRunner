#import "PhotoMainViewController.h"
#import "ActionSheetPicker.h"
#import "QXPActionSheetPickerDelegate.h"
#import "PhotoCollectionViewCell.h"
#import "HomeDetailViewController.h"
@interface PhotoMainViewController ()
@property(nonatomic,strong)NSArray *arr_citys;
@property(nonatomic,strong)NSArray *arr_category;
@property(nonatomic,strong)NSArray *arr_galleryMapTrace;

@property(nonatomic,strong)getProvinceAndCityOBJ *ProvinceOBJ;
@property(nonatomic,strong)CitiesOBJ *cityOBJ;

@property(nonatomic,strong)getCategoryOBJ *categoryOBJ;
@property(nonatomic,strong)SubCategoryOBJ *subOBJ;

@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)int allCount;



@end

@implementation PhotoMainViewController

- (NSString *)tabImageName{ return @"gallery.png"; }
- (NSString *)tabTitle{ return @"图库"; }
- (NSString *)activeTabImageName{ return @"gallery1.png"; }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTabBar=YES;
    [self.collectV_list registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    
    self.page=1;
    self.pageSize=100;
    self.allCount=0;
    
    [self getcithAndLeibie];
    [self getData];

}
- (void)getcithAndLeibie{

    if (!self.arr_citys) {
        [[BBInterface interfaceWithFinshBlock:^(NSArray *responseObje) {
            self.arr_citys = responseObje;
        } faildBlock:^(NSError *err) {
            
        } HUDBackgroundView:self.view tag:nil] getProvinceAndCity:nil];
    }
    if (!self.arr_category) {
        [[BBInterface interfaceWithFinshBlock:^(NSArray *responseObje) {
            self.arr_category = responseObje;
        } faildBlock:^(NSError *err) {
            
        } HUDBackgroundView:self.view tag:nil] getCategory:nil];
    }
}
- (void)getData{
   
    if (!self.arr_galleryMapTrace) {}
        NSString *timeStamp = @"0";
    NSString *categoryID =self.subOBJ.ID;
    //@"-1";
        NSString *cityID =self.cityOBJ.CityID;
        //@"-1";
        NSString *provinceID =@"-1";
        //@"-1";
       // NSString *startPage = @"1";
        //NSString *pageNum = @"10";
        
        [[BBInterface interfaceWithFinshBlock:^(NSDictionary *responseObje) {
            self.arr_galleryMapTrace = [responseObje objectForKey:@"data"];
            self.allCount=[[responseObje objectForKey:@"count"] intValue];
            
            [self reloadView];

        } faildBlock:^(NSError *err) {
            self.arr_galleryMapTrace=nil;
            [self reloadView];

        } HUDBackgroundView:self.view tag:nil] getGalleryMapTrace:timeStamp categoryID:categoryID?categoryID:@"-1" cityID:cityID?cityID:@"-1" provinceID:provinceID?provinceID:@"-1" startPage:stringWithInt(self.page) pageNum:stringWithInt(self.pageSize)];
    
}
- (void)reloadView{

    [self.collectV_list reloadData];
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
        
        self.lab_city.text=self.cityOBJ.City;
        //刷新数据
        [self getData];
        
        //[self.btn_city setTitle:self.cityOBJ.City forState:UIControlStateNormal];
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
        //刷新数据
        [self getData];
    }];
    NSString *titleStr = @"选择类别";
    ActionSheetCustomPicker *customPicker=[[ActionSheetCustomPicker alloc]initWithTitle:titleStr delegate:qxpDelegate showCancelButton:YES origin:sender];
    [customPicker showActionSheetPicker];
}

- (IBAction)btn_near_click:(UIButton *)sender {
}
#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr_galleryMapTrace.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PhotoCollectionViewCell";
    
    PhotoCollectionViewCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    getGalleryMapTraceOBJ *OBJ=[self.arr_galleryMapTrace objectAtIndex:indexPath.row];
    
    [cell.imgV_back sd_setImageWithURL:[NSURL URLWithString:OBJ.ThumbnailDetailUrl]];
    
    cell.lab_juli.text=OBJ.OverallLength;
    cell.lab_liebie.text=OBJ.Name;
    cell.lab_zan.text=OBJ.LikeCount;

//    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
   // cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(145, 100);
}
//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 5, 5);
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    getGalleryMapTraceOBJ *tempOBJ=[self.arr_galleryMapTrace objectAtIndex:indexPath.row];

    
    getRecommendTraceInfoOBJ *OBJ = [getRecommendTraceInfoOBJ new];
    OBJ.Name=tempOBJ.Name;
    OBJ.ID=tempOBJ.ID;
    
    HomeDetailViewController *VC = [[HomeDetailViewController alloc]initWithNibName:@"HomeDetailViewController" bundle:nil];
    VC.OBJ = OBJ;
    [self pushVC:VC animated:YES];
    
}


@end
