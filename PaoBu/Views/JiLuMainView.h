#import <UIKit/UIKit.h>

@interface JiLuMainView : UIView

@property(nonatomic,strong) IBOutlet UIView  *view;
@property (weak, nonatomic) IBOutlet UITableView *tabV_list;
@property (strong, nonatomic)getRecommendTraceInfoOBJ *OBJ;

- (void)willShow;

@end
