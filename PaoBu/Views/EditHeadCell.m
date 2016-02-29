#import "EditHeadCell.h"

@interface EditHeadCell ()
@property(nonatomic, strong)UIImage *chooseImg;
@end

@implementation EditHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.img_head.backgroundColor=[UIColor redColor];
    self.backgroundColor=[UIColor clearColor];
    [self.img_head addRoundWithRadius:self.img_head.ui_width/2];
    [self.img_head sd_setImageWithURL:[NSURL URLWithString:[PBUser sharedUser].PhotoUrl]];
    
    UIButton *tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame=self.bounds;
    [tempBtn addTarget:self action:@selector(chooseImg_click) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tempBtn];
}
- (void)chooseImg_click{
    [UIActionSheet actionSheetWithEventBlock:^(UIActionSheet *s ,NSInteger buttonIndex) {
        NSString *msg=[s buttonTitleAtIndex:buttonIndex];
        if ([msg isEqualToString:@"取消"]) {
            return ;
        }
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.allowsEditing=YES;

        if (buttonIndex==1) {
            NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&[mediatypes count]>0){
                picker.mediaTypes=mediatypes;
               
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                NSString *requiredmediatype=(NSString *)kUTTypeImage;
                NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
                [picker setMediaTypes:arrmediatypes];
            }
            else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
                picker=nil;
                return;
            }
        }else if (buttonIndex==2){
            NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                picker.mediaTypes=mediatypes;
                
                picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                NSString *requiredmediatype=(NSString *)kUTTypeImage;
                NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
                [picker setMediaTypes:arrmediatypes];
        }
        
        [self.viewController presentViewController:picker animated:YES completion:nil];
        [picker setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *info) {
           UIImage *chosenImage = [[UIImage imageWithData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 0.5)] copy];
            
            self.chooseImg=chosenImage;
            chosenImage=nil;
            self.img_head.image=self.chooseImg;
            [[BBInterface interfaceWithFinshBlock:^(id responseObje) {
                NSString *path=[responseObje objectForKey:@"path"];
                [PBUser sharedUser].PhotoUrl=path;
                [[PBUser sharedUser] synchronize];
                [UIAlertView say:@"上传图片成功!"];
            } faildBlock:^(NSError *err) {
                [UIAlertView say:@"上传失败!"];
            } HUDBackgroundView:self.viewController.view tag:nil] uploadPhoto:self.chooseImg];
            [vc dismissViewControllerAnimated:YES completion:nil];
        }];
        [picker setBk_didCancelBlock:^(UIImagePickerController *vc) {
            [vc dismissViewControllerAnimated:YES completion:nil];
        }];
    } title:@"请选择来源" destructiveButtonTitle:nil cancelTitle:@"取消" showInView:self.viewController.view otherButtonTitlesArr:@[@"拍照",@"从手机相册选择"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
