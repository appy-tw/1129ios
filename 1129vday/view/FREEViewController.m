//
//  FREEViewController.m
//  1129vday
//
//  Created by lololol on 27/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "FREEViewController.h"
#import "AppDelegate.h"

@interface FREEViewController ()
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

@implementation FREEViewController


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
    [[UIImageView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.03 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 739.0 / 592.0)];
    uiivMain.image = [UIImage imageNamed:@"freep_background"];
    [self.view addSubview:uiivMain];
    
    UILabel *uilTitle = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.70 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 154.0 / 1315.0)];
    uilTitle.text = @"V 計畫自由罷免示範區";
    uilTitle.textColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    uilTitle.textAlignment = NSTextAlignmentCenter;
    [uilTitle setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:uilTitle];
    
    UITextView *uitvContent = [[UITextView alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.75 + cgfAvailableHeightStart, cgfAvailableWidth * 0.88, cgfAvailableWidth * 0.88 * 600.0 / 1315.0)];
    uitvContent.text = @"3月割闌尾計畫開始動刀，針對罷免呼聲最高的前三位立委：蔡正元、吳育昇、林鴻池進行罷免連署，目前也陸續在9/26、10/6、10/9 陸續完成第1階段2%的罷免門檻，現在我們宣布成立「自由罷免示範區」，呼籲民眾，民主不只有選舉權，罷免權也需要被執行。";
    uitvContent.backgroundColor = [UIColor clearColor];
    [self.view addSubview:uitvContent];
}

- (void)uibClickedTsai {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/pages/內湖南港割闌尾-正元手術房/320272928135607"]];
}

- (void)uibClickedWu {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/AppendectomyWEGO?fref=ts"]];
}

- (void)uibClickedLin {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/AppendectomyDeWhip?fref=ts"]];
}

- (void)uibClickedDragon {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/TotalRecall2014"]];
}

- (void)uibClickedHuang {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/apkh.tw"]];
}

- (void)uibClickedCountry {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/apkh.tw"]];
}

- (void)setButton {
    UIButton *uibTsai = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibTsai.frame = CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.09 + cgfAvailableHeightStart, cgfAvailableWidth * 0.78, cgfAvailableWidth * 0.88 * 154.0 / 1315.0);
    [uibTsai addTarget:self action:@selector(uibClickedTsai) forControlEvents:UIControlEventTouchUpInside];
    uibTsai.tintColor = [UIColor blackColor];
    [uibTsai setTitle:@"蔡正元選區：正元手術房" forState:UIControlStateNormal];
    [self.view addSubview:uibTsai];
    
    UIButton *uibWu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibWu.frame = CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.12 + cgfAvailableHeightStart, cgfAvailableWidth * 0.78, cgfAvailableWidth * 0.88 * 154.0 / 1315.0);
    [uibWu addTarget:self action:@selector(uibClickedWu) forControlEvents:UIControlEventTouchUpInside];
    uibWu.tintColor = [UIColor blackColor];
    [uibWu setTitle:@"吳育昇選區：海口夯社" forState:UIControlStateNormal];
    [self.view addSubview:uibWu];
    
    UIButton *uibLin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibLin.frame = CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.15 + cgfAvailableHeightStart, cgfAvailableWidth * 0.78, cgfAvailableWidth * 0.88 * 154.0 / 1315.0);
    [uibLin addTarget:self action:@selector(uibClickedLin) forControlEvents:UIControlEventTouchUpInside];
    uibLin.tintColor = [UIColor blackColor];
    [uibLin setTitle:@"吳育昇選區：海口夯社" forState:UIControlStateNormal];
    [self.view addSubview:uibLin];

    UIButton *uibDragon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibDragon.frame = CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.29 + cgfAvailableHeightStart, cgfAvailableWidth * 0.78, cgfAvailableWidth * 0.88 * 154.0 / 1315.0);
    [uibDragon addTarget:self action:@selector(uibClickedDragon) forControlEvents:UIControlEventTouchUpInside];
    uibDragon.tintColor = [UIColor blackColor];
    [uibDragon setTitle:@"蔡錦龍選區" forState:UIControlStateNormal];
    [self.view addSubview:uibDragon];

    UIButton *uibHuang = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibHuang.frame = CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.56 + cgfAvailableHeightStart, cgfAvailableWidth * 0.78, cgfAvailableWidth * 0.88 * 154.0 / 1315.0);
    [uibHuang addTarget:self action:@selector(uibClickedHuang) forControlEvents:UIControlEventTouchUpInside];
    uibHuang.tintColor = [UIColor blackColor];
    [uibHuang setTitle:@"黃昭順選區" forState:UIControlStateNormal];
    [self.view addSubview:uibHuang];

    UIButton *uibCountry = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibCountry.frame = CGRectMake(cgfAvailableWidth * 0.06, cgfAvailableHeight * 0.59 + cgfAvailableHeightStart, cgfAvailableWidth * 0.78, cgfAvailableWidth * 0.88 * 154.0 / 1315.0);
    [uibCountry addTarget:self action:@selector(uibClickedCountry) forControlEvents:UIControlEventTouchUpInside];
    uibCountry.tintColor = [UIColor blackColor];
    [uibCountry setTitle:@"林國正選區" forState:UIControlStateNormal];
    [self.view addSubview:uibCountry];

//    UIButton *uibLin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    uibLin.frame = CGRectMake(cgfAvailableWidth * 0.698, cgfAvailableHeight * 0.408 + cgfAvailableHeightStart, cgfAvailableWidth * 0.13, cgfAvailableWidth * 0.13 * 173.0 / 176.0);
//    [uibLin addTarget:self action:@selector(uibClickedLin) forControlEvents:UIControlEventTouchUpInside];
//    uibLin.tintColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
//    [self.view addSubview:uibLin];
    
//    UIImage *uiiGo = [UIImage imageNamed:@"supp_go"];
//    [uibTsai setImage:uiiGo forState:UIControlStateNormal];
//    [uibWu setImage:uiiGo forState:UIControlStateNormal];
//    [uibLin setImage:uiiGo forState:UIControlStateNormal];
}

- (void)drawScreen {
    [self setMyScreenSize];
    [self setImageAndLabel];
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
