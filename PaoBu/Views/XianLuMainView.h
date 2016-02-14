#import <UIKit/UIKit.h>

@interface XianLuMainView : UIView
@property(nonatomic,strong) IBOutlet UIView  *view;
@property (weak, nonatomic) IBOutlet UITableView *tableV_list;


@property(nonatomic,strong)getTraceLineInfoOBJ *traceLineInfoOBJ;

- (void)reloadWithOBJ:(getTraceLineInfoOBJ *)OBJ;
@end
