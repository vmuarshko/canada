//
//  PartnerConroller.h
//  Jencor
//
//  Created by Teknowledge Software on 02/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerConroller : UIViewController{
    JencorAppDelegate *appDelegate;
    
    BOOL isFetchingData;
    
    NSString *content;
    
    NSString *url;
}
@property (retain, nonatomic) IBOutlet UIWebView *web;

@end
