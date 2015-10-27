//
//  QuickAppApi.h
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


@interface QuickAppApi : NSObject<ASIHTTPRequestDelegate> {
    NSString *data;
    JencorAppDelegate *appDelegate;
    UIViewController *parent;
}
@property(nonatomic,retain)UIViewController *parent;
@property(nonatomic,retain)NSString *data;
-(void)makeRequest;
@end
