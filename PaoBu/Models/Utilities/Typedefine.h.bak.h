//
//  Typedefine.h
//  RMT_iphone
//
//  Created by Victor on 7/25/14.
//  Copyright (c) 2014 邱新鹏. All rights reserved.
//

#ifndef RMT_iphone_Typedefine_h
#define RMT_iphone_Typedefine_h
#pragma 所有逻辑错误ERROR_CODE必须大于10000


/**/
typedef NS_ENUM(NSInteger, ProgramListType) {
    ProgramListTypeMainPage = 1,// 首页
    ProgramListTypeMorePage = 2// 更多
};

typedef NS_ENUM(NSInteger, ProgramListCellType) {
    ProgramListCellTypeToday = 1,// 今天
    ProgramListCellTypeOldDay = 2// 以往
};


typedef NS_ENUM(NSInteger, ProgramListSortType) {
    ProgramListSortTypeTime     = 0,// 时间
    ProgramListSortTypePraise   = 1,// 好评
    ProgramListSortTypePerson   = 2// 人气
};
typedef NS_ENUM(NSInteger, ProgramTiaoZhanType) {
    ProgramTiaoZhanTypeNoPass  = 0,// 没有过
    ProgramTiaoZhanTypePass    = 1// 通过

};
typedef NS_ENUM(NSInteger, ProgramTiaoZhanStatType) {
    ProgramTiaoZhanStatTypeTong = 0,// 铜星
    ProgramTiaoZhanStatTypeYin  = 1,// 银星
    ProgramTiaoZhanStatTypeJin  = 2// 金星
};
typedef NS_ENUM(NSInteger, DownLoadProgramType) {
    //DownLoadProgramTypeNone   = 0,//无记录
    DownLoadProgramTypeNoHave = 0,// 没有下载
    DownLoadProgramTypeHave   = 1// 已下载
};
typedef NS_ENUM(NSInteger, ProgramTopicSelectButtonType) {
    ProgramTopicSelectButtonNone     = 0,//无记录
    ProgramTopicSelectButtonSelect   = 1,// 选中
    ProgramTopicSelectButtonDeSelect = 2,// 没有选中
    ProgramTopicSelectButtonSuccess  = 3// 显示答案

};
typedef NS_ENUM(NSInteger, ProgramPageKeyWordSaveType) {
    ProgramPageKeyWordSaveTypeNone   = 0,//无记录
    ProgramPageKeyWordSaveTypeNoHave = 1,//没有保存
    ProgramPageKeyWordSaveTypeHave   = 2//已经保存
};

typedef NS_ENUM(NSInteger, KeyWordRecordPlayType) {
   
    KeyWordRecordPlayTypeStop   = 0,//停止状态,将要播放
    KeyWordRecordPlayTypePlay   = 1,//播放状态
};
typedef NS_ENUM(NSInteger, RecordPlayType) {
    RecordPlayTypeNone   = 0,//开始状态
    RecordPlayTypeRecord = 1,//录音状态
    RecordPlayTypePlay   = 3,//播放状态
    RecordPlayTypeStop   = 2,//停止状态,将要播放
};

typedef NS_ENUM(NSInteger, SoundManagerStyle) {
    SoundManagerStyleNone           = 0,//默认状态 结束之后不用继续播放
    SoundManagerStylePlayContinue   = 1,//切断之后需要继续播放
    SoundManagerStyleRecordContinue = 2,//切断之后录音还要继续

};

typedef NS_ENUM(NSInteger, ProgramPageEndViewStyle) {
    ProgramPageEndViewStyleCheck           = 0,//默认状态 已有128个同学闯关成功
    ProgramPageEndViewStyleFail            = 1,//有4题错误/第1，3，4，5题错误
    ProgramPageEndViewStyleSuccess         = 2,//闯关成功！ +50Exp
    
};

typedef NS_ENUM(NSInteger, ProgramPageEndBtnType) {
    ProgramPageEndBtnTypeCheck        = 0,//默认状态 等下，检查一遍
    ProgramPageEndBtnTypeSubmit       = 1,//提交闯关
    ProgramPageEndBtnTypeHelp         = 2,//求助好友
    ProgramPageEndBtnTypeTryAgain     = 3,//再试一次
    ProgramPageEndBtnTypeReview       = 4,//回顾一遍
};

