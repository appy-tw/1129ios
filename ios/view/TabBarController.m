//
//  TabBarController.m
//  1129vday
//
//  Created by lololol on 26/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)setMyFrame
{
    cgrFrame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 120);
    uivTabBarView = [[UIView alloc] initWithFrame:cgrFrame];
    //    [uivTabBarView setBackgroundColor:[UIColor colorWithRed:0.11 green:0.6 blue:0.65 alpha:1]];
    uiiTabBarBackground = [UIImage imageNamed:@"TabBar"];
    [[UITabBar appearance] setBackgroundImage:uiiTabBarBackground];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [self.tabBarController.tabBar setBackgroundImage:uiiTabBarBackground];
}

- (void)setMyOldTabBarItem
{
    //set the tab bar title appearance for normal state
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f], NSForegroundColorAttributeName : [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0]} forState:UIControlStateSelected];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f], NSForegroundColorAttributeName : [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]} forState:UIControlStateNormal];
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    [UITabBar appearance].tintColor = [UIColor redColor];
}

- (void)setMyTabBarItem
{
    //set the tab bar title appearance for normal state
//    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:13.5f], NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]} forState:UIControlStateSelected];
    
    //    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:13.5f], NSForegroundColorAttributeName : [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1.0]} forState:UIControlStateNormal];
//    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:13.5f], NSForegroundColorAttributeName : [UIColor colorWithRed:0.68 green:0.68 blue:0.68 alpha:1.0]} forState:UIControlStateNormal];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [UITabBar appearance].tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    
    UIImage *redBackground = [UIImage imageNamed:@"red_selected"];
    [[UITabBar appearance] setSelectionIndicatorImage:redBackground];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMyFrame];
    [self setMyTabBarItem];
    [[self tabBar] addSubview:uivTabBarView];
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
