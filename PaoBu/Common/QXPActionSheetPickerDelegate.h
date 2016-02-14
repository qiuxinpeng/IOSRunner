#import <Foundation/Foundation.h>
#import "ActionSheetPicker.h"

@interface QXPActionSheetPickerDelegate : UIActionSheet <ActionSheetCustomPickerDelegate>

//必须要实现的
//设置几列
@property(nonatomic, strong)NSInteger (^numberOfComponentsInPickerViewBlock)();
//设置几行
@property(nonatomic, strong)NSInteger (^numberOfRowsInComponentBlock)(NSInteger component,NSInteger row);
//设置rowTitle
@property(nonatomic, strong)NSString* (^titleForRowBlock)(NSInteger row,NSInteger component,NSInteger choiceComponent);
//滑动选项
@property(nonatomic, strong)void (^didSelectRowBlock)(UIPickerView *pickerView,NSInteger row,NSInteger component);
//点击事件
@property(nonatomic, strong)void (^actionSheetPickerDidSucceedBlock)(AbstractActionSheetPicker *actionSheetPicker,NSInteger oneRow,NSInteger twoRow);


+ (QXPActionSheetPickerDelegate *)delegateWihtBlock:(NSInteger(^)())numberOfComponents
                            numberOfRowsInComponent:(NSInteger(^)(NSInteger component,NSInteger row))numberOfRowsInComponent
                                        titleForRow:(NSString*(^)(NSInteger row,NSInteger component,NSInteger choiceComponent))titleForRow;




@end
