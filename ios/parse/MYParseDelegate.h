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
    //<失業率>
    //<資料時期>1978</資料時期>
    //<總計>1.67</總計>
    //<男>1.57</男>
    //<女>1.86</女>
    //<age_15-19>3.95</age_15-19>
    //<age_20-24>3.77</age_20-24>
    //<age_25-29>1.54</age_25-29>
    //<age_30-34>0.64</age_30-34>
    //<age_35-39>0.38</age_35-39>
    //<age_40-44>0.43</age_40-44>
    //<age_45-49>0.43</age_45-49>
    //<age_50-54>0.82</age_50-54>
    //<age_55-59>0.76</age_55-59>
    //<age_60-64>0.43</age_60-64>
    //<age_65_over>0.17</age_65_over>
    //<國中及以下>1.03</國中及以下>
    //<國小及以下>0.64</國小及以下>
    //<國中>2.28</國中>
    //<高中_職>3.69</高中_職>
    //<高中>3.72</高中>
    //<高職>3.67</高職>
    //<大專及以上>3.15</大專及以上>
    //<專科>3.75</專科>
    //<大學及以上>2.54</大學及以上>
    //</失業率>
    NSInteger nsiCategoryCounter;
    NSInteger nsiDataCounter;
    NSString *nssNowTag;
    NSMutableDictionary *nsmdNowDictionary;
    AppDelegate *delegate;
    BOOL bStartRecord;
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
