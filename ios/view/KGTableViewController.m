//
//  KGTableViewController.m
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "KGTableViewController.h"
#import "AppDelegate.h"

#import "BATTLEGROUNDViewController.h"

@interface KGTableViewController ()
{
    CGFloat cgfW;
    
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    
    CGFloat cgfHigh0;
    CGFloat cgfHigh1;
    CGFloat cgfHigh2;
    CGFloat cgfHigh3;
    
    AppDelegate *delegate;
}

@end

@implementation KGTableViewController

- (void)setMyScreen
{
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
}

- (void)setImage {
    
}

- (void) makeKeyboardOffset {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
    [UIView commitAnimations];
}

- (void) makeKeyboardOffsetBack {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y);
    [UIView commitAnimations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyScreen];
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

- (void)setButton:(UITableViewCell *)cell offset:(CGFloat)cgfBaseHeight {
    UIButton *uibTsai = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibTsai.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibTsai.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.14 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibTsai addTarget:self action:@selector(uibClickedTsai) forControlEvents:UIControlEventTouchUpInside];
    uibTsai.tintColor = [UIColor blackColor];
    [uibTsai setTitle:@"蔡正元選區：正元手術房" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibTsai];
    
    UIButton *uibWu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibWu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibWu.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.21 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibWu addTarget:self action:@selector(uibClickedWu) forControlEvents:UIControlEventTouchUpInside];
    uibWu.tintColor = [UIColor blackColor];
    [uibWu setTitle:@"吳育昇選區：海口夯社" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibWu];
    
    UIButton *uibLin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibLin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibLin.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.28 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibLin addTarget:self action:@selector(uibClickedLin) forControlEvents:UIControlEventTouchUpInside];
    uibLin.tintColor = [UIColor blackColor];
    [uibLin setTitle:@"林鴻池選區：板橋手術中" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibLin];
    
    UIButton *uibDragon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibDragon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibDragon.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.46 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibDragon addTarget:self action:@selector(uibClickedDragon) forControlEvents:UIControlEventTouchUpInside];
    uibDragon.tintColor = [UIColor blackColor];
    [uibDragon setTitle:@"蔡錦龍選區" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibDragon];
    
    UIButton *uibHuang = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibHuang.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibHuang.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.90 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibHuang addTarget:self action:@selector(uibClickedHuang) forControlEvents:UIControlEventTouchUpInside];
    uibHuang.tintColor = [UIColor blackColor];
    [uibHuang setTitle:@"黃昭順選區" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibHuang];
    
    UIButton *uibCountry = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibCountry.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.97 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibCountry addTarget:self action:@selector(uibClickedCountry) forControlEvents:UIControlEventTouchUpInside];
    uibCountry.tintColor = [UIColor blackColor];
    [uibCountry setTitle:@"林國正選區" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibCountry];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((long)indexPath.row == 1) {
        NSLog(@"%ld", (long)indexPath.row);
        [delegate.navigationController setNavigationBarHidden:NO animated:NO];
        [self makeKeyboardOffsetBack];
        [delegate.navigationController pushViewController:[BATTLEGROUNDViewController new] animated:NO];
    }
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
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, cgfScreenHeightBase, self.tableView.frame.size.width, self.tableView.frame.size.width * 90 / 640)];
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
        return cgfScreenHeightBase + self.tableView.frame.size.width * 90 / 640 + 20.0;
    } else if (indexPath.row == 1) {
        return self.tableView.frame.size.width * 418 / 640;
    } else if (indexPath.row == 2) {
        return self.tableView.frame.size.width * 418 / 640;
    } else if (indexPath.row == 3) {
        return self.tableView.frame.size.width * 418 / 640;
    } else if (indexPath.row == 4) {
        return self.tableView.frame.size.width * 418 / 640 + 60;
    } else {
        return self.tableView.frame.size.width * 418 / 640 + 80;
    }
}

@end