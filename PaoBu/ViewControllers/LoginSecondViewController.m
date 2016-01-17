//
//  LoginSecondViewController.m
//  NewBaLa
//
//  Created by Mr.Qiu on 15/8/10.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "LoginSecondViewController.h"
//#import "SysInfoOBJ.h"
#import "ActionSheetStringPicker.h"


@interface LoginSecondViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) id lastChosenMediaType;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewLogo;

@property (weak, nonatomic) IBOutlet UILabel *lab_blaNO;

@property (nonatomic, strong) NSData *cur_imageData;//头像



@end

@implementation LoginSecondViewController
@synthesize lastChosenMediaType;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData];
    
    self.title = @"完善资料";
    [self addRightBar:@"完成" action:@selector(btnOKAction:)];
    
    
    __weak LoginSecondViewController *wself=self;

    //昵称
    
    //国籍
    
    [self.textF_guoji setBk_shouldBeginEditingBlock:^BOOL(UITextField *field) {

//        NSArray *tempArr = [SysInfoOBJ sharedInfo].tb_Country_Info;
//        
//        NSMutableArray *muArr_temp = [NSMutableArray array];
//        for (J_country_info_IDEntity *obj in tempArr) {
//            [muArr_temp addObject:obj.CountryNameCN];
//        }
//        
//        
//        
//        [ActionSheetStringPicker showPickerWithTitle:@"选择国籍" rows:muArr_temp initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//            
//            wself.textF_guoji.text=selectedValue;
//            J_country_info_IDEntity *tempobj= tempArr[selectedIndex];
//            
//            
//        } cancelBlock:^(ActionSheetStringPicker *picker) {
//            
//        } origin:self.view];

        
        
        
        [wself toSelectedVC:EditMyInfoCellNTagGuoJi];
        
        return NO;
    }];
    
    
    //母语
    [self.textF_Muyu setBk_shouldBeginEditingBlock:^BOOL(UITextField *field) {
        
//        NSArray *tempArr = [SysInfoOBJ sharedInfo].tb_MotherTongue_Info;
//        
//        NSMutableArray *muArr_temp = [NSMutableArray array];
//        for (J_MotherTongue_Info_IdEntity *obj in tempArr) {
//            [muArr_temp addObject:obj.TongueName];
//        }
//        
//        
//        
//        [ActionSheetStringPicker showPickerWithTitle:@"选择母语" rows:muArr_temp initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//            
//            wself.textF_Muyu.text=selectedValue;
//            J_MotherTongue_Info_IdEntity *tempobj= tempArr[selectedIndex];
//            
//            
//        } cancelBlock:^(ActionSheetStringPicker *picker) {
//            
//        } origin:self.view];

        [wself toSelectedVC:EditMyInfoCellNTagMuYu];
        
        return NO;
    }];
    
    
    
    
    //性别
    [self.textF_xingbie setBk_shouldBeginEditingBlock:^BOOL(UITextField *field) {
        
//        SexOBJ *obj1 = [[SexOBJ alloc] init];
//        obj1.ID = @"1";
//        obj1.sexName = [SexOBJ getOBJ:obj1.ID];
//        
//        
//        SexOBJ *obj2 = [[SexOBJ alloc] init];
//        obj2.ID = @"2";
//        obj2.sexName = [SexOBJ getOBJ:obj2.ID];
//        
//        
//        NSArray *tempArr = @[obj1, obj2];
//        
//        NSMutableArray *muArr_temp = [NSMutableArray array];
//        for (SexOBJ *obj in tempArr) {
//            [muArr_temp addObject:obj.sexName];
//        }
//        
//        [ActionSheetStringPicker showPickerWithTitle:@"选择性别" rows:muArr_temp initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//            
//            wself.textF_xingbie.text=selectedValue;
//            SexOBJ *tempobj= tempArr[selectedIndex];
//            
//            
//        } cancelBlock:^(ActionSheetStringPicker *picker) {
//            
//        } origin:self.view];

        
        
        
        
        
        [wself toSelectedVC:EditMyInfoCellNTagXingBie];
        
        return NO;
    }];
    
    
    
   
    
    
    //所在地
    [self.textF_suozaidi setBk_shouldBeginEditingBlock:^BOOL(UITextField *field) {
        
       
        [wself toSelectedVC:EditMyInfoCellNTagSuoZaiDi];
        
        return NO;
    }];
    
    //邀请码
    
    
    [self _initCustomUI];
    
}
- (void)_initCustomUI {
    self.btn_logo.layer.cornerRadius = CGRectGetHeight(_btn_logo.frame)/2.;
    self.btn_logo.layer.masksToBounds = YES;
    
}

- (void)toSelectedVC:(EditMyInfoCellNTag)type {
    
    
}
- (void)_reloadLogo:(UIImage *)image {
    
    if (image) {
        [self.btn_logo setBackgroundImage:image forState:UIControlStateNormal];
    } else {
    }
    
    
}

- (void)refreshData {
    
    
    [self _reloadLogo:nil];
    
 

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//头像
- (IBAction)btnLogoAction:(id)sender {
    
    
    UIActionSheet *sheet= [[UIActionSheet alloc] init];
    [sheet bk_setCancelButtonWithTitle:@"取消" handler:^{
        
    }];
    [sheet bk_setDestructiveButtonWithTitle:@"从相册选择" handler:^{
        [self selectExistingPictureOrVideo];
    }];
    [sheet bk_setDestructiveButtonWithTitle:@"拍照" handler:^{
        [self shootPiicturePrVideo];
    }];
    [sheet showInView:self.view];
    
}
//确认
- (IBAction)btnOKAction:(id)sender {
    

    
    
}
//跳过
- (IBAction)btnContuneAction:(id)sender {
    
    if (self.loginCallBlock) {
        self.loginCallBlock(NO);
    }
}





#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPiicturePrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
//从相册中选择
-(void)selectExistingPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.lastChosenMediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
    {
        NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 0.4);
        
        self.cur_imageData = imageData;
        
        [self _reloadLogo:[UIImage imageWithData:self.cur_imageData]];
        
        imageData=nil;
    }
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}







@end
