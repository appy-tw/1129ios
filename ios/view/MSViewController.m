//
//  IntroViewController.m
//  1129vday
//
//  Created by lololol on 26/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "MSViewController.h"
#import "AppDelegate.h"

@interface MSViewController ()
{
    CGFloat cgfAvailableWidth;
    CGFloat cgfAvailableHeight;
    CGFloat cgfAvailableHeightStart;
    CGFloat cgfAvailableHeightEnd;
    
    CGFloat cgfStatusBarHeight;
    CGFloat cgfNavigationBarHeight;
    CGFloat cgfTabBarHeight;
    
    
    AppDelegate *delegate;
}

@end

@implementation MSViewController

- (void)embedYouTube:(NSString *)nssUrlString frame:(CGRect)cgrRrame {
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
    NSString *nssHtml = [NSString stringWithFormat:nssEmbedHTML, nssUrlString, cgrRrame.size.width, cgrRrame.size.height];
    UIWebView *uiwVideoView = [[UIWebView alloc] initWithFrame:cgrRrame];
    [uiwVideoView loadHTMLString:nssHtml baseURL:nil];
    [self.view addSubview:uiwVideoView];
}

- (void)setMyScreenSize
{
    cgfStatusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    cgfNavigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    cgfTabBarHeight = [[[self tabBarController]tabBar]bounds].size.height;
    
    cgfAvailableHeight = [[UIScreen mainScreen] bounds].size.height - cgfStatusBarHeight - cgfTabBarHeight - cgfNavigationBarHeight;
    cgfAvailableWidth = [[UIScreen mainScreen] bounds].size.width;
    
    cgfAvailableHeightStart = cgfStatusBarHeight + cgfNavigationBarHeight;
    cgfAvailableHeightEnd = cgfAvailableHeight - cgfTabBarHeight;

    NSLog(@"AvailableScreen:%fx%f",cgfAvailableWidth,cgfAvailableHeight);
    NSLog(@"Available High:%f-%f",cgfAvailableHeightStart,cgfAvailableHeightEnd);
}

- (void)setImageAndLabel {
    UIImageView *uiivMain =
    [[UIImageView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.03 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 76.0 / 1000.0)];
    uiivMain.image = [UIImage imageNamed:@"msp_main"];
    [self.view addSubview:uiivMain];
    
    UIImageView *uiivTitle =
    [[UIImageView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.53 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 154.0 / 1315.0)];
    uiivTitle.image = [UIImage imageNamed:@"msp_title"];
    [self.view addSubview:uiivTitle];

    UILabel *uilTitle = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.60 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 154.0 / 1315.0)];
    uilTitle.text = @"誰是公民 V ?";
    uilTitle.textColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    uilTitle.textAlignment = NSTextAlignmentCenter;
    [uilTitle setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:uilTitle];

    UITextView *uitvContent = [[UITextView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.65 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 600.0 / 1315.0)];
    uitvContent.text = @"這是一場全民覺醒的運動，超越了議會，從家庭、從巷口、從網路，從社會的各個角落開始綻放，罷免不再是瀕死的法條，而是活著的行動。割去發炎的「闌尾」，從體制內去影響、去改變現今有缺陷的代議制度，讓我們一起締造台灣新型態的社會運動。不論你是想擔任當天擺攤志工、物資提供或純粹想要鍵盤參戰，亦或是您想要長期熱情參與，你都可以成為割闌尾V計劃的公民V，";
    [self.view addSubview:uitvContent];
    
    UIImageView *uiivTitleEnd =
    [[UIImageView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.92 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 56.0 / 1315.0)];
    uiivTitleEnd.image = [UIImage imageNamed:@"msp_title_end"];
    [self.view addSubview:uiivTitleEnd];
}

- (void)drawScreen {
    [self setMyScreenSize];
    [self setImageAndLabel];
//    [self setButton];
    [self embedYouTube:@"https://www.youtube.com/watch?feature=player_embedded&v=OtvbZscM90A" frame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.13 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 9.0 / 16.0)];
//    http://www.youtube.com/watch?feature=player_embedded&v=OtvbZscM90A
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self drawScreen];
//    [self embedYouTube:@"http://www.youtube.com/watch?v=l3Iwh5hqbyE" frame:CGRectMake(20, 20, 100, 100)];
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

@end
