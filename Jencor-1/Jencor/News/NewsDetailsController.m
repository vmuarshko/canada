//
//  NewsDetailsController.m
//  Jencor
//
//  Created by Teknowledge Software on 20/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailsController.h"

@implementation NewsDetailsController
@synthesize news;
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
    
    url=news.link;
    NSLog(@"url is %@",url);
    web.backgroundColor=[UIColor clearColor];
    [self hideGradientBackground:web];
    
    [self addCommonHeaderForView:@"News" modal:NO showBackButton:YES showEmailButton:NO];

    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [appDelegate showHUDinView:self.view andTitle:@"Please wait"];
    web.hidden=TRUE;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    isFetchingData=TRUE;    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if(!webView.isLoading){
        [appDelegate killHUD];
        webView.hidden=FALSE;
        [Utility fadeView:webView];
    }
    
    /*if(!isFetchingData && !parsingFailed){
        [appDelegate killHUD];
        webView.hidden=FALSE;
        [Utility fadeView:webView];
    }else if(!parsingFailed){
        
       // NSRange idRange=[news.link rangeOfString:@"?p="];
        
        //if(idRange.location != NSNotFound){
        
           // NSString *ID=[news.link substringWithRange:NSMakeRange(idRange.location + 3, [news.link length] - idRange.location - 3)];
            
            //NSLog(@"ID %@",ID);
            
            //newsContent=[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('post-%@').innerHTML",ID]];
        
            newsContent=[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];
            
            
            NSRange divStartRange=[newsContent rangeOfString:@"addtoany_share_save_container"];
            
            if(divStartRange.location != NSNotFound)
                newsContent=[newsContent substringWithRange:NSMakeRange(0, divStartRange.location - 12)];
            
            //NSLog(@"Content %@",newsContent);
            
            NSString *HTML=[self getHTMLfromFile:@"news"];
            
            HTML=[HTML stringByReplacingOccurrencesOfString:@"$$$CONTENT$$$" withString:newsContent];
            
            HTML=[HTML stringByReplacingOccurrencesOfString:@"$$$ID$$$" withString:@""];
            
            NSString *fileName = [[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"];
            
            HTML=[HTML stringByReplacingOccurrencesOfString:@"$$$BG_IMAGE$$$" withString:fileName];
            
            [webView loadHTMLString:HTML baseURL:nil];
            
            isFetchingData=FALSE;
        }else{
            parsingFailed=TRUE;
            isFetchingData=FALSE;
            [appDelegate killHUD];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was some error in getting data, please try again!"];
        
        }
        
    }*/
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [appDelegate killHUD];
    
    if(isFetchingData)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"There was some network error, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
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
