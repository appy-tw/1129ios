//
//  BATTLEGROUNDViewController.m
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "BATTLEGROUNDViewController.h"
#import "AppDelegate.h"

@interface BATTLEGROUNDViewController ()
{
    AppDelegate *delegate;
    UIWebView *uiwWebView;
}

@end

@implementation BATTLEGROUNDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setWebView];
}

- (void)setWebView {
    NSString *nssEmbedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString *nssHtml = [NSString stringWithFormat:nssEmbedHTML, @"https://www.youtube.com/watch?feature=player_embedded&v=OtvbZscM90A", self.view.frame.size.width, self.view.frame.size.height];
    uiwWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    [uiwWebView loadHTMLString:nssHtml baseURL:nil];
    [self.view addSubview:uiwWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [delegate.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rotationChanged:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    [super viewWillAppear:animated];
}

-(void)rotationChanged:(NSNotification *)notification{
    NSInteger orientation = [[UIDevice currentDevice] orientation];
    UIWindow *_window = [[[UIApplication sharedApplication] delegate] window];
    switch (orientation) {
        case 1:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            
            [_window setTransform:CGAffineTransformMakeRotation (0)];
            [_window setFrame:CGRectMake(0, 0, 320, 480)];
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
            
            [UIView commitAnimations];
            break;
        case 2:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            
            [_window setTransform:CGAffineTransformMakeRotation (M_PI)];
            [_window setFrame:CGRectMake(0, 0, 320, 480)];
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
            
            [UIView commitAnimations];
            break;
        case 3:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            
            [_window setTransform:CGAffineTransformMakeRotation (M_PI / 2)];
            [_window setFrame:CGRectMake(0, 0, 320, 480)];
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            
            [UIView commitAnimations];
            break;
        case 4:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            
            [_window setTransform:CGAffineTransformMakeRotation (- M_PI / 2)];
            [_window setFrame:CGRectMake(0, 0, 320, 480)];
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
            
            [UIView commitAnimations];
            break;
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft]
                                forKey:@"orientation"];
        NSLog(@"xxxxxxx");
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [delegate.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate {
    return YES;
}

@end
