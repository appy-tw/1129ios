//
//  myParseDelegate.m
//  TaiwanRailwayDataSearch
//
//  Created by lololol on 18/Feb/14.
//  Copyright (c) 2014 lololol. All rights reserved.
//

#import "MYParseDelegate.h"
#import "PLISTHeader.h"

@implementation MYParseDelegate
- (void)getStart:(NSInteger)sl_nsiUserInputSearchFunction{
//initialize
    nsiDataCounter = 0;
    nssNowTag = [NSString stringWithFormat:@""];
    self.nsmaOutput = [[NSMutableArray alloc]init];
    if (delegate == nil) {
        delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    NSData *data = [delegate.nssRSSContent dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    parser = nil;
    bImageStartRecord = NO;
    bSpanStartRecord = NO;
    bLinkStartRecord = NO;
}

- (void)     parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
       namespaceURI:(NSString *)namespaceURI
      qualifiedName:(NSString *)qualifiedName
         attributes:(NSDictionary *)attributeDict {
//    NSLog(@"%@", elementName);
    if ([elementName isEqual:@"item"] == YES){
        nsiDataCounter ++;
        bImageStartRecord = YES;
        nsmdNowDictionary = [[NSMutableDictionary alloc]init];
        NSLog(@"item: %ld", (long)nsiDataCounter);
    } else if ([elementName isEqual:@"link"] == YES) {
        bLinkStartRecord = YES;
    }
//    if ([elementName isEqual:@"img"] == YES){
//        nsiDataCounter ++;
//        bImageStartRecord = YES;
//        nsmdNowDictionary = [[NSMutableDictionary alloc]init];
//        NSLog(@"elementName: %@", elementName);
//        NSLog(@"namespaceURI: %@", namespaceURI);
//        NSLog(@"qualifiedName: %@", qualifiedName);
//        NSLog(@"xxxxx");
//    } else if ([elementName isEqual:@"img"] == YES) {
//        [nsmdNowDictionary setObject:elementName forKey:[attributeDict objectForKey:@"src"]];
//        bImageStartRecord = NO;
//        NSLog(@"elementName: %@", elementName);
//        NSLog(@"namespaceURI: %@", namespaceURI);
//        NSLog(@"qualifiedName: %@", qualifiedName);
//    } else if ([elementName isEqual:@"span"] == YES) {
//        [nsmdNowDictionary setObject:elementName forKey:[attributeDict objectForKey:@"span"]];
//        bSpanStartRecord = YES;
//        NSLog(@"elementName: %@", elementName);
//        NSLog(@"namespaceURI: %@", namespaceURI);
//        NSLog(@"qualifiedName: %@", qualifiedName);
//    } else if ([elementName isEqual:@"p"]) {
//        NSLog(@"xxx");
//    }
    
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
//    NSLog(@"foundCharacters: %@", string);
    if (bLinkStartRecord == YES) {
        NSLog(@"link: %@", string);
        bLinkStartRecord = NO;
    }
//    if ([string rangeOfString:@"img src="].location != NSNotFound) {
//        nsiDataCounter ++;
//        bImageStartRecord = YES;
//        NSLog(@"%@", [string componentsSeparatedByString:@"\""][1]);
//    } else if (bImageStartRecord == YES) {
//        if ([string isEqualToString:@"<"] == NO && [string isEqualToString:@"p"] == NO && [string isEqualToString:@">"] == NO && [string isEqualToString:@"/p"] == NO && [string isEqualToString:@"br/"] == NO && [string isEqualToString:@"span"] == NO && [string isEqualToString:@"!-- more --"] == NO && [string isEqualToString:@"/span"] == NO && [string isEqualToString:@"/a"] == NO){
//            if ([string rangeOfString:@"="].location == NSNotFound && [string rangeOfString:@"&"].location == NSNotFound && [string rangeOfString:@"#"].location == NSNotFound && [string rangeOfString:@";"].location == NSNotFound && [string rangeOfString:@"//"].location == NSNotFound) {
//                NSLog(@"foundCharacters: %@", string);
//            }
//        }
//    }
    
    
    
    nsmdNowDictionary = [[NSMutableDictionary alloc]init];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
//    if ([elementName isEqual:@"item"]){
//        [self.nsmaOutput addObject:nsmdNowDictionary];
//        for (NSString* key in nsmdNowDictionary) {
//            NSLog(@"%@", key);
//        }
//        bImageStartRecord = NO;
//        bSpanStartRecord = NO;
//    } else if ([elementName isEqual:@"img"]) {
//        bImageStartRecord = NO;
//    } else if ([elementName isEqual:@"span"]) {
//        bSpanStartRecord = NO;
//    }
}

@end
