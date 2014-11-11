//
//  ATTTableViewController.m
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "ATTTableViewController.h"
#import "AppDelegate.h"
#import "KeyHeader.h"

#import <Parse/Parse.h>


@interface ATTTableViewController () <FBLoginViewDelegate>
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
    
    UIImage* uiiATT1;
    UIImage* uiiATT2;
    UIImage* uiiATT3;
    UIImage* uiiATT4;
    UIImage* uiiATT6;
    
    FBLoginView *fbLoginView;
    UIImage *uiiFBImage;
    UILabel *uilFBUserName;
    
    NSString *nssName;
    NSString *nssFid;
    NSString *nssAddress;
    NSString *nssLat;
    NSString *nssLon;
    NSString *nssPoint;
    NSString *nssCounty;
    NSString *nssPoll;
    NSString *nssInfo;
    NSString *nssInfoURL;
    NSString *nssVersion;
    
    NSString *nssResourceBoard;
    NSString *nssResourceChair;
    NSString *nssResourceDesk;
    NSString *nssResourceOthers;
    NSString *nssResourcePen;
    NSString *nssResourceUmbrella;
    NSString *nssResourceWater;
    NSString *nssIOSToken;
    NSString *nssIOSToken1;
    NSString *nssIOSToken2;
    NSString *nssIOSToken3;
}
@end

@implementation ATTTableViewController

- (void)setMyScreen
{
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - delegate.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([UIApplication sharedApplication].statusBarFrame.size.height == 20.0) {
        //without Hotspot: 64
        cgfKeyboardOffset =  cgfScreenHeightBase;
    } else {
        //with Hotspot: 104
        cgfKeyboardOffset = cgfScreenHeightBase + [UIApplication sharedApplication].statusBarFrame.size.height / 2.0;
    }
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f, keyboardOffset: %f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, delegate.navigationController.navigationBar.frame.size.height, cgfKeyboardOffset);
}

- (void)setImage {
    uiiATT1 = [UIImage imageNamed:@"att1"];
    uiiATT2 = [UIImage imageNamed:@"att2"];
    uiiATT3 = [UIImage imageNamed:@"att3"];
    uiiATT4 = [UIImage imageNamed:@"att4"];
    uiiATT6 = [UIImage imageNamed:@"att6"];
}

- (void)setFBView {
    uilFBUserName = [[UILabel alloc]initWithFrame:CGRectMake(cgfScreenWidth * 0.58, 410.0 * cgfScreenWidth / 640.0 * 0.85, cgfScreenWidth * 0.40, 30.0)];
    fbLoginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]];
    
    fbLoginView.frame = CGRectOffset(fbLoginView.frame, cgfScreenWidth / 12.0, 0);
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        fbLoginView.frame = CGRectOffset(fbLoginView.frame, cgfScreenWidth / 12.0, 0);
    }
#endif
#endif
#endif
    fbLoginView.delegate = self;
    
    [self.view addSubview:fbLoginView];
    [fbLoginView sizeToFit];
}

