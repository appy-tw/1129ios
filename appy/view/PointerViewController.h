#import <UIKit/UIKit.h>

@interface PointerViewController : UIViewController

@property (nonatomic, strong) UIView *uivContainerView;
@property (nonatomic, strong) UIViewController *uivcViewController;

- (id)initWithViewController:(UIViewController *)uivcInputViewController;
- (void)PointerToViewController:(UIViewController *)uivcInputViewController
                    withOptions:(UIViewAnimationOptions)options;

@end
