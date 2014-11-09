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
    uilTitle.text = @"誰是公民 v ?";
    uilTitle.textColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    uilTitle.textAlignment = NSTextAlignmentCenter;
    [uilTitle setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:uilTitle];

    UITextView *uitvContent = [[UITextView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.65 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 600.0 / 1315.0)];
    uitvContent.text = @"人機不天人媽一拿的服，萬大成人放新合麗狀場轉！許一正，笑德間日呢集心起送始、思國放地；外回費十以詩驚，書火使：報界清難料一表新，課團此意式。黨資書回用除。新由那面期公年，公過說花規的和面地花的再。叫時要也展綠師合大事條帶理是老就。";
    // Don't need been editable
    uitvContent.editable = NO;

    [self.view addSubview:uitvContent];
    
    UIImageView *uiivTitleEnd =
    [[UIImageView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.88 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 56.0 / 1315.0)];
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
