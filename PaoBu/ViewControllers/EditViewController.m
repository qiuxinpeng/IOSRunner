//
//  EditViewController.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/2.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "EditViewController.h"
#import "EditHeadCell.h"
#import "EditUserInfoTextTableViewCell.h"
#import "EditUserInfoDetailViewController.h"
#import "ActionSheetStringPicker.h"
#import "PBTypeDefine.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"编辑";
    self.view.backgroundColor=[UIColor clearColor];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"EditHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EditHeadCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"EditUserInfoTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EditUserInfoTextTableViewCell"];

    //self.tableV_list.backgroundColor=[UIColor clearColor];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableV_list reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section==2) {
        return @"身体指标(非公开)";
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view=[UIView new];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if (section==1){
        return 5;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 150;
        
    }else{
        
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        EditHeadCell *cell=(EditHeadCell*)[tableView dequeueReusableCellWithIdentifier:@"EditHeadCell" forIndexPath:indexPath];
        return cell;
    }else{
        EditUserInfoTextTableViewCell *cell=(EditUserInfoTextTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"EditUserInfoTextTableViewCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.section==1) {
            switch (indexPath.row) {
                case 0:
                    cell.type=UserEditTypeNikeName;
                    break;
                case 1:
                    cell.type=UserEditTypeSex;
                    break;
                case 2:
                    cell.type=UserEditTypeAge;
                    break;
                case 3:
                    cell.type=UserEditTypeHobbies;
                    break;
                case 4:
                    cell.type=UserEditTypeSignature;
                    break;
                default:
                    break;
            }
            
        }else{
            if (indexPath.row==0) {
                cell.type=UserEditTypeHeight;
            }else if (indexPath.row==1){
                cell.type=UserEditTypeWeight;
            }
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section!=0) {
        EditUserInfoTextTableViewCell *cell=(EditUserInfoTextTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.type==UserEditTypeNikeName) {
            EditUserInfoDetailViewController *VC=[[EditUserInfoDetailViewController alloc]initWithNibName:@"EditUserInfoDetailViewController" bundle:nil];
            VC.type=cell.type;
            [self pushVC:VC animated:YES];
        }else if (cell.type==UserEditTypeSex){
            [ActionSheetStringPicker showPickerWithTitle:@"请选择" rows:@[@"保密",@"男",@"女"] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                
                [[BBInterFace interfaceWithFinshBlock:^(id responseObje) {
                    if (selectedIndex==0) {
                        [PBUser sharedUser].Gender =@"保密";
                    }else if (selectedIndex==1){
                        [PBUser sharedUser].Gender =@"男";
                    }else if (selectedIndex==2){
                        [PBUser sharedUser].Gender =@"女";
                    }
                    [[PBUser sharedUser] synchronize];
                    [PBUser lginOK];
                    [UIAlertView say:@"修改性别成功!"];
                    //[self popVC:YES];
                    
                } faildBlock:^(NSError *err) {
                    [UIAlertView say:err.domain];
                    
                } HUDBackgroundView:self.view tag:self.tagWithInterFace] editPersonalInfo:nil genderID:stringWithInt(selectedIndex) ageID:nil hobbies:nil hobbiesDetail:nil signature:nil height:nil weight:nil];
                
            } cancelBlock:nil origin:self.view];
        
        }else if (cell.type==UserEditTypeAge){
            
        }else if (cell.type==UserEditTypeHobbies){
            
        }else if (cell.type==UserEditTypeSignature){
            
            EditUserInfoDetailViewController *VC=[[EditUserInfoDetailViewController alloc]initWithNibName:@"EditUserInfoDetailViewController" bundle:nil];
            VC.type=cell.type;
            [self pushVC:VC animated:YES];
            
        }else if (cell.type==UserEditTypeHeight){
            
        }else if (cell.type==UserEditTypeWeight){
            
        }
    }
}


@end
