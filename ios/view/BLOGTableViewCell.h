//
//  BLOGTableViewCell.h
//  1129vday
//
//  Created by lololol on 30/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLOGTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *uiivNewsTypeLogo;
@property (strong, nonatomic) UIImageView *uiivNewsTypeBackground;
@property (strong, nonatomic) UILabel *uilNewsTypeTip;
@property (strong, nonatomic) UILabel *uilTitle;
@property (strong, nonatomic) UITextView *uitvContent;
@property (strong, nonatomic) UIButton *uibReadMore;

@end
