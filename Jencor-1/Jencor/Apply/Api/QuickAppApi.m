//
//  QuickAppApi.m
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "QuickAppApi.h"


@implementation QuickAppApi
@synthesize data,parent;

- (void)dealloc {
    [data release];
    [parent release];
    [super dealloc];
}
- (id)init {
    self = [super init];
    if (self) {
        appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


-(void)makeRequest{

    NSString *url=QUICK_URL;
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setDelegate:self];
    
    [request setPostValue:data forKey:@"data"];
    
    [request start];
    
    [appDelegate showHUDinView:parent.view andTitle:NSLocalizedString(@"Please wait..", nil)];

}


-(void)requestFinished:(ASIHTTPRequest *)request{

    NSString *response=[request responseString];
    
    response=[response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSLog(@"Response %@",response);
    
    [appDelegate killHUD];
    
    if([response isEqualToString:@"1"]){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Request sent successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        //[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Request sent successfully."];
            
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"There was some unexpected error, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
        
       // [[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was some unexpected error, please try again!"];
        

}


-(void)requestFailed:(ASIHTTPRequest *)request{


    [appDelegate killHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"There was some unexpected error, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    //[[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was a network error, please try again!"];
}



@end