- (void)viewDidLoad {
    [self setMyScreen];
    nssIOSToken = delegate.nssDeviceToken;
    NSLog(@"delegate.nssDeviceToken: %@", delegate.nssDeviceToken);
    NSLog(@"cgfScreenWidth * 0.58: %f", cgfScreenWidth * 0.58);
    _fbProfilePic = [[FBProfilePictureView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 402 / 640 -1, cgfScreenWidth * 98 / 640 - 1, 200 * cgfScreenWidth / 640 + 2, 200 * cgfScreenWidth / 640 + 2)];
    [_fbProfilePic.layer setCornerRadius:50.0f];
    [super viewDidLoad];
    [self setImage];
    [self setFBView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nssIDATT1 = @"ATT1";
    static NSString *nssIDATT2 = @"ATT2";
    static NSString *nssIDATT3 = @"ATT3";
    static NSString *nssIDATT4 = @"ATT4";
    static NSString *nssIDATT5 = @"ATT5";
    static NSString *nssIDATT6 = @"ATT6";
    static NSString *nssIDATT7 = @"ATT7";
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDATT1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDATT1];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, cgfScreenHeightBase, self.tableView.frame.size.width, self.tableView.frame.size.width * 90 / 640)];
        uiimv.image = uiiATT1;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDATT3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDATT3];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 410 / 640)];
        uiimv.image = uiiATT2;
        [cell.contentView addSubview:uiimv];
        [uilFBUserName setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:uilFBUserName];
        [cell.contentView addSubview:_fbProfilePic];
        //蔡吳林的圖
        UIImageView *uiimvTsaiWuLin = [[UIImageView alloc] initWithFrame:CGRectMake(cgfScreenWidth * 32.0 / 640.0, cgfScreenWidth * 87.0 / 640.0, cgfScreenWidth * 217.0 / 640.0, cgfScreenWidth * 217.0 / 640.0)];
        [uiimvTsaiWuLin setImage:[UIImage imageNamed:@"none"]];
        [cell.contentView addSubview:uiimvTsaiWuLin];
        UILabel *uilTsaiWuLin = [[UILabel alloc]initWithFrame:CGRectMake(cgfScreenWidth * 32.0 / 640.0, 410.0 * cgfScreenWidth / 640.0 * 0.85, cgfScreenWidth * 217.0 / 640.0, 30.0)];
        [uilTsaiWuLin setText:@"任務尚未登入"];
        [uilTsaiWuLin setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:uilTsaiWuLin];
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDATT2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDATT2];
        }
        fbLoginView.center = cell.contentView.center;
        [cell.contentView addSubview:fbLoginView];
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDATT2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDATT2];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 40 / 640, 0.0, self.tableView.frame.size.width * 83 / 640, self.tableView.frame.size.width * 95 / 640)];
        uiimv.image = uiiATT3;
        [cell.contentView addSubview:uiimv];
        UILabel *uilLocationName = [[UILabel alloc]initWithFrame:CGRectMake(cgfScreenWidth * 141.0 / 640.0, 5.0 * cgfScreenWidth / 640.0, cgfScreenWidth * 0.40, 15.0)];
        [uilLocationName setText:@"地點尚未登入"];
        [cell.contentView addSubview:uilLocationName];
        UILabel *uilAddress = [[UILabel alloc]initWithFrame:CGRectMake(cgfScreenWidth * 141.0 / 640.0, 55.0 * cgfScreenWidth / 640.0, cgfScreenWidth * 0.76, 15.0)];
        [uilAddress setText:@"地址尚未登入"];
        [cell.contentView addSubview:uilAddress];
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDATT4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDATT4];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.2867, 0.0, self.tableView.frame.size.width * 273.0 / 640.0, self.tableView.frame.size.width * 78 / 640)];
        uiimv.image = uiiATT4;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDATT2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDATT2];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 40 / 640, 0.0, self.tableView.frame.size.width * 83 / 640, self.tableView.frame.size.width * 95 / 640)];
        uiimv.image = [UIImage imageNamed:@"att5-1"];
        [cell.contentView addSubview:uiimv];
        UILabel *uilLocationNameForItem = [[UILabel alloc]initWithFrame:CGRectMake(cgfScreenWidth * 141.0 / 640.0, 5.0 * cgfScreenWidth / 640.0, cgfScreenWidth * 0.40, 15.0)];
        [uilLocationNameForItem setText:@"目前無物資據點"];
        [cell.contentView addSubview:uilLocationNameForItem];
        UILabel *uilItemName = [[UILabel alloc]initWithFrame:CGRectMake(cgfScreenWidth * 141.0 / 640.0, 55.0 * cgfScreenWidth / 640.0, cgfScreenWidth * 0.76, 15.0)];
        [uilItemName setText:@"無前無物資"];
        [cell.contentView addSubview:uilItemName];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDATT5];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDATT5];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 112 / 640)];
        uiimv.image = uiiATT6;
        [cell.contentView addSubview:uiimv];
        UITextView *uitvBeforeDeparture = [[UITextView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 0.04, cgfScreenWidth * 120.0 / 640.0, cgfScreenWidth * 0.92, cgfScreenWidth * 400.0 / 640.0)];
        [uitvBeforeDeparture setText:@"尚未登入"];
        [cell.contentView addSubview:uitvBeforeDeparture];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cgfScreenHeightBase + self.tableView.frame.size.width * 90 / 640 + 20.0;
    } else if (indexPath.row == 1) {
        return self.tableView.frame.size.width * 410 / 640 + 20.0;
    } else if (indexPath.row == 2) {
        return self.tableView.frame.size.width * 95 / 640 + 20.0;
    } else if (indexPath.row == 3) {
        return self.tableView.frame.size.width * 95 / 640 + 20.0;
    } else if (indexPath.row == 4) {
        return self.tableView.frame.size.width * 78 / 640 + 20.0;
    } else if (indexPath.row == 5) {
        return self.tableView.frame.size.width * 95 / 640 + 20.0;
    } else if (indexPath.row == 6) {
        return self.tableView.frame.size.width * 112 / 640 + 200.0;
    } else {
        return self.tableView.frame.size.width * 300 / 640 + 20.0;
    }
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
    //    self.buttonPostPhoto.enabled = YES;
    //    self.buttonPostStatus.enabled = YES;
    //    self.buttonPickFriends.enabled = YES;
    //    self.buttonPickPlace.enabled = YES;
    
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
    //    [self.buttonPostStatus setTitle:@"Post Status Update (Logged On)" forState:self.buttonPostStatus.state];
}

