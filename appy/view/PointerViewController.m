#import "PointerViewController.h"

@implementation PointerViewController

- (id)initWithViewController:(UIViewController *)uivcInputViewController
{
    if (self = [super init]) {
        _uivcViewController = uivcInputViewController;
    }
    return self;
}

- (void)loadView
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.view = view;
    
    _uivContainerView = [[UIView alloc] initWithFrame:view.bounds];
    _uivContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_uivContainerView];
    
    [_uivContainerView addSubview:_uivcViewController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [_uivcViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_uivcViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_uivcViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)PointerToViewController:(UIViewController *)aViewController
                    withOptions:(UIViewAnimationOptions)options
{
    aViewController.view.frame = _uivContainerView.bounds;
    [UIView transitionWithView:_uivContainerView
                      duration:0.65f
                       options:options
                    animations:^{
                        [_uivcViewController.view removeFromSuperview];
                        [_uivContainerView addSubview:aViewController.view];
                    }
                    completion:^(BOOL finished){
                        _uivcViewController = aViewController;
                    }];
}

@end