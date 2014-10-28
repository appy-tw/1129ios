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

- (void)setImage {
    UIImageView *uiivMain =
    [[UIImageView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.03 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 1010.0 / 1393.0)];
    uiivMain.image = [UIImage imageNamed:@"supp_main"];
    
    [self.view addSubview:uiivMain];
}

- (void)uibClicked {
    
}

- (void)setButton {
    UIButton *uibTsai = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibTsai.frame = CGRectMake(0, self.view.frame.size.height - 65, 160,65);
    [uibTsai addTarget:self action:@selector(uibClicked) forControlEvents:UIControlEventTouchUpInside];
    uibTsai.tintColor = [UIColor blackColor];
    [self.view addSubview:uibTsai];
    
    UIImage *uiiButtonTsai = [UIImage imageNamed:@""];
    [uibTsai setImage:uiiButtonTsai forState:UIControlStateNormal];
}

- (void)drawScreen {
    [self setMyScreenSize];
    [self setImage];
    [self setButton];
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
