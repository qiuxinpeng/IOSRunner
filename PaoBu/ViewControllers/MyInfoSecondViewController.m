//
//  MyInfoSecondViewController.m
//  PaoBu
//
//  Created by 邱玲 on 15/9/1.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "MyInfoSecondViewController.h"
//import "MyInfoHeadFirstCell.h"
#import "MyInfoSecondHeadCell.h"
#import "MyInfoSecondTextCell.h"
#import "EditViewController.h"

@interface MyInfoSecondViewController ()

@end

@implementation MyInfoSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
    [self.tableV_list registerNib:[UINib nibWithNibName:@"MyInfoSecondHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyInfoSecondHeadCell"];
    [self.tableV_list registerNib:[UINib nibWithNibName:@"MyInfoSecondTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyInfoSecondTextCell"];

    self.tableV_list.backgroundColor=[UIColor clearColor];
    
    [self setRightBarWithBtn:nil imageName:@"edit.png" action:@selector(edit_click)];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)edit_click{
    EditViewController *editVC=[[EditViewController alloc]initWithNibName:@"EditViewController" bundle:nil];
    [self pushVC:editVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view=[UIView new];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 130;
        
    }else{
        
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        MyInfoSecondHeadCell *cell=(MyInfoSecondHeadCell*)[tableView dequeueReusableCellWithIdentifier:@"MyInfoSecondHeadCell" forIndexPath:indexPath];
        [cell reloadWithInfo:[PBUser sharedUser]];
        return cell;
        
    }else {
        
        MyInfoSecondTextCell *cell=(MyInfoSecondTextCell*)[tableView dequeueReusableCellWithIdentifier:@"MyInfoSecondTextCell" forIndexPath:indexPath];
        
        if (indexPath.row==0){
            cell.lab_title.text=@"最近运动";
            
            NSString *tempStr=[NSString stringWithFormat:@"%@ %@ %@",[PBUser sharedUser].ParCategoryName,[PBUser sharedUser].CategoryName,[PBUser sharedUser].TraceName];
            cell.lab_text.text=tempStr;
            cell.lab_info.text=[PBUser sharedUser].LatestRunTime;
            
        }else if (indexPath.row==1){
            cell.lab_title.text=@"最近参与";

        }
        return cell;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
