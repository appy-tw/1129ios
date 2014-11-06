//
//  myParseDelegate.m
//  TaiwanRailwayDataSearch
//
//  Created by lololol on 18/Feb/14.
//  Copyright (c) 2014 lololol. All rights reserved.
//

#import "MYParseDelegate.h"
#import "PLISTHeader.h"
#import "AppDelegate.h"

@interface MYParseDelegate()
{
    AppDelegate *delegate;
    NSMutableDictionary *nsmdNowDictionary;
    BOOL bItemStartRecord;
    BOOL bImageStartRecord;
    BOOL bSpanStartRecord;
    NSString *nssNowTag;
    NSMutableString *nsmsSpan;
}

@end

@implementation MYParseDelegate

- (void)setInit {
    bItemStartRecord = YES;
    bImageStartRecord = NO;
    bSpanStartRecord = NO;
}

- (void)getStart:(NSInteger)sl_nsiUserInputSearchFunction{
    self.nsmaOutput = [[NSMutableArray alloc]init];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSData *data = [delegate.nssRSSContent dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    parser = nil;
    bItemStartRecord = NO;
}

- (void)     parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
       namespaceURI:(NSString *)namespaceURI
      qualifiedName:(NSString *)qualifiedName
         attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqual:@"item"] == YES) {
        bItemStartRecord = YES;
        nsmdNowDictionary = [[NSMutableDictionary alloc]init];
        nsmsSpan = [NSMutableString new];
    }
    nssNowTag = [NSString stringWithString:elementName];
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    if (bItemStartRecord == YES && [nssNowTag isEqualToString:@"title"] == YES) {
        [nsmsSpan appendString:string];
        bImageStartRecord = YES;
    } else if (bItemStartRecord == YES && [nssNowTag isEqualToString:@"link"] == YES) {
        [nsmdNowDictionary setObject:string forKey:@"link"];
    } else if (bItemStartRecord == YES && [nssNowTag isEqualToString:@"pubDate"] == YES) {
        [nsmdNowDictionary setObject:string forKey:@"pubDate"];
        [nsmdNowDictionary setObject:[NSString stringWithString:nsmsSpan] forKey:@"span"];
        [self.nsmaOutput addObject:nsmdNowDictionary];
        NSLog(@"%ld", (unsigned long)[self.nsmaOutput count]);
        NSLog(@"img: %@", [nsmdNowDictionary objectForKey:@"img"]);
        NSLog(@"link: %@", [nsmdNowDictionary objectForKey:@"link"]);
        NSLog(@"pubDate: %@", [nsmdNowDictionary objectForKey:@"pubDate"]);
        NSLog(@"span: %@", [nsmdNowDictionary objectForKey:@"span"]);
        bItemStartRecord = NO;
        nsmdNowDictionary = nil;
    } else if (bItemStartRecord == YES && bImageStartRecord == YES) {
        if ([string rangeOfString:@"img src="].location != NSNotFound) {
            [nsmdNowDictionary setObject:[string componentsSeparatedByString:@"\""][1] forKey:@"img"];
            bImageStartRecord = NO;
            bSpanStartRecord = YES;
        } else if ([string rangeOfString:@"img alt="].location != NSNotFound) {
            [nsmdNowDictionary setObject:[string componentsSeparatedByString:@"\""][3] forKey:@"img"];
            bImageStartRecord = NO;
            bSpanStartRecord = YES;
        }
    } else if (bItemStartRecord == YES && bSpanStartRecord == YES) {
        if ([string isEqualToString:@"<"] == NO && [string isEqualToString:@"p"] == NO && [string isEqualToString:@">"] == NO && [string isEqualToString:@"/p"] == NO && [string isEqualToString:@"br/"] == NO && [string isEqualToString:@"span"] == NO && [string isEqualToString:@"!-- more --"] == NO && [string isEqualToString:@"/span"] == NO && [string isEqualToString:@"/a"] == NO){
            if ([string rangeOfString:@"="].location == NSNotFound && [string rangeOfString:@"&"].location == NSNotFound && [string rangeOfString:@"#"].location == NSNotFound && [string rangeOfString:@";"].location == NSNotFound && [string rangeOfString:@"//"].location == NSNotFound && [string rangeOfString:@"\n"].location == NSNotFound && [string rangeOfString:@"\\"].location == NSNotFound && [string rangeOfString:@"\t"].location == NSNotFound) {
                [nsmsSpan appendString:string];
//                NSLog(@"foundCharacters: %@", string);
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
}

@end
