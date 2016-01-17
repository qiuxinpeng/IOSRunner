//
//  QXPPhotoBrowser.m
//  PhotoBrowserDemo
//
//  Created by Mr.Qiu on 15/4/7.
//
//

#import "QXPPhotoBrowser.h"
#import "ActionSheetStringPicker.h"
#import <objc/runtime.h>
@interface QXPPhotoBrowser ()<MWPhotoBrowserDelegate>
@property(nonatomic, strong)NSArray *arr_photos;
@property(nonatomic, strong)NSArray *arr_jubao;

@end

@implementation QXPPhotoBrowser

- (void)viewDidLoad {

    
    self.delegate=self;
    
    self.displayActionButton = YES;
    self.displayNavArrows = YES;
    self.displaySelectionButtons = NO;
    self.alwaysShowControls = NO;
    self.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    self.wantsFullScreenLayout = YES;
#endif
    self.enableGrid = NO;
    self.startOnGrid = NO;
    self.enableSwipeToDismiss = YES;
    [self setCurrentPhotoIndex:0];
    
    
    [super viewDidLoad];
    
    

    self.arr_jubao=@[@"违法违纪",
                     @"淫秽色情",
                     @"恐怖血腥",
                     @"破坏和谐"
                     ];
    


    [self reloadData];

}
- (void)performLayout{
    [super performLayout];
    
    /**/
    
    UIBarButtonItem *_doneButton=nil;
    if ([self.navigationController.viewControllers objectAtIndex:0] == self) {
        // We're first on stack so show done button
        _doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed:)];
        
        // Set appearance
        if ([UIBarButtonItem respondsToSelector:@selector(appearance)]) {
            [_doneButton setBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [_doneButton setBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
            [_doneButton setBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            [_doneButton setBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
            [_doneButton setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateNormal];
            [_doneButton setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateHighlighted];
        }
        self.navigationItem.leftBarButtonItem = _doneButton;
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
    for (UIView *views in self.view.subviews) {
        
        if ([views isKindOfClass:[UIToolbar class]]) {
            
            UIToolbar *tempBar=(UIToolbar*)views;
            NSMutableArray *arr=[NSMutableArray arrayWithArray:tempBar.items];
            
            [arr removeObjectAtIndex:2];
            [arr removeObjectAtIndex:3];

            //UIBarButtonItem*tempitem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ImageError@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(jubao_click)];
            
           // UIBarButtonItem*tempitem= [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStylePlain target:self action:@selector(jubao_click)];
            UIBarButtonItem*tempitem= [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
            
            tempitem.width = 32; // To balance action button

            [arr removeObjectAtIndex:0];
            [arr insertObject:tempitem atIndex:0];

            [tempBar setItems:arr];
        }
        
    }

}
- (void)setPhotos:(NSArray *)photos{
    _photos=photos;
    
    NSMutableArray *tempphotos = [[NSMutableArray alloc] init];
    for (NSString *str in _photos) {
        [tempphotos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:str]]];
    }
    self.arr_photos = tempphotos;
    tempphotos=nil;
    
   
}
- (void)jubao_click{
    
    
    ActionSheetStringPicker *picker=[ActionSheetStringPicker showPickerWithTitle:@"请选择举报选项" rows:self.arr_jubao initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    
    picker=nil;
    

    
}
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _arr_photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _arr_photos.count)
        return [_arr_photos objectAtIndex:index];
    return nil;
}
- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    //NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
