//
//  ATTTableViewController.h
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FacebookSDK/FacebookSDK.h>

@interface ATTTableViewController : UITableViewController

@property (nonatomic, strong) FBProfilePictureView *fbProfilePic;

@property (strong, nonatomic) NSString *nssPlistDst;

@property (nonatomic, strong) UIView *uivReloadCellGraph;
@property (nonatomic, strong) UIView *uivReloadCellBackground;
@property (nonatomic, strong) UIImageView *uiivReloadBack;
@property (nonatomic, strong) UIImageView *uiivReloadFront;

@end
