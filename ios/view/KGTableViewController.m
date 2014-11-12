//
//  KGTableViewController.m
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "KGTableViewController.h"
#import "AppDelegate.h"

#import "KGViewController.h"

#import "BATTLEGROUNDViewController.h"

@interface KGTableViewController ()
{
    CGFloat cgfW;
    
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    CGFloat cgfKeyboardOffset;
    
    CGFloat cgfHigh0;
    CGFloat cgfHigh1;
    CGFloat cgfHigh2;
    CGFloat cgfHigh3;
    
    AppDelegate *delegate;
}

@end

@implementation KGTableViewController

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"delegate.nssKGLink: %ld", (long)indexPath.row);
    delegate.nssKGLink = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self makeKeyboardOffsetBack];
    [self.navigationController pushViewController:[KGViewController new] animated:YES];
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

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setMyScreenSize];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self makeKeyboardOffset];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)uibClickedTsai {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/pages/內湖南港割闌尾-正元手術房/320272928135607"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/320272928135607"]];
}

- (void)uibClickedWu {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/AppendectomyWEGO?fref=ts"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/804848699526673"]];
}

- (void)uibClickedLin {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/AppendectomyDeWhip?fref=ts"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/602996456475061"]];
}

- (void)uibClickedDragon {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/TotalRecall2014"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/620780968013532"]];
}

- (void)uibClickedHuang {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/apkh.tw"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/337299219755438"]];
}

- (void)uibClickedCountry {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/apkh.tw"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/337299219755438"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nssIDKG1 = @"KG1";
    static NSString *nssIDKG2 = @"KG2";
    static NSString *nssIDKG3 = @"KG3";
    static NSString *nssIDKG4 = @"KG4";
    static NSString *nssIDKG5 = @"KG5";
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG1];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg1"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 90 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG2];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg2"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG3];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg3"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG4];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg4"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG5];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG5];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg5"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.tableView.frame.size.width * 90 / 640 + 20.0;
    } else if (indexPath.row == 1) {
        return self.tableView.frame.size.width * 418 / 640;
    } else if (indexPath.row == 2) {
        return self.tableView.frame.size.width * 418 / 640;
    } else if (indexPath.row == 3) {
        return self.tableView.frame.size.width * 418 / 640;
    } else if (indexPath.row == 4) {
        return self.tableView.frame.size.width * 418 / 640;
    } else {
        return self.tableView.frame.size.width * 418 / 640;
    }
}

@end