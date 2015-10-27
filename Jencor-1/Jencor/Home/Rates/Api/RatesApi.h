//
//  RatesApi.h
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Rate.h"

@interface RatesApi : NSObject<ASIHTTPRequestDelegate,NSXMLParserDelegate> {
    UIViewController *parent;
    
    JencorAppDelegate *appDelegate;
    
    NSMutableString *currentElementValue;
    
    NSString *strCurElement;
    
    NSXMLParser *xmlParser;
    
    BOOL isItem;
    
    Rate *rate;
    
    NSMutableArray *refArray;
    
    BOOL isRequesting;
    
    BOOL toGetRate;
}
@property(nonatomic)BOOL toGetRate;
@property(nonatomic,retain)UIViewController *parent;
-(void)parseData:(NSData *)data;
-(void)makeRequest;
@end
