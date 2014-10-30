//
//  BLOGTableViewCell.m
//  1129vday
//
//  Created by lololol on 30/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "BLOGTableViewCell.h"

@implementation BLOGTableViewCell
{
    CGFloat cgfW;
    CGFloat cgfH;
}

- (void)initCellWidthAndWidth {
    cgfW = self.frame.size.width;
    cgfH = self.frame.size.height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.uiivNewsTypeLogo = [[UIImageView alloc]initWithFrame:CGRectMake(cgfW * 0.04, cgfH * 0.04, cgfW * 0.06, cgfH * 0.21)];
        self.uiivNewsTypeBackground = [[UIImageView alloc]initWithFrame:CGRectMake(cgfW * 0.10, cgfH * 0.04, cgfW * 0.18, cgfH * 0.21)];
        self.uilNewsTypeTip = [[UILabel alloc]initWithFrame:CGRectMake(cgfW * 0.12, cgfH * 0.05, cgfW * 0.14, cgfH * 0.19)];
        self.uilTitle = [[UILabel alloc]initWithFrame:CGRectMake(cgfW * 0.36, cgfH * 0.04, cgfW * 0.60, cgfH * 0.21)];
        self.uitvContent = [[UITextView alloc]initWithFrame:CGRectMake(cgfW * 0.04, cgfH * 0.29, cgfW * 0.92, cgfH * 0.42)];
        self.uibReadMore = [[UIButton alloc]initWithFrame:CGRectMake(cgfW * 0.78, cgfH * 0.75, cgfW * 0.18, cgfH * 0.21)];
        
        [self.contentView addSubview:self.uiivNewsTypeLogo];
        [self.contentView addSubview:self.uiivNewsTypeBackground];
        [self.contentView addSubview:self.uilNewsTypeTip];
        [self.contentView addSubview:self.uilTitle];
        [self.contentView addSubview:self.uitvContent];
        [self.contentView addSubview:self.uibReadMore];
        
        [self.uilNewsTypeTip setText:@"魔王狀況"];
        [self.uilTitle setText:@"【蔡正元Ａ錢，罪證明確】－罷免Ａ錢蔡，全國都喊讚"];
        [self.uitvContent setText:@"資深司法記者黃越宏按鈴控告【蔡正元Ａ錢，罪證明確】，憲法133實踐聯盟發起人馮光遠、割闌尾計畫聯手到場聲援，號召全民罷免爛立委。蔡正元利用擔任中影董事長期間，犯下「業務侵占」罪，並經士林地方法院判刑一年在案，卻由中影與檢方聯手吃案，"];
        
        UIFont *uifFont = [UIFont fontWithName:@"Wawati TC" size:25];
        [self.uilNewsTypeTip setFont:uifFont];
        [self.uilTitle setFont:uifFont];
        [self.uitvContent setFont:uifFont];
        
//        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@""]]];
        [self.uiivNewsTypeLogo setImage:[UIImage imageNamed:@"blogp_NewsTypeLogo"]];
        [self.uiivNewsTypeBackground setImage:[UIImage imageNamed:@"blogp_NewsTypeBackground"]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
