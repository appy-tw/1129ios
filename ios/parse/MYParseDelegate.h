//
//  myParseDelegate.h
//  TaiwanRailwayDataSearch
//
//  Created by lololol on 18/Feb/14.
//  Copyright (c) 2014 lololol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface MYParseDelegate : NSObject <NSXMLParserDelegate>
{
    NSInteger nsiDataCounter;
    NSString *nssNowTag;
    NSMutableDictionary *nsmdNowDictionary;
    AppDelegate *delegate;
    BOOL bImageStartRecord;
    BOOL bSpanStartRecord;
    BOOL bLinkStartRecord;
}

@property NSMutableArray *nsmaOutput;

- (void)getStart:(NSInteger)l_nsiUserInputSearchFunction;  //initialize
- (void)    parser:(NSXMLParser *)parser                    //star parse
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qualifiedName
        attributes:(NSDictionary *)attributeDict;
- (void)    parser:(NSXMLParser *)parser                    //
   foundCharacters:(NSString *)string;
- (void)    parser:(NSXMLParser *)parser                    //
     didEndElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName;
@end
