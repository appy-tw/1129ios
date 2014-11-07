//
//  BATTLEGROUNDViewController.m
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "BATTLEGROUNDViewController.h"
#import "AppDelegate.h"

#import <FacebookSDK/FacebookSDK.h>

#import <Parse/Parse.h>


@interface BATTLEGROUNDViewController ()
{
    CGFloat cgfAvailableWidth;
    CGFloat cgfAvailableHeight;
    CGFloat cgfAvailableHeightStart;
    CGFloat cgfAvailableHeightEnd;
    
    CGFloat cgfStatusBarHeight;
    CGFloat cgfNavigationBarHeight;
    CGFloat cgfTabBarHeight;
    
    UILabel *uilUserNameTip;
    UILabel *uilUserName;
    UILabel *uilMissionTip;
    UILabel *uilMission;
    UILabel *uilMaterialTip;
    UILabel *uilMaterial;
    UILabel *uilLocationTip;
    UILabel *uilLocation;
    UIImageView *uiivProfile;

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
//    NSString *nssEmbedHTML = @"\
//    <html><head>\
//    <style type=\"text/css\">\
//    body {\
//    background-color: transparent;\
//    color: white;\
//    }\
//    </style>\
//    </head><body style=\"margin:0\">\
//    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
//    width=\"%0.0f\" height=\"%0.0f\"></embed>\
//    </body></html>";
    NSString *nssEmbedHTML = @"<!doctype html> <html class=\"no-js\"> <head> <meta charset=\"utf-8\"> <title>割闌尾 V 計畫 - Appendectomy V Project | 罷免日計畫</title> <meta name=\"description\" content=\"\"> <meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"> <meta property=\"og:title\" content=\"割闌尾 V 計畫\"> <meta property=\"og:type\" content=\"website\"> <meta property=\"og:url\" content=\"http://1129vday.tw/\"> <meta property=\"og:image\" content=\"http://1129vday.tw/images/cover.jpg\"> <!-- Place favicon.ico and apple-touch-icon.png in the root directory --> <link rel=\"stylesheet\" href=\"styles/vendor.f3c18335.css\"> <link rel=\"stylesheet\" href=\"styles/main.27d7a978.css\">  <body ng-app=\"projectVApp\"> <!--[if lt IE 7]><p class=\"browsehappy\">You are using an <strong>outdated</strong> browser. Please <a href=\"http://browsehappy.com/\">upgrade your browser</a> to improve your experience.</p><![endif]--> <!-- Add your site or application content here --> <div class=\"container\"> <div class=\"header\" ng-controller=\"PagesCtrl\"> <span ng-show=\"showNav\"> <ul class=\"navigation\"> <li class=\"navigation\" id=\"nav-home\"> <a href=\"#/\"> <img class=\"logo\" src=\"images/logo.png\" alt=\"home\"> </a> </li> <li ng-repeat=\"page in pages\" class=\"navigation\" id=\"{{page.cssid}}\"> <a class=\"nav-link\" ng-attr-target=\"{{getTarget(page)}}\" ng-href=\"{{getHref(page)}}\"> <span ng-bind=\"page.name\"></span> </a> </li> </ul> <div class=\"fb-like\"><iframe src=\"//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2FAppendectomy&amp;width=90&amp;layout=button_count&amp;action=like&amp;show_faces=true&amp;share=false&amp;height=21&amp;appId=269617236509753\" scrolling=\"no\" frameborder=\"0\" style=\"border:none; overflow:hidden; width:90px; height:21px\" allowtransparency=\"true\"></iframe></div> </span> </div> <div ng-view=\"\"></div> </div> <div class=\"footer\"> Appendectomy Project 割闌尾計畫 © Copyright Appendectomy Project 2014 </div> <!-- Google Analytics: change UA-XXXXX-X to be your site's ID --> <script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-56312814-1');ga('require', 'displayfeatures');</script> <!--[if lt IE 9]><script src=\"scripts/oldieshim.a466b7b1.js\"></script><![endif]--> <script src=\"scripts/vendor.2b68f1a0.js\"></script> <script src=\"scripts/scripts.acdf9275.js\"></script> <script src=\"//www.parsecdn.com/js/parse-1.3.0.min.js\"></script> <script src=\"//fgnass.github.io/spin.js/spin.min.js\"></script> <script src=\"http://maps.google.com/maps/api/js?v=3.2&amp;sensor=false\"></script> <script src=\"bower_components/leaflet-plugins/layer/tile/Google.js\"></script>  ";
//    NSString *nssHtml = [NSString stringWithFormat:nssEmbedHTML, @"https://www.youtube.com/watch?feature=player_embedded&v=OtvbZscM90A", self.view.frame.size.width, self.view.frame.size.height];
    uiwWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    [uiwWebView loadHTMLString:nssEmbedHTML baseURL:nil];
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
