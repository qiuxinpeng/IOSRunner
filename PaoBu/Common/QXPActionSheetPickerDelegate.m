#import "QXPActionSheetPickerDelegate.h"

@implementation QXPActionSheetPickerDelegate
- (id)init
{
    if (self = [super init]) {
        
        
    }
    return self;
}


#pragma mark - ActionSheetCustomPickerDelegate Optional's

- (void)configurePickerView:(UIPickerView *)pickerView
{
    // Override default and hide selection indicator
    
    NSLog(@"++++++++");
    
    pickerView.showsSelectionIndicator = NO;
    [pickerView selectRow:0 inComponent:0 animated:NO];
    [pickerView selectRow:0 inComponent:1 animated:NO];
    
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    
    /*
    if (self.ypcheck.ypfirstLayer==0&&self.ypcheck.ypsub_layer==0) {
        self.ypcheck.isfirst=YES;
    }else{
        self.ypcheck.isfirst=NO;
    }
    NSDictionary *dictaudio=[self.ypList objectAtIndex:self.ypcheck.ypfirstLayer];
    NSArray *arrAudio=[dictaudio  objectForKey:@"list"];
    
    if (self.ypcheck.ypfirstLayer==[self.ypList count]-1&&self.ypcheck.ypsub_layer==[arrAudio count]-1) {
        self.ypcheck.islast=YES;
    }else{
        self.ypcheck.islast=NO;
    }
    
    NSLog(@"self.ypcheck.ypfirstLayer=%d",self.ypcheck.ypfirstLayer);
    NSLog(@"self.ypcheck.ypsub_layer=%d",self.ypcheck.ypsub_layer);
    
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    */
    
    UIPickerView *tempPiker=(UIPickerView *)actionSheetPicker.pickerView;
    
    NSInteger oneRow=[tempPiker selectedRowInComponent:0]==-1?0:[tempPiker selectedRowInComponent:0];
    NSInteger twoRow=[tempPiker selectedRowInComponent:1]==-1?0:[tempPiker selectedRowInComponent:1];
    tempPiker=nil;
    
    if (self.actionSheetPickerDidSucceedBlock) {
        self.actionSheetPickerDidSucceedBlock(actionSheetPicker,oneRow,twoRow);
    }
    
}

+ (QXPActionSheetPickerDelegate *)delegateWihtBlock:(NSInteger(^)())numberOfComponents
                            numberOfRowsInComponent:(NSInteger(^)(NSInteger component,NSInteger row))numberOfRowsInComponent
                                        titleForRow:(NSString*(^)(NSInteger row,NSInteger component,NSInteger choiceComponent))titleForRow{
    
    __autoreleasing QXPActionSheetPickerDelegate *tempDelegata=[[QXPActionSheetPickerDelegate alloc]init];
    tempDelegata.numberOfComponentsInPickerViewBlock=numberOfComponents;
    tempDelegata.numberOfRowsInComponentBlock=numberOfRowsInComponent;
    tempDelegata.titleForRowBlock=titleForRow;
    
    return tempDelegata;
}

#pragma mark - UIPickerViewDataSource Implementation


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    
    if (self.numberOfRowsInComponentBlock) {
        return self.numberOfRowsInComponentBlock(component,[pickerView selectedRowInComponent:0]);
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (self.titleForRowBlock) {
        return self.titleForRowBlock(row,component,[pickerView selectedRowInComponent:0]);
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    switch (component) {
//        case 0:
//        {
//            
//            self.ypcheck.ypfirstLayer=row;
//            self.ypcheck.ypsub_layer=0;
//            [pickerView selectRow:0 inComponent:1 animated:NO];
//            [pickerView reloadComponent:1];
//            
//            
//        }
//            
//            break;
//        case 1:
//        {
//            self.ypcheck.ypsub_layer=row;
//            
//        }
//            
//            break;
//        default:
//            break;
//    }
    
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(pickerView,row,component);
    }
    
}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.numberOfComponentsInPickerViewBlock) {
        return self.numberOfComponentsInPickerViewBlock();
    }else
        return 2;
}



#pragma mark UIPickerViewDelegate Implementation

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: return 160.0f;
        case 1: return 160.0f;
    }
    
    return 0;
}
@end
