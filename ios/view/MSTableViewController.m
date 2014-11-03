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
    
    CGFloat cgfHigh0;
    CGFloat cgfHigh1;
    CGFloat cgfHigh2;
    CGFloat cgfHigh3;
    
    AppDelegate *delegate;
}

@end

@implementation MSTableViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyScreen];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)setMovie
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        UIImage *uiim = [UIImage imageNamed:@"ms1_1"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, cgfScreenHeightBase, uiim.size.width, uiim.size.height)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];

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
        NSLog(@"%f %f",self.tableView.frame.size.width, cell.frame.size.width);
        NSString *nssHtml = [NSString stringWithFormat:nssEmbedHTML, @"https://www.youtube.com/watch?feature=player_embedded&v=OtvbZscM90A", self.tableView.frame.size.width * 0.92, self.tableView.frame.size.width * .92 * 9.0 / 16.0];
        UIWebView *uiwVideoView = [[UIWebView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.04, 5.0 + uiim.size.height + 5.0 + cgfScreenHeightBase, self.tableView.frame.size.width * 0.92, self.tableView.frame.size.width * 0.92 * 9.0 / 16.0)];
        [uiwVideoView loadHTMLString:nssHtml baseURL:nil];
        [cell.contentView addSubview:uiwVideoView];
        cgfHigh0 = cgfScreenHeightBase + uiim.size.height + 5.0 + cgfScreenHeightBase + self.tableView.frame.size.width * 0.92 * 9.0 / 16.0;
    } else if (indexPath.row == 1) {
        UIImage *uiim = [UIImage imageNamed:@"ms2_1"];
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, cgfScreenHeightBase, uiim.size.width, uiim.size.height)];
        uiimv.image = uiim;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 2) {

    } else if (indexPath.row == 3) {

    }
    
    
    // Configure the cell...
    //    [cell.uilNewsTypeTip setText:@"魔王狀況"];
    //    [cell.uilTitle setText:@"【蔡正元Ａ錢，罪證明確】－罷免Ａ錢蔡，全國都喊讚"];
//    [cell.uitvContent setText:@"資深司法記者黃越宏按鈴控告【蔡正元Ａ錢，罪證明確】，憲法133實踐聯盟發起人馮光遠、割闌尾計畫聯手到場聲援，號召全民罷免爛立委。蔡正元利用擔任中影董事長期間，犯下「業務侵占」罪，並經士林地方法院判刑一年在案，卻由中影與檢方聯手吃案，"];
    //        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@""]]];
//    [cell.uiivNewsTypeLogo setImage:[UIImage imageNamed:@"blogp_NewsTypeLogo"]];
//    [cell.uiivNewsTypeBackground setImage:[UIImage imageNamed:@"blogp_NewsTypeBackground"]];
    
//    [cell.uilTitle setText:[[_myParseDelegate.nsmaOutput objectAtIndex:indexPath.row]valueForKey:TAG_TITLE]];
    //    [cell.uitvContent setText:[[_myParseDelegate.nsmaOutput objectAtIndex:indexPath.row]valueForKey:TAG_DESCRIPTION]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cgfScreenHeightBase + [UIImage imageNamed:@"ms1_1"].size.height + 5.0 + cgfScreenHeightBase + self.tableView.frame.size.width * 0.92 * 9.0 / 16.0 +5.0;
    } else if (indexPath.row == 1) {
        return 300;
    } else if (indexPath.row == 2) {
        return 300;
    } else {
        return 300;
    }
}

@end
