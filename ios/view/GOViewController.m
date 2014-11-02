//
//  GOViewController.m
//  ios
//
//  Created by lololol on 2/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "GOViewController.h"

#import "AppDelegate.h"

#import <FacebookSDK/FacebookSDK.h>


@interface GOViewController() <FBLoginViewDelegate>
{
    CGFloat cgfAvailableWidth;
    CGFloat cgfAvailableHeight;
    CGFloat cgfAvailableHeightStart;
    CGFloat cgfAvailableHeightEnd;
    
    CGFloat cgfStatusBarHeight;
    CGFloat cgfNavigationBarHeight;
    CGFloat cgfTabBarHeight;
    
    UILabel *uilUserNameTip;
    UILabel *uilUserName;
    UILabel *uilMissionTip;
    UILabel *uilMission;
    UILabel *uilMaterialTip;
    UILabel *uilMaterial;
    UILabel *uilLocationTip;
    UILabel *uilLocation;
    UIImageView *uiivProfile;
    
    AppDelegate *delegate;
}


@end

@implementation GOViewController

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
    uibTsai.frame = CGRectMake(cgfAvailableWidth * 0.19, cgfAvailableHeight * 0.408 + cgfAvailableHeightStart, cgfAvailableWidth * 0.13, cgfAvailableWidth * 0.13 * 173.0 / 176.0);
    [uibTsai addTarget:self action:@selector(uibClickedTsai) forControlEvents:UIControlEventTouchUpInside];
    uibTsai.tintColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    [self.view addSubview:uibTsai];
    
    UIButton *uibWu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibWu.frame = CGRectMake(cgfAvailableWidth * 0.436, cgfAvailableHeight * 0.408 + cgfAvailableHeightStart, cgfAvailableWidth * 0.13, cgfAvailableWidth * 0.13 * 173.0 / 176.0);
    [uibWu addTarget:self action:@selector(uibClickedWu) forControlEvents:UIControlEventTouchUpInside];
    uibWu.tintColor = [UIColor colorWithRed:0.71 green:0.13 blue:0.25 alpha:1.0];
    [self.view addSubview:uibWu];
    
    UIButton *uibLin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibLin.frame = CGRectMake(cgfAvailableWidth * 0.698, cgfAvailableHeight * 0.408 + cgfAvailableHeightStart, cgfAvailableWidth * 0.13, cgfAvailableWidth * 0.13 * 173.0 / 176.0);
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
//    [self setImageAndButton];
}

- (void)setFacebook {
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:
                              @[@"public_profile", @"email", @"user_friends"]];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];
}

- (void)setFBView {
    FBLoginView *fbLoginView = [[FBLoginView alloc]initWithFrame:CGRectMake(0.0, cgfAvailableHeight * 0.84 + cgfAvailableHeightStart,  cgfAvailableWidth * 1.0, cgfAvailableHeight * 0.3)];
    
    fbLoginView.frame = CGRectOffset(fbLoginView.frame, cgfAvailableWidth / 12.0, 0);
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        fbLoginView.frame = CGRectOffset(fbLoginView.frame, cgfAvailableWidth / 12.0, 0);
    }
#endif
#endif
#endif
    fbLoginView.delegate = self;
    
    [self.view addSubview:fbLoginView];
    [fbLoginView sizeToFit];
}

- (void)setAllItem {
    uilUserNameTip = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.04 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilUserNameTip setText:@"名字："];
    [self.view addSubview:uilUserNameTip];
    
    uilUserName = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.14 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilUserName setText:@"???"];
    [self.view addSubview:uilUserName];
    
    uilMissionTip = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.24 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilMissionTip setText:@"任務："];
    [self.view addSubview:uilMissionTip];
    
    uilMission = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.34 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilMission setText:@"xxx"];
    [self.view addSubview:uilMission];

    uilMaterialTip = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.44 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilMaterialTip setText:@"物資："];
    [self.view addSubview:uilMaterialTip];
    
    uilMaterial = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.54 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilMaterial setText:@"yyy"];
    [self.view addSubview:uilMaterial];

    uilLocationTip = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.64 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilLocationTip setText:@"據點："];
    [self.view addSubview:uilLocationTip];
    
    uilLocation = [[UILabel alloc]initWithFrame:CGRectMake(cgfAvailableWidth * 0.54, cgfAvailableHeight * 0.74 + cgfAvailableHeightStart, cgfAvailableWidth * 0.42, cgfAvailableHeight * 0.1)];
    [uilLocation setText:@"zzz"];
    [self.view addSubview:uilLocation];

    
//    UILabel *uilMission;
//    UILabel *uilMaterialTip;
//    UILabel *uilMaterial;
//    UILabel *uilLocationTip;
//    UILabel *uilLocation;
//    UIImageView *uiivProfile;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self drawScreen];
    [self setFBView];
    [self setAllItem];
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

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        // Since we use FBRequestConnectionErrorBehaviorAlertUser,
        // we do not need to surface our own alert view if there is an
        // an fberrorUserMessage unless the session is closed.
        if (error.fberrorUserMessage && FBSession.activeSession.isOpen) {
            alertTitle = nil;
            
        } else {
            // Otherwise, use a general "connection problem" message.
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Success";
    }
    
    if (alertTitle) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
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

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
//    self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
//    self.profilePic.profileID = user.objectID;
//    self.loggedInUser = user;
    uilUserName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
}

//

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // test to see if we can use the share dialog built into the Facebook application
    FBLinkShareParams *p = [[FBLinkShareParams alloc] init];
    p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
    BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
    BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
    BOOL canShareFBPhoto = [FBDialogs canPresentShareDialogWithPhotos];
    
//    self.buttonPostStatus.enabled = canShareFB || canShareiOS6;
//    self.buttonPostPhoto.enabled = canShareFBPhoto;
//    self.buttonPickFriends.enabled = NO;
//    self.buttonPickPlace.enabled = NO;
    
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
//    [self.buttonPostStatus setTitle:@"Post Status Update (Logged Off)" forState:self.buttonPostStatus.state];
    
//    self.profilePic.profileID = nil;
//    self.labelFirstName.text = nil;
//    self.loggedInUser = nil;
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}


@end
