//
//  MSTableViewController.m
//  ios
//
//  Created by lololol on 3/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "MSTableViewController.h"
#import "AppDelegate.h"

@interface MSTableViewController ()
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

@implementation MSTableViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyScreenSize];
    [self makeKeyboardOffset];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString *nssEmbedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString *nssHtml = [NSString stringWithFormat:nssEmbedHTML, @"https://www.youtube.com/watch?feature=player_embedded&v=OtvbZscM90A", self.tableView.frame.size.width * 0.92, self.tableView.frame.size.width * .92 * 9.0 / 16.0];
    _uiwVideoView = [[UIWebView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.04, self.tableView.frame.size.width * 90 / 640   + cgfScreenWidth * 25.0 / 640.0, self.tableView.frame.size.width * 0.92, self.tableView.frame.size.width * 0.92 * 9.0 / 16.0)];
    [_uiwVideoView loadHTMLString:nssHtml baseURL:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier0 = @"Cell0";
    static NSString *identifier1 = @"Cell1";
    static NSString *identifier2 = @"Cell2";
    static NSString *identifier3 = @"Cell3";
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
            UIImage *uiim = [UIImage imageNamed:@"ms1_1"];
            UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 90 / 640)];
            uiimv.image = uiim;
            [cell.contentView addSubview:uiimv];
            
            [cell.contentView addSubview:_uiwVideoView];
        }
    } else if (indexPath.row == 1) {
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            UIImage *uiim = [UIImage imageNamed:@"ms2_1"];
            UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 114 / 640)];
            uiimv.image = uiim;
            [cell.contentView addSubview:uiimv];
            
            UITextView *uitvContent = [[UITextView alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.04, self.tableView.frame.size.width * 114 / 640 + cgfScreenWidth * 25.0 / 640.0, self.tableView.frame.size.width * 0.92, self.tableView.frame.size.width * 1.7 / 4.0)];
            [uitvContent setText:@"這是一場全民覺醒的運動，超越了議會，從家庭、從巷口、從網路，從社會的各個角落開始綻放，罷免不再是瀕死的法條，而是活著的行動。割去發炎的「闌尾」，從體制內去影響、去改變現今有缺陷的代議制度，讓我們一起締造台灣新型態的社會運動。不論你是想擔任當天擺攤志工、物資提供或純粹想要鍵盤參戰，亦或是您想要長期熱情參與，你都可以成為割闌尾V計劃的公民V。"];
            uitvContent.editable = NO;
            [cell.contentView addSubview:uitvContent];
        }
    } else if (indexPath.row == 2) {
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            UIImage *uiim = [UIImage imageNamed:@"ms3_1"];
            UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 114 / 640)];
            uiimv.image = uiim;
            [cell.contentView addSubview:uiimv];
            
            UITextView *uitvContent = [[UITextView alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.04, self.tableView.frame.size.width * 114 / 640  + cgfScreenWidth * 25.0 / 640.0, self.tableView.frame.size.width * 0.92, self.tableView.frame.size.width * 1.7 / 4.0)];
            [uitvContent setText:@"這一天，就是今年的選舉日：1129。\n1129，台灣有七成的選民會去投票；1129這一天我們將在投票所外擺攤簽署罷免連署書，讓選舉日變成罷免日，因此割闌尾V計劃就是為了讓罷免第二階段看似不可能的任務變成可能，這一天我們將實踐屬於人民的參政權！"];
            uitvContent.editable = NO;
            [cell.contentView addSubview:uitvContent];
        }
    } else if (indexPath.row == 3) {
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
            UIImage *uiim = [UIImage imageNamed:@"ms4_1"];
            UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 114 / 640)];
            uiimv.image = uiim;
            [cell.contentView addSubview:uiimv];
            UIImage *uiim2 = [UIImage imageNamed:@"ms4_2"];
            UIImageView *uiimv2 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, self.tableView.frame.size.width * 114 / 640   + cgfScreenWidth * 25.0 / 640.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 772 / 640)];
            uiimv2.image = uiim2;
            [cell.contentView addSubview:uiimv2];
            [self setButton:cell offset:self.tableView.frame.size.width * 114 / 640 + cgfScreenWidth * 25.0 / 640.0];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.tableView.frame.size.width * 90 / 640  + cgfScreenWidth * 25.0 / 640.0 + self.tableView.frame.size.width * 0.92 * 9.0 / 16.0 + cgfScreenWidth * 25.0 / 640.0;
    } else if (indexPath.row == 1) {
        return self.tableView.frame.size.width * 114 / 640  + cgfScreenWidth * 25.0 / 640.0 + self.tableView.frame.size.width * 1.7 / 4.0;
    } else if (indexPath.row == 2) {
        return self.tableView.frame.size.width * 114 / 640  + cgfScreenWidth * 25.0 / 640.0 + self.tableView.frame.size.width * 1.7 / 4.0;;
    } else if (indexPath.row == 3) {
        return self.tableView.frame.size.width * 114 / 640  + cgfScreenWidth * 25.0 / 640.0 + self.tableView.frame.size.width * 772 / 640  + cgfScreenWidth * 15.0 / 640.0;
    } return 0;
}

@end
