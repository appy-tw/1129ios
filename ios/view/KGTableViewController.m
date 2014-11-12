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

#import "KeyHeader.h"

#import "BATTLEGROUNDViewController.h"

#import <Parse/Parse.h>

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
    
    NSString *nssDate;
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
    [self getAllInformationFromParse];
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nssIDKG1 = @"KG1";
    static NSString *nssIDKG2 = @"KG2";
    static NSString *nssIDKG3 = @"KG3";
    static NSString *nssIDKG4 = @"KG4";
    static NSString *nssIDKG5 = @"KG5";
    static NSString *nssIDKG6 = @"KG6";
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
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG5];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG5];
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
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDKG6];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDKG6];
            UILabel *uilDate = [[UILabel alloc]initWithFrame:CGRectMake(cgfScreenWidth * 0.04, cgfScreenWidth * 0.0 / 640, cgfScreenWidth * 0.92, cgfScreenWidth * 20 / 640)];
            uilDate.tag = 601;
            [uilDate setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:uilDate];
            [uilDate setText:@"abcde"];
        }
        UILabel *uilDate = (UILabel*)[cell.contentView viewWithTag:601];
        [uilDate setText:nssDate];
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
        return self.tableView.frame.size.width * 60 / 640;
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
    [nsmdPlistDictionary setValue:nssTPE4HP forKey:@"tpe4hp"];
    [nsmdPlistDictionary setValue:nssTPE4Man forKey:@"tpe4man"];
    [nsmdPlistDictionary setValue:nssTPE4Item forKey:@"tpe4item"];
    
    [nsmdPlistDictionary setValue:nssTPQ1HP forKey:@"tpq1hp"];
    [nsmdPlistDictionary setValue:nssTPQ1Man forKey:@"tpq1man"];
    [nsmdPlistDictionary setValue:nssTPQ1Item forKey:@"tpq1item"];
    
    [nsmdPlistDictionary setValue:nssTPQ6HP forKey:@"tpq6hp"];
    [nsmdPlistDictionary setValue:nssTPQ6Man forKey:@"tpq6man"];
    [nsmdPlistDictionary setValue:nssTPQ6Item forKey:@"tpq6item"];

    [nsmdPlistDictionary setValue:nssTaiwanMan forKey:@"taiwanman"];
    [nsmdPlistDictionary setValue:nssTaiwanItem forKey:@"taiwanitem"];
    
    [nsmdPlistDictionary setValue:nssDate forKey:@"date"];
    
    [nsmdPlistDictionary writeToFile:_nssPlistDst atomically:YES];
}

- (void)readAllFromMyPlist {
    if (_nssPlistDst == nil) {
        [self initMyPlist];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:_nssPlistDst];
    if (nsmdPlistDictionary != nil) {
        nssTPE4HP = [nsmdPlistDictionary objectForKeyedSubscript:@"tpe4hp"];
        nssTPE4Man = [nsmdPlistDictionary objectForKeyedSubscript:@"tpe4man"];
        nssTPE4Item = [nsmdPlistDictionary objectForKeyedSubscript:@"tpe4item"];
        
        nssTPQ1HP = [nsmdPlistDictionary objectForKeyedSubscript:@"tpq1hp"];
        nssTPQ1Man = [nsmdPlistDictionary objectForKeyedSubscript:@"tpq1man"];
        nssTPQ1Item = [nsmdPlistDictionary objectForKeyedSubscript:@"tpq1item"];

        nssTPQ6HP = [nsmdPlistDictionary objectForKeyedSubscript:@"tpq6hp"];
        nssTPQ6Man = [nsmdPlistDictionary objectForKeyedSubscript:@"tpq6man"];
        nssTPQ6Item = [nsmdPlistDictionary objectForKeyedSubscript:@"tpq6item"];

        nssTaiwanMan = [nsmdPlistDictionary objectForKeyedSubscript:@"taiwanman"];
        nssTaiwanItem = [nsmdPlistDictionary objectForKeyedSubscript:@"taiwanitem"];
        
        nssDate = [nsmdPlistDictionary objectForKeyedSubscript:@"date"];
    }
}

//]]Plist

//[[parse

- (void)getAllInformationFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"hp"];
    [query whereKey:@"available" equalTo:@"YES"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            if (objects.count != 0) {
                for (PFObject *object in objects) {
                    NSLog(@"%@", object.objectId);
                    
                    nssTPE4HP = object[@"tpe4hp"];
                    NSLog(@"object[tpe4hp]: %@", object[@"tpe4hp"]);
                    nssTPE4Man = object[@"tpe4man"];
                    NSLog(@"object[tpe4man]: %@", object[@"tpe4man"]);
                    nssTPE4Item = object[@"tpe4item"];
                    NSLog(@"object[tpe4item]: %@", object[@"tpe4item"]);

                    nssTPQ1HP = object[@"tpq1hp"];
                    NSLog(@"object[tpq1hp]: %@", object[@"tpq1hp"]);
                    nssTPQ1Man = object[@"tpq1man"];
                    NSLog(@"object[tpq1man]: %@", object[@"tpq1man"]);
                    nssTPQ1Item = object[@"tpq1item"];
                    NSLog(@"object[tpq1item]: %@", object[@"tpq1item"]);
                    
                    nssTPQ6HP = object[@"tpq6hp"];
                    NSLog(@"object[tpq6hp]: %@", object[@"tpq6hp"]);
                    nssTPQ6Man = object[@"tpq6man"];
                    NSLog(@"object[tpq6man]: %@", object[@"tpq6man"]);
                    nssTPQ6Item = object[@"tpq6item"];
                    NSLog(@"object[tpq6item]: %@", object[@"tpq6item"]);
                    
                    nssTaiwanMan = object[@"taiwanman"];
                    NSLog(@"object[taiwanman]: %@", object[@"taiwanman"]);
                    nssTaiwanItem = object[@"taiwanitem"];
                    NSLog(@"object[taiwanitem]: %@", object[@"taiwanitem"]);
                    
                    nssDate = object[@"nssDate"];
                    NSLog(@"object[date]: %@", object[@"date"]);
                    
                    NSLog(@"[self.tableView reloadData];");
                    [self writeToMyPlist];
                    [self.tableView reloadData];
                }
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self readAllFromMyPlist];
            [self.tableView reloadData];
        }
    }];
}

//]]parse


@end