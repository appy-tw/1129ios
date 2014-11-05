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
    bStartRecord = NO;
}

- (void)     parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
       namespaceURI:(NSString *)namespaceURI
      qualifiedName:(NSString *)qualifiedName
         attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqual:@"item"]){
        nsiDataCounter ++;
        nsiCategoryCounter = 0;
//        NSLog(@"my: %d", nsiDataCounter);
        nsmdNowDictionary = [[NSMutableDictionary alloc]init];
        bStartRecord = YES;
        NSLog(@"elementName: %@", elementName);
        NSLog(@"namespaceURI: %@", namespaceURI);
        NSLog(@"qualifiedName: %@", qualifiedName);
    } else if ([elementName isEqual:@"category"]) {
//        nsiCategoryCounter ++;
        nssNowTag = [NSString stringWithString:elementName];
    }else {
        nssNowTag = [NSString stringWithString:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    if ([string length] > 1 && bStartRecord == YES) {
        //from parser:foundCharacters: docs:
        //The parser object may send the delegate several parser:foundCharacters: messages to report the characters of an element.
        //Because string may be only part of the total character content for the current element, you should append it to the current
        //accumulation of characters until the element changes.
        if ([nssNowTag isEqualToString:TAG_CATEGORY] == YES) {
            nsiCategoryCounter ++;
            [nsmdNowDictionary setObject:string forKey:[NSString stringWithFormat:@"%@%ld", nssNowTag, (long)nsiCategoryCounter]];
                NSLog(@"key: %@, value: %@", [NSString stringWithFormat:@"%@%ld", nssNowTag, (long)nsiCategoryCounter], string);
        } else if ([nssNowTag isEqualToString:TAG_TITLE] == YES || [nssNowTag isEqualToString:TAG_PUB_DATE] == YES || [nssNowTag isEqualToString:TAG_ITEM] == YES || [nssNowTag isEqualToString:TAG_DESCRIPTION] == YES){
            [nsmdNowDictionary setObject:string forKey:nssNowTag];
            NSLog(@"key: %@, value: %@", nssNowTag, string);
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([elementName isEqual:@"item"]){
        [self.nsmaOutput addObject:nsmdNowDictionary];
        for (NSString* key in nsmdNowDictionary) {
//            NSLog(@"%@", key);
        }
        bStartRecord = NO;
    }
}

@end
