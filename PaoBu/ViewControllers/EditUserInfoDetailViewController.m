#import "EditUserInfoDetailViewController.h"

@interface EditUserInfoDetailViewController ()

@end

@implementation EditUserInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightBar:@"确定" action:@selector(did_done)];
}
- (void)did_done{
    if (self.type==UserEditTypeNikeName) {
        if (self.textV_text.text.length>12) {
            [UIAlertView say:@"昵称不能超过12个!"];
            return;
        }
        [[BBInterFace interfaceWithFinshBlock:^(id responseObje) {
            [PBUser sharedUser].DisplayName=self.textV_text.text;
            [[PBUser sharedUser] synchronize];
            [PBUser lginOK];
            [UIAlertView say:@"修改昵称成功!"];
        } faildBlock:^(NSError *err) {
            [UIAlertView say:err.domain];
        } HUDBackgroundView:self.view tag:self.tagWithInterFace] editPersonalInfo:self.textV_text.text genderID:nil ageID:nil hobbies:nil hobbiesDetail:nil signature:nil height:nil weight:nil];
    }else if (self.type==UserEditTypeSex){
        
    }else if (self.type==UserEditTypeAge){
        
    }else if (self.type==UserEditTypeHobbies){
        
    }else if (self.type==UserEditTypeSignature){
        if (self.textV_text.text.length>50) {
            [UIAlertView say:@"简介不能超过50个!"];
            return;
        }
        [[BBInterFace interfaceWithFinshBlock:^(id responseObje) {
            [PBUser sharedUser].Signature =self.textV_text.text;
            [[PBUser sharedUser] synchronize];
            [PBUser lginOK];
            [UIAlertView say:@"修改简介成功!"];
        } faildBlock:^(NSError *err) {
            [UIAlertView say:err.domain];
        } HUDBackgroundView:self.view tag:self.tagWithInterFace] editPersonalInfo:nil genderID:nil ageID:nil hobbies:nil hobbiesDetail:nil signature:self.textV_text.text height:nil weight:nil];
    }else if (self.type==UserEditTypeHeight){
        
    }else if (self.type==UserEditTypeWeight){
        
    }
}
- (void)setType:(UserEditType)type{
    /*
    switch (_type) {
        case UserEditTypeNikeName:
            self.lab_title.text=@"昵称";
            self.lab_detail.text=[PBUser sharedUser].DisplayName;
            break;
        case UserEditTypeSex:
            self.lab_title.text=@"性别";
            self.lab_detail.text=[PBUser sharedUser].Gender;
            break;
        case UserEditTypeAge:
            self.lab_title.text=@"年龄";
            self.lab_detail.text=[PBUser sharedUser].AgeGroupDescription;
            break;
        case UserEditTypeHobbies:
            self.lab_title.text=@"爱好";
            self.lab_detail.text=[PBUser sharedUser].HobbiesDetail;
            break;
        case UserEditTypeSignature:
            self.lab_title.text=@"签名";
            self.lab_detail.text=[PBUser sharedUser].Signature;
            break;
        case UserEditTypeHeight:
            self.lab_title.text=@"身高";
            self.lab_detail.text=[PBUser sharedUser].Height;
            break;
        case UserEditTypeWeight:
            self.lab_title.text=@"体重";
            self.lab_detail.text=[PBUser sharedUser].Weight;
            break;
            
        default:
            break;
    }
     */
    _type=type;
    switch (_type) {
        case UserEditTypeNikeName:
            self.title=@"昵称";
            //self.lab_detail.text=
            self.textV_text.text=[PBUser sharedUser].DisplayName;
            break;
        case UserEditTypeSex:
            break;
        case UserEditTypeAge:
            break;
        case UserEditTypeHobbies:
            break;
        case UserEditTypeSignature:
            break;
        case UserEditTypeHeight:
            break;
        case UserEditTypeWeight:
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
