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
    
    NSString *nssTPE4HP;
    NSString *nssTPE4Man;
    NSString *nssTPE4Item;
    
    NSString *nssTPQ1HP;
    NSString *nssTPQ1Man;
    NSString *nssTPQ1Item;
    
    NSString *nssTPQ6HP;
    NSString *nssTPQ6Man;
    NSString *nssTPQ6Item;
    
    NSString *nssTaiwanMan;
    NSString *nssTaiwanItem;
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

- (void)prepareTable {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setMyScreenSize];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self makeKeyboardOffset];
    [self prepareTable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
        UIView *uivHP = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 50.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivHP.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivHP.layer.borderWidth = 2.0;
        [uivHP setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivHP.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivHP];
        UIView *uivMan = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 142.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivMan.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivMan.layer.borderWidth = 2.0;
        [uivMan setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivMan.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivMan];
        UIView *uivItem = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 238.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivItem.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivItem.layer.borderWidth = 2.0;
        [uivItem setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivItem.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivItem];
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG3];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg3"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
        UIView *uivHP = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 50.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivHP.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivHP.layer.borderWidth = 2.0;
        [uivHP setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivHP.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivHP];
        UIView *uivMan = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 142.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivMan.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivMan.layer.borderWidth = 2.0;
        [uivMan setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivMan.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivMan];
        UIView *uivItem = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 238.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivItem.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivItem.layer.borderWidth = 2.0;
        [uivItem setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivItem.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivItem];
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG4];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg4"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
        UIView *uivHP = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 50.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivHP.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivHP.layer.borderWidth = 2.0;
        [uivHP setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivHP.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivHP];
        UIView *uivMan = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 142.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivMan.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivMan.layer.borderWidth = 2.0;
        [uivMan setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivMan.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivMan];
        UIView *uivItem = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 238.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivItem.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivItem.layer.borderWidth = 2.0;
        [uivItem setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivItem.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivItem];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG5];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG5];
        }
        UIImage *uiim = [UIImage imageNamed:@"kg5"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
        UIView *uivMan = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 142.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivMan.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivMan.layer.borderWidth = 2.0;
        [uivMan setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivMan.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivMan];
        UIView *uivItem = [[UIView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 320.0 / 640.0, cgfScreenWidth * 238.0 / 640.0, cgfScreenWidth * 283.0 / 640.0, cgfScreenWidth * 32.0 / 640.0)];
        uivItem.layer.borderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.24 alpha:1.0].CGColor;
        uivItem.layer.borderWidth = 2.0;
        [uivItem setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        uivItem.layer.cornerRadius = 4;
        [cell.contentView addSubview:uivItem];
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

//[[Plist

- (void)initMyPlist
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistSrc = [[NSBundle mainBundle] pathForResource:@"kg" ofType:@"plist"];
    _nssPlistDst = [NSString stringWithFormat:@"%@/Documents/kg.plist", NSHomeDirectory()];
    if (! [nsfmPlistFileManager fileExistsAtPath:_nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:nssPlistSrc toPath:_nssPlistDst error:nil];
    }
}

- (void)writeToMyPlist
{
    if (_nssPlistDst == nil) {
        [self initMyPlist];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:_nssPlistDst];
    [nsmdPlistDictionary setValue:nssTPE4HP forKey:@"TPE-4hp"];
    [nsmdPlistDictionary setValue:nssTPE4Man forKey:@"TPE-4man"];
    [nsmdPlistDictionary setValue:nssTPE4Item forKey:@"TPE-4item"];
    
    [nsmdPlistDictionary setValue:nssTPQ1HP forKey:@"TPQ-1hp"];
    [nsmdPlistDictionary setValue:nssTPQ1Man forKey:@"TPQ-1man"];
    [nsmdPlistDictionary setValue:nssTPQ1Item forKey:@"TPQ-1item"];
    
    [nsmdPlistDictionary setValue:nssTPQ6HP forKey:@"TPQ-6hp"];
    [nsmdPlistDictionary setValue:nssTPQ6Man forKey:@"TPQ-6man"];
    [nsmdPlistDictionary setValue:nssTPQ6Item forKey:@"TPQ-6item"];

    [nsmdPlistDictionary setValue:nssTaiwanMan forKey:@"taiwanman"];
    [nsmdPlistDictionary setValue:nssTaiwanItem forKey:@"taiwanitem"];
    [nsmdPlistDictionary writeToFile:_nssPlistDst atomically:YES];
}

- (void)readAllFromMyPlist {
    if (_nssPlistDst == nil) {
        [self initMyPlist];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:_nssPlistDst];
    if (nsmdPlistDictionary != nil) {
        nssTPE4HP = [nsmdPlistDictionary objectForKeyedSubscript:@"TPE-4hp"];
        nssTPE4Man = [nsmdPlistDictionary objectForKeyedSubscript:@"TPE-4man"];
        nssTPE4Item = [nsmdPlistDictionary objectForKeyedSubscript:@"TPE-4item"];
        
        nssTPQ1HP = [nsmdPlistDictionary objectForKeyedSubscript:@"TPQ-1hp"];
        nssTPQ1Man = [nsmdPlistDictionary objectForKeyedSubscript:@"TPQ-1man"];
        nssTPQ1Item = [nsmdPlistDictionary objectForKeyedSubscript:@"TPQ-1item"];

        nssTPQ6HP = [nsmdPlistDictionary objectForKeyedSubscript:@"TPQ-6hp"];
        nssTPQ6Man = [nsmdPlistDictionary objectForKeyedSubscript:@"TPQ-6man"];
        nssTPQ6Item = [nsmdPlistDictionary objectForKeyedSubscript:@"TPQ-6item"];

        nssTaiwanMan = [nsmdPlistDictionary objectForKeyedSubscript:@"taiwanman"];
        nssTaiwanItem = [nsmdPlistDictionary objectForKeyedSubscript:@"taiwanitem"];
    }
}

//]]Plist

@end