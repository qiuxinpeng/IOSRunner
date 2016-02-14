#import "EditUserInfoTextTableViewCell.h"

@implementation EditUserInfoTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
- (void)setType:(UserEditType)type{
    _type=type;
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
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