//”我的“cell标记
typedef NS_ENUM(NSInteger, MyCellNTag) {
    MyCellNTagNone       = 0,//默认状态 无
    MyCellNTagXiaZai     = 1,//下载
    MyCellNTagCiJu       = 2,//英伦角
    MyCellNTagAtMe       = 3,//@我的
    
    MyCellNTagSheZhi     = 4,//设置
    
    MyCellNTagMyProfile     = 5,//我的动态
    MyCellNTagMyFollow       = 6,//我的关注
    MyCellNTagSysInfo       = 7,//系统消息
    MyCellNTagFeedbackInfo     = 8,//意见反馈
    MyCellNTagMyInfoEdit      = 9,//我的信息编辑
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

//地址选择页
typedef NS_ENUM(NSInteger, AddressListType) {
    AddressListTypeCountry            = 0,//默认状态 国家
    AddressListTypeCity               = 1,//城市
    AddressListTypeCountryNum         = 2,//国家代码
};

//购买对应ID信息
typedef NS_ENUM(NSInteger, PayTypeID) {
    PayTypeID30Day          = 1,//1-普通30天会员
    PayTypeID180Day         = 3,//普通180天会员
    PayTypeID360Day         = 5,//普通年会员
    PayTypeID30DayDiscount  = 2,//特惠30天会员
    PayTypeID180DayDiscount = 4,//特惠180天会员
    PayTypeID360DayDiscount = 6,//特惠年会员
};
//是否可以下载信息
typedef NS_ENUM(NSInteger, CanDownloadType) {
    CanDownloadTypeNone      = 0,//不弹框
    CanDownloadTypeShow      = 1,//弹扣豆框
    CanDownloadTypeShowErr   = 2,//弹吧豆数不够框
};

//是否可以下载信息
typedef NS_ENUM(NSInteger, PlayType) {
    playTypeNone      = 0,//无播放信息
    playTypePlaying   = 1,//正在播放
    playTypeStop      = 2,//播放暂停
};

//AttributeTextCell样式。（@我的、题目论坛）
typedef NS_ENUM(NSInteger, ProgramAttributeTextCellStyle) {
    ProgramAttributeTextCellStyleDefault      = 0,//默认，黑底白字。
    ProgramAttributeTextCellStyleClear        = 1,//浅色背景，黑字
};

//输入类型：文本，录音
typedef NS_ENUM(NSInteger, LTInputType) {
    LTInputTypeNormal = 0,  // 默认，输入文本状态
    LTInputTypeAudio  = 1,  // 输入录音状态
};

//帖子排序类型
typedef NS_ENUM(NSInteger, LTSortType) {
    LTSortTypeByTime     = 0,  // 默认，按时间排序
    LTSortTypeByGoodNum  = 1,  // 按赞数排序
};
//词句列表样式类型
typedef NS_ENUM(NSInteger, ProgramPageKeyWordViewTitleCellType) {
    ProgramPageKeyWordViewTitleCellTypeWhite  = 0,  // 默认，字的颜色是白的
    ProgramPageKeyWordViewTitleCellTypeBlack  = 1,     // 字的颜色是黑的
};

//弹幕列表Cell类型
typedef NS_ENUM(NSInteger, DanMuTableViewCellSectionType) {
    DanMuTableViewCellSectionTypeDefault  = 0,  // 默认，无类型
    DanMuTableViewCellSectionTypePlaying  = 1,  // 播放，播放进度
    DanMuTableViewCellSectionTypeMenu     = 2,  // 操作区（下载，关注...）
    DanMuTableViewCellSectionTypeAnchor   = 3,  // 主播区
    DanMuTableViewCellSectionTypeTribe    = 4,  // 部落区
};
//弹幕列表Cell类型
typedef NS_ENUM(NSInteger, DanMuHeaderViewSelectedType) {
    DanMuHeaderViewSelectedTypeYuLiao   = 0,  // 语聊
    DanMuHeaderViewSelectedTypeJieMu    = 1,  // 节目
    DanMuHeaderViewSelectedTypeShengCi  = 2,  // 生词
};
//播放类型
typedef NS_ENUM(NSInteger, playerPlayType) {
    playerPlayTypeDanMu   = 0,  // 弹幕播放
    playerPlayTypeCiJu   = 1  // 词句

};



//修改个人信息（性别，国籍，所在地）的上级入口控制器,
typedef NS_ENUM(NSInteger, ToEditViewControllerFromType) {
    ToEditViewControllerFromTypeMyInfo   = 0,  // 个人信息，选择地址后直接返回至上一级
    ToEditViewControllerFromTypeLogin    = 1,  // 注册登录,需要点击“完成”按钮才能返回至上一级
    
};


//修改个人信息，(多选)
typedef NS_ENUM(NSInteger, EditMutableSelectedViewControllerType) {
    EditMutableSelectedViewControllerTypeNone   = 0,  // 默认，无类型
    EditMutableSelectedViewControllerTypeHuiShuo    = 1,  // 会说(多选)
    EditMutableSelectedViewControllerTypeHXiangXue    = 2,  // 想学(多选)
    EditMutableSelectedViewControllerTypeAiHao    = 3,   // 爱好(多选)
};


//修改个人信息，（多行）
typedef NS_ENUM(NSInteger, EditMutableLineViewControllerType) {
    EditMutableLineViewControllerTypeNone   = 0,  // 默认，无类型
    EditMutableLineViewControllerTypeJieShao    = 1,  // 介绍（多行）
  
};



//申请的部落状态

typedef NS_ENUM(NSInteger, ClanMyTableCellFlagType) {
    ClanMyTableCellFlagTypeNone       = 3,  // 默认，无内容
    ClanMyTableCellFlagTypeAccess     = 0,  // 审核通过
    ClanMyTableCellFlagTypeProcress    = 1,  // 审核中  - 显示 ， 其余都 不显示
    ClanMyTableCellFlagTypeFailure     = 2, //  审核失败
};


#endif
