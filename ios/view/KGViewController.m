//
//  KGViewController.m
//  ios
//
//  Created by lololol on 12/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "KGViewController.h"
#import "AppDelegate.h"

@interface KGViewController ()
{
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    CGFloat cgfKeyboardOffset;
    
    AppDelegate *delegate;
    NSString *nssContent;
    
    UIWebView *uiwvKG;
    NSURL *nsURL;
}

@end

@implementation KGViewController

- (void)setMyScreenSize
{
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([UIApplication sharedApplication].statusBarFrame.size.height == 20.0) {
        //without Hotspot: 64
        cgfKeyboardOffset =  cgfScreenHeightBase;
    } else {
        //with Hotspot: 104
        cgfKeyboardOffset = cgfScreenHeightBase + [UIApplication sharedApplication].statusBarFrame.size.height / 2.0;
    }
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f, keyboardOffset: %f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height, cgfKeyboardOffset);
}

- (void) makeKeyboardOffset {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - cgfKeyboardOffset);
    [UIView commitAnimations];
}

- (void) makeKeyboardOffsetBack {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y);
    [UIView commitAnimations];
}

- (void)setURL{
    NSLog(@"delegate.nssKGLink: %@", delegate.nssKGLink);
    if ([delegate.nssKGLink isEqualToString:@"1"] == YES) {
        nsURL = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPE-4"];
        NSLog(@"delegate.nssKGLink == 1, url: %@", nsURL);
    } else if ([delegate.nssKGLink isEqualToString:@"2"] == YES) {
        nsURL = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPQ-6"];
        NSLog(@"delegate.nssKGLink == 2, url: %@", nsURL);
    } else if ([delegate.nssKGLink isEqualToString:@"3"] == YES) {
        nsURL = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPQ-1"];
        NSLog(@"delegate.nssKGLink == 3, url: %@", nsURL);
    } else if ([delegate.nssKGLink isEqualToString:@"4"] == YES) {
        nsURL = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPE-4"];
        NSLog(@"delegate.nssKGLink == 4, url: %@", nsURL);
    }
    NSLog(@"Got KG from url");
}

//- (void)downloadFile{
//    NSLog(@"delegate.nssKGLink: %@", delegate.nssKGLink);
//    NSURL *url;
//    if ([delegate.nssKGLink isEqualToString:@"1"] == YES) {
//        url = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPE-4"];
//        NSLog(@"delegate.nssKGLink == 1, url: %@", url);
//    } else if ([delegate.nssKGLink isEqualToString:@"2"] == YES) {
//        url = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPQ-6"];
//        NSLog(@"delegate.nssKGLink == 2, url: %@", url);
//    } else if ([delegate.nssKGLink isEqualToString:@"3"] == YES) {
//        url = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPQ-1"];
//        NSLog(@"delegate.nssKGLink == 3, url: %@", url);
//    } else if ([delegate.nssKGLink isEqualToString:@"4"] == YES) {
//        url = [NSURL URLWithString:@"http://1129vday.tw/#/mission/TPE-4"];
//        NSLog(@"delegate.nssKGLink == 4, url: %@", url);
//    }
//    NSLog(@"Got KG from url");
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSOperationQueue *queue = [NSOperationQueue new];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if ([data length] > 0 && connectionError == nil) {
//            nssContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"Content: %@", nssContent);
//            nssContent =
//            [[@"<html><head><!-- Latest compiled and minified CSS --><link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css\"><style type=\"text/css\"> body { margin: auto; width: 320px;} img { margin: auto; width: 320px;}</style></head><body>" stringByAppendingString:[[[[nssContent componentsSeparatedByString:@"<section class=\"post\">"] objectAtIndex:1] componentsSeparatedByString:@"<section class=\"attribution-tags clearfix\">" ] objectAtIndex:0] ] stringByAppendingString: @"</section></body></html>"];
//            [uiwvKG loadHTMLString:nssContent baseURL:nil];
//        } else {
//            NSLog(@"Download url error: %@", connectionError);
//            UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"網路連線失敗" message:@"很抱歉，因網路連線因素，無法取得文章。請確認您的iOS網路設定。" delegate:nil cancelButtonTitle:@"確認" otherButtonTitles: nil];
//            [errorAlert show];
//        }
//    }];
//}

//- (void)webViewDidStartLoad:(UIWebView *)webView; {
//    NSLog(@"- (void)webViewDidStartLoad:(UIWebView *)webView");
//    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "var paras = document.getElementsByClassName('header');"
//     "while(paras[0]) {paras[0].parentNode.removeChild(paras[0]);}"
//     "var thefooter = document.getElementsByClassName('footer');"
//     "while(thefooter[0]) {thefooter[0].parentNode.removeChild(thefooter[0]);}"
//     "var textcenter = document.getElementsByClassName('textcenter');"
//     "while(textcenter[0]) {textcenter[0].parentNode.removeChild(textcenter[0]);}"
//     "var h3remove = document.getElementsByTagName('h3');"
//     "while(h3remove[0]) {h3remove[0].parentNode.removeChild(h3remove[0]);}"
//     "var mission_table = document.getElementsByClassName('mission_table');"
//     "while(mission_table[0]) {mission_table[0].parentNode.removeChild(mission_table[0]);}"
//     "var main-container = document.getElementsByClassName('main-container');"
//     "while(main-container[0]) {main-container[0].parentNode.removeChild(main-container[0]);}"
//     //     "var maincontainer = document.getElementById('main-container').style.width = '100%';"
//     "var mission_map_container = document.getElementById('mission_map_container');"
//     //     "mission_map_container.style.width = '95%';"
//     "mission_map_container.style.minWidth = \"300px\";"
//     "mission_map_container.style.maxWidth = \"300px\";"
//     ];
//    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"- (void)webViewDidFinishLoad:(UIWebView *)webView");
    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "var paras = document.getElementsByClassName('header');"
     "while(paras[0]) {paras[0].parentNode.removeChild(paras[0]);}"
     "var thefooter = document.getElementsByClassName('footer');"
     "while(thefooter[0]) {thefooter[0].parentNode.removeChild(thefooter[0]);}"
//     "var textcenter = document.getElementsByClassName('textcenter');"
//     "while(textcenter[0]) {textcenter[0].parentNode.removeChild(textcenter[0]);}"
//     "var h3remove = document.getElementsByTagName('h3');"
//     "while(h3remove[0]) {h3remove[0].parentNode.removeChild(h3remove[0]);}"
//     "var mission_table = document.getElementsByClassName('mission_table');"
//     "while(mission_table[0]) {mission_table[0].parentNode.removeChild(mission_table[0]);}"
//     "var maincontainer = document.getElementsByClassName('main-container');"
//     "while(maincontainer[0]) {maincontainer[0].parentNode.removeChild(maincontainer[0]);}"
//     "var maincontainer = document.getElementById('main-container').style.width = '100%';"
     "var mission_map_container = document.getElementById('mission_map_container');"
//     "mission_map_container.style.width = '95%';"
     "mission_map_container.style.minWidth = \"300px\";"
     "mission_map_container.style.maxWidth = \"300px\";"
];
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
}

- (void)setWebView {
    uiwvKG = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, cgfScreenWidth, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height )];
    [uiwvKG setDelegate:self];
    [self setURL];
    NSLog(@"%@", delegate.nssKGLink);
    [self.view addSubview:uiwvKG];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
    [uiwvKG loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setMyScreenSize];
    [self makeKeyboardOffset];
    [self setWebView];
    // Do any additional setup after loading the view.
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