//- (UIImage *)setTsaiWuLinImage:(NSString *nssTsaiWuLin) {
//    //蔡給tsai，吳給wu，林給lin，全給all。回傳目標的圖
//    return 
//}

- (void)getAllInformationFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"newtask"];
    [query whereKey:@"fid" equalTo:nssFid];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"object[fid]: %@", object[@"fid"]);
                NSLog(@"object[address]: %@", object[@"address"]);
                nssAddress = [NSString stringWithString:object[@"address"]];
                NSLog(@"object[lat]: %@", object[@"lat"]);
                nssLat = [NSString stringWithString:object[@"lat"]];
                NSLog(@"object[lon]: %@", object[@"lon"]);
                nssLon = [NSString stringWithString:object[@"lon"]];
                NSLog(@"object[point]: %@", object[@"point"]);
                nssPoint = [NSString stringWithString:object[@"point"]];
                NSLog(@"object[county]: %@", object[@"county"]);
                nssCounty = [NSString stringWithString:object[@"county"]];
                NSLog(@"object[board]: %@", object[@"board"]);
                nssResourceBoard = [NSString stringWithString:object[@"board"]];
                NSLog(@"object[chair]: %@", object[@"chair"]);
                nssResourceChair = [NSString stringWithString:object[@"chair"]];
                NSLog(@"object[desk]: %@", object[@"desk"]);
                nssResourceDesk = [NSString stringWithString:object[@"desk"]];
                NSLog(@"object[others]: %@", object[@"others"]);
                nssResourceOthers = [NSString stringWithString:object[@"others"]];
                NSLog(@"object[pen]: %@", object[@"pen"]);
                nssResourcePen = [NSString stringWithString:object[@"pen"]];
                NSLog(@"object[umbrella]: %@", object[@"umbrella"]);
                nssResourceUmbrella = [NSString stringWithString:object[@"umbrella"]];
                NSLog(@"object[water]: %@", object[@"water"]);
                nssResourceWater = [NSString stringWithString:object[@"water"]];
                NSLog(@"object[poll]: %@", object[@"poll"]);
                nssPoll = [NSString stringWithString:object[@"poll"]];
                NSLog(@"object[info]: %@", object[@"info"]);
                nssInfo = [NSString stringWithString:object[@"info"]];
                NSLog(@"object[infoURL]: %@", object[@"infoURL"]);
                nssInfoURL = [NSString stringWithString:object[@"infoURL"]];
                NSLog(@"object[version]: %@", object[@"version"]);
                nssVersion = [NSString stringWithString:object[@"version"]];
                NSLog(@"object[version]: %@", object[@"version"]);
                nssIOSToken1 = [NSString stringWithString:object[@"iosToken1"]];
                NSLog(@"object[iosToken1]: %@", object[@"iosToken1"]);
                nssIOSToken2 = [NSString stringWithString:object[@"iosToken2"]];
                NSLog(@"object[iosToken2]: %@", object[@"iosToken2"]);
                nssIOSToken3 = [NSString stringWithString:object[@"iosToken3"]];
                NSLog(@"object[iosToken3]: %@", object[@"iosToken3"]);
                if ([nssIOSToken isEqual:nssIOSToken1] == NO && [nssIOSToken isEqual:nssIOSToken2] == NO && [nssIOSToken isEqual:nssIOSToken3] == NO && [nssIOSToken1 isEqual:@"abcde"] == YES) {
                    NSLog(@"save to iosToken1: %@", nssIOSToken);
                    object[@"iosToken1"] = nssIOSToken;
                    [object saveInBackground];
                } else if ([nssIOSToken isEqual:nssIOSToken1] == NO && [nssIOSToken isEqual:nssIOSToken2] == NO && [nssIOSToken isEqual:nssIOSToken3] == NO && [nssIOSToken2 isEqual:@"abcde"] == YES) {
                    NSLog(@"save to iosToken2: %@", nssIOSToken);
                    object[@"iosToken2"] = nssIOSToken;
                    [object saveInBackground];
                } else if ([nssIOSToken isEqual:nssIOSToken1] == NO && [nssIOSToken isEqual:nssIOSToken2] == NO && [nssIOSToken isEqual:nssIOSToken3] == NO && [nssIOSToken3 isEqual:@"abcde"] == YES) {
                    NSLog(@"save to iosToken3: %@", nssIOSToken);
                    object[@"iosToken3"] = nssIOSToken;
                    [object saveInBackground];
                } else {
                    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"iOS裝置註冊已滿" message:@"您所註冊的iOS裝置已超過3個，如需要變更註冊請洽割闌尾計劃email：appy.service@gmail.com" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [errorAlert show];
                    NSLog(@"Error: %@",error.description);
                }

