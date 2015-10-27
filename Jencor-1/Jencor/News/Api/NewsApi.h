//
//  NewsApi.h
//  Sky Financial Corp
//
//  Created by Ved Prakash on 25/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "News.h"

@interface NewsApi : NSObject<ASIHTTPRequestDelegate,NSXMLParserDelegate> {
    JencorAppDelegate *appDelegate;
    
    NSMutableString *currentElementValue;
    
    NSString *strCurElement;
    
    NSXMLParser *xmlParser;
    
    BOOL isItem;
    
    News *news;
    
    NSMutableArray *refArray;
    
    UIViewController *parent;
    
}

@property(nonatomic,retain)UIViewController *parent;
-(void)requestForNews;
-(void)parseData:(NSData *)data;

@end
