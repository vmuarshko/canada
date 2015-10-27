//
//  PartnerConroller.m
//  Jencor
//
//  Created by Teknowledge Software on 02/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "PartnerConroller.h"

@implementation PartnerConroller
@synthesize web;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    url=PARTNERS_URL;
    web.backgroundColor=[UIColor clearColor];
    [self hideGradientBackground:web];
    
    [self addCommonHeaderForView:@"Partners" modal:NO showBackButton:YES showEmailButton:NO];
    
    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [appDelegate showHUDinView:self.view andTitle:@"Please wait"];
    web.hidden=TRUE;
    
    //NSString *HTML=[self getHTMLfromFile:@"partners"];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    //[web loadHTMLString:HTML baseURL:nil];
    
    isFetchingData=FALSE;    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if(!isFetchingData){
        [appDelegate killHUD];
        webView.hidden=FALSE;
        [Utility fadeView:webView];
    }else{
        
        
        content=[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('page_body').innerHTML"];
        
        
       /* NSRange divStartRange=[content rangeOfString:@"addtoany_share_save_container"];
        
        content=[content substringWithRange:NSMakeRange(0, divStartRange.location - 12)];*/
        
        //NSLog(@"Content %@",newsContent);
        
        NSString *HTML=[self getHTMLfromFile:@"partners"];
        
        HTML=[HTML stringByReplacingOccurrencesOfString:@"$$$CONTENT$$$" withString:content];
        
        
        [webView loadHTMLString:HTML baseURL:nil];
        
        isFetchingData=FALSE;
        
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [appDelegate killHUD];
    
    if(isFetchingData)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"There was some network error, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
        //[[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was some network error, please try again!"];
    
}

- (void)viewDidUnload
{
    [self setWeb:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [web release];
    [super dealloc];
}
@end
