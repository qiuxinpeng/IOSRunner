//
//  EnumType.h
//  PaoBu
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#ifndef EnumType_h
#define EnumType_h

typedef NS_ENUM(NSInteger, UserEditType) {
    UserEditTypeNikeName = 1,//名称
    UserEditTypeSex=2,//性别
    UserEditTypeAge = 3,// 更多,
    UserEditTypeHobbies=4,//爱好
    UserEditTypeSignature=5,//签名
    UserEditTypeHeight=6,//身高
    UserEditTypeWeight=7//体重
};
//个人信息修改页Cell点击标记
typedef NS_ENUM(NSInteger, EditMyInfoCellNTag) {
    EditMyInfoCellNTagNone            = 0,//默认状态 无
    EditMyInfoCellNTagTouXiang        = 1,//头像
    EditMyInfoCellNTagFengMain        = 2,//封面
    EditMyInfoCellNTagBeiJing         = 3,//背景
    EditMyInfoCellNTagMuYu            = 4,//母语
    EditMyInfoCellNTagGuoJi           = 5,//国籍 - 出示国家信息
    EditMyInfoCellNTagXingBie         = 6,//性别
    EditMyInfoCellNTagNianLing        = 7,//年龄
    EditMyInfoCellNTagSuoZaiDi        = 8,//所在地  - 进入下一级，选择国家和城市
    EditMyInfoCellNTagClanAddress        = 9,//部落创建地址  - 选择‘全国’和城市
};
#endif /* EnumType_h */
