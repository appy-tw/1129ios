//
//  BLOGViewController.m
//  ios
//
//  Created by lololol on 12/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "BLOGViewController.h"
#import "AppDelegate.h"
#import "KeyHeader.h"

#import <Parse/Parse.h>

@interface BLOGViewController ()
{
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    CGFloat cgfKeyboardOffset;
    
    AppDelegate *delegate;
    NSString *nssContent;
    
    UIWebView *uiwvBlog;
}

@end

@implementation BLOGViewController

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

- (void)downloadFile{
    NSURL *url = [NSURL URLWithString:delegate.nssBLOGLink];
    NSLog(@"Got BLOG from url");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            nssContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Content: %@", nssContent);
            nssContent =
               [[@"<html><head><!-- Latest compiled and minified CSS --><link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css\"><style type=\"text/css\"> body { margin: auto; width: 320px;} img { margin: auto; width: 320px;}</style></head><body>" stringByAppendingString:[[[[nssContent componentsSeparatedByString:@"<section class=\"post\">"] objectAtIndex:1] componentsSeparatedByString:@"<section class=\"attribution-tags clearfix\">" ] objectAtIndex:0] ] stringByAppendingString: @"</section></body></html>"];
            [uiwvBlog loadHTMLString:nssContent baseURL:nil];
        } else {
            NSLog(@"Download url error: %@", connectionError);
            UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"網路連線失敗" message:@"很抱歉，因網路連線因素，無法取得文章。請確認您的iOS網路設定。" delegate:nil cancelButtonTitle:@"確認" otherButtonTitles: nil];
            [errorAlert show];
        }
    }];
}

- (void)setWebView {
    uiwvBlog = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, cgfScreenWidth, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height )];
    [self downloadFile];
    NSLog(@"%@", delegate.nssBLOGLink);
    [self.view addSubview:uiwvBlog];
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
