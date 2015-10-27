//
//  NewsDetailsController.h
//  Jencor
//
//  Created by Teknowledge Software on 20/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "CommonHeader.h"

@interface NewsDetailsController : UIViewController{

    News *news;
    
    CommonHeader *header;
    
    JencorAppDelegate *appDelegate;
    NSString *url;
    
    BOOL isFetchingData;
    NSString *newsContent;
    BOOL parsingFailed;
}

@property(nonatomic,retain) News *news;
@property (retain, nonatomic) IBOutlet UIWebView *web;


@end