//                object[@"score"] = @1337;
//                gameScore[@"playerName"] = @"Sean Plott";
//                gameScore[@"cheatMode"] = @NO;
//                [gameScore saveInBackground];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    //    self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    NSLog(@"user.objectID: %@", user.objectID);
    nssFid = [NSString stringWithString:user.objectID];
    _fbProfilePic.profileID = user.objectID;
    [self getAllInformationFromParse];
    [uilFBUserName setText:[NSString stringWithFormat:@"%@", user.name]];
    NSLog(@"nssFid: %@", nssFid);
}

//

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // test to see if we can use the share dialog built into the Facebook application
    FBLinkShareParams *p = [[FBLinkShareParams alloc] init];
    p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
    BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
    BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
    BOOL canShareFBPhoto = [FBDialogs canPresentShareDialogWithPhotos];
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}


//[[Plist

- (void)initMyPlist
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistSrc = [[NSBundle mainBundle] pathForResource:@"att" ofType:@"plist"];
    _nssPlistDst = [NSString stringWithFormat:@"%@/Documents/att.plist", NSHomeDirectory()];
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
    [nsmdPlistDictionary setValue:nssName forKey:@"name"];
    [nsmdPlistDictionary setValue:nssFid forKey:@"fid"];
    [nsmdPlistDictionary setValue:nssAddress forKey:@"address"];
    [nsmdPlistDictionary setValue:nssLat forKey:@"lat"];
    [nsmdPlistDictionary setValue:nssLon forKey:@"lon"];
    [nsmdPlistDictionary setValue:nssPoint forKey:@"point"];
    [nsmdPlistDictionary setValue:nssCounty forKey:@"county"];
    [nsmdPlistDictionary setValue:nssResourceBoard forKey:@"board"];
    [nsmdPlistDictionary setValue:nssResourceChair forKey:@"chair"];
    [nsmdPlistDictionary setValue:nssResourceDesk forKey:@"desk"];
    [nsmdPlistDictionary setValue:nssResourceOthers forKey:@"others"];
    [nsmdPlistDictionary setValue:nssResourcePen forKey:@"pen"];
    [nsmdPlistDictionary setValue:nssResourceUmbrella forKey:@"umbrella"];
    [nsmdPlistDictionary setValue:nssResourceWater forKey:@"water"];
    [nsmdPlistDictionary setValue:nssPoll forKey:@"poll"];
    [nsmdPlistDictionary setValue:nssInfo forKey:@"info"];
    [nsmdPlistDictionary setValue:nssInfoURL forKey:@"infoURL"];
    [nsmdPlistDictionary setValue:nssVersion forKey:@"version"];
    [nsmdPlistDictionary writeToFile:_nssPlistDst atomically:YES];
}

- (void)readAllFromMyPlist {
    if (_nssPlistDst == nil) {
        [self initMyPlist];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:_nssPlistDst];
    if (nsmdPlistDictionary != nil) {
        nssName = [nsmdPlistDictionary objectForKeyedSubscript:@"name"];
        nssFid = [nsmdPlistDictionary objectForKeyedSubscript:@"fid"];
        nssAddress = [nsmdPlistDictionary objectForKeyedSubscript:@"address"];
        nssLat = [nsmdPlistDictionary objectForKeyedSubscript:@"lat"];
        nssLon = [nsmdPlistDictionary objectForKeyedSubscript:@"lon"];
        nssPoint = [nsmdPlistDictionary objectForKeyedSubscript:@"point"];
        nssCounty = [nsmdPlistDictionary objectForKeyedSubscript:@"county"];
        nssResourceBoard = [nsmdPlistDictionary objectForKeyedSubscript:@"board"];
        nssResourceChair = [nsmdPlistDictionary objectForKeyedSubscript:@"chair"];
        nssResourceDesk = [nsmdPlistDictionary objectForKeyedSubscript:@"desk"];
        nssResourceOthers = [nsmdPlistDictionary objectForKeyedSubscript:@"others"];
        nssResourcePen = [nsmdPlistDictionary objectForKeyedSubscript:@"pen"];
        nssResourceUmbrella = [nsmdPlistDictionary objectForKeyedSubscript:@"umbrella"];
        nssResourceWater = [nsmdPlistDictionary objectForKeyedSubscript:@"water"];
        nssPoll = [nsmdPlistDictionary objectForKeyedSubscript:@"poll"];
        nssInfo = [nsmdPlistDictionary objectForKeyedSubscript:@"info"];
        nssInfoURL = [nsmdPlistDictionary objectForKeyedSubscript:@"infoURL"];
        nssVersion = [nsmdPlistDictionary objectForKeyedSubscript:@"version"];
        nssIOSToken = delegate.nssDeviceToken;
    }
}

//]]Plist


@end