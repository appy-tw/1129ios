//
//  SUPViewController.m
//  1129vday
//
//  Created by lololol on 28/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "SUPViewController.h"
#import "AppDelegate.h"

@interface SUPViewController ()
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

@implementation SUPViewController


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

- (void)setImageAndButton {
    UIImageView *uiivMain =
    [[UIImageView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.03 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 1010.0 / 1393.0)];
    uiivMain.image = [UIImage imageNamed:@"supp_main"];
    [self.view addSubview:uiivMain];
    
    UIButton *uibTsai = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibTsai.frame = CGRectMake(cgfAvailableWidth * 0.19, cgfAvailableHeight * 0.40 + cgfAvailableHeightStart, cgfAvailableWidth * 0.13, cgfAvailableWidth * 0.13 * 173.0 / 176.0);
    [uibTsai addTarget:self action:@selector(uibClickedTsai) forControlEvents:UIControlEventTouchUpInside];
    uibTsai.tintColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    [self.view addSubview:uibTsai];
    
    UIButton *uibWu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibWu.frame = CGRectMake(cgfAvailableWidth * 0.436, cgfAvailableHeight * 0.40 + cgfAvailableHeightStart, cgfAvailableWidth * 0.13, cgfAvailableWidth * 0.13 * 173.0 / 176.0);
    [uibWu addTarget:self action:@selector(uibClickedWu) forControlEvents:UIControlEventTouchUpInside];
    uibWu.tintColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    [self.view addSubview:uibWu];

    UIButton *uibLin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibLin.frame = CGRectMake(cgfAvailableWidth * 0.698, cgfAvailableHeight * 0.40 + cgfAvailableHeightStart, cgfAvailableWidth * 0.13, cgfAvailableWidth * 0.13 * 173.0 / 176.0);
    [uibLin addTarget:self action:@selector(uibClickedLin) forControlEvents:UIControlEventTouchUpInside];
    uibLin.tintColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    [self.view addSubview:uibLin];

    UIImage *uiiGo = [UIImage imageNamed:@"supp_go"];
    [uibTsai setImage:uiiGo forState:UIControlStateNormal];
    [uibWu setImage:uiiGo forState:UIControlStateNormal];
    [uibLin setImage:uiiGo forState:UIControlStateNormal];
}

- (void)uibClickedTsai {
    NSLog(@"Tsai");
}

- (void)uibClickedWu {
    NSLog(@"Wu");
}

- (void)uibClickedLin {
    NSLog(@"Lin");
}

- (void)drawScreen {
    [self setMyScreenSize];
    [self setImageAndButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self drawScreen];
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
