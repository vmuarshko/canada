//
//  WebController.h
//  Jencor
//
//  Created by Ved Prakash on 01/12/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebController : UIViewController<UIWebViewDelegate> {
    
    UIWebView *web;
    JencorAppDelegate *appDelegate;
    
    NSString *strLink;
    NSString *strTitle;
    
}
@property (nonatomic, retain) NSString *strLink;
@property (nonatomic, retain) IBOutlet UIWebView *web;
@property (nonatomic, retain) NSString *strTitle;

@end
