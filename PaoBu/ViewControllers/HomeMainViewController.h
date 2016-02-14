#import "BaseViewController.h"
#import "iCarousel.h"

@interface HomeMainViewController : BaseViewController<iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *ICarousel1;
@property (weak, nonatomic) IBOutlet iCarousel *ICarousel2;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@end
