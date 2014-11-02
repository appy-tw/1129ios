//
//  MAPViewController.m
//  1129vday
//
//  Created by lololol on 29/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "MAPViewController.h"

#import "AppDelegate.h"

@interface MAPViewController ()
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

@implementation MAPViewController

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

- (void)setMyMapView {
    UIWebView *uiwvMap = [[UIWebView alloc]initWithFrame:CGRectMake(0.0, cgfAvailableHeight * 0.04 + cgfAvailableHeightStart, cgfAvailableWidth, cgfAvailableHeight)];
    [self.view addSubview:uiwvMap];
//    [uiwvMap loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mapsengine.google.com/map/viewer?mid=zIzWDsgdsP7k.kgKZUH6SEQhk"]]];
        [uiwvMap loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://1129vday.tw/official/#/"]]];
    [uiwvMap setScalesPageToFit:YES];
    [uiwvMap.scrollView setShowsHorizontalScrollIndicator:YES];
    [uiwvMap.scrollView setScrollEnabled:YES];
    [uiwvMap.scrollView setUserInteractionEnabled:YES];
//    uiwvMap.scrollView set
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMyScreenSize];
    [self setMyMapView];
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
