//
//  myParseDelegate.m
//  TaiwanRailwayDataSearch
//
//  Created by lololol on 18/Feb/14.
//  Copyright (c) 2014 lololol. All rights reserved.
//

#import "MYParseDelegate.h"

@implementation MYParseDelegate
- (void)getStart:(NSInteger)l_nsiUserInputSearchFunction{
//initialize
    nsiDataCounter = 0;
    nssNowTag = [NSString stringWithFormat:@""];
    self.nsmaOutput = [[NSMutableArray alloc]init];
    NSString *BundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *fileName = [NSString stringWithFormat:@"%@/失業率.xml", BundlePath];
    http://yurenju.tumblr.com/rss
    NSLog(@"File Path: %@", fileName);

    NSData *data = [NSData dataWithContentsOfFile:fileName]; //the File Data
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    parser = nil;
}

- (void)     parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
       namespaceURI:(NSString *)namespaceURI
      qualifiedName:(NSString *)qualifiedName
         attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqual:@"失業率"]){
        nsiDataCounter ++;
//        NSLog(@"my: %d", nsiDataCounter);
        nsmdNowDictionary = [[NSMutableDictionary alloc]initWithCapacity:28];
    } else {
        nssNowTag = [NSString stringWithString:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    if ([string length] > 1) {
        //from parser:foundCharacters: docs:
        //The parser object may send the delegate several parser:foundCharacters: messages to report the characters of an element.
        //Because string may be only part of the total character content for the current element, you should append it to the current
        //accumulation of characters until the element changes.
        [nsmdNowDictionary setObject:string forKey:nssNowTag];
//        NSLog(@"key: %@, value: %@", nssNowTag, string);
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([elementName isEqual:@"失業率"]){
        [self.nsmaOutput addObject:nsmdNowDictionary];
//        for (NSString* key in nsmdNowDictionary) {
//            NSLog(@"%@", key);
//        }
    }
}

@end
