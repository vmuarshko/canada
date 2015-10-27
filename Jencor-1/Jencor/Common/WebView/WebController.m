//
//  WebController.m
//  Jencor
//
//  Created by Ved Prakash on 01/12/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "WebController.h"


@implementation WebController
@synthesize web,strLink,strTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [web release];
    [strTitle release];
    [strLink release];
    [super dealloc];
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
    
    self.navigationController.navigationBarHidden=TRUE;
    
    [Utility fadeView:self.view];
    
    //strTitle=@"Contact";
    
    [self addCommonHeaderForView:strTitle?strTitle:@"Website" modal:YES showBackButton:YES showEmailButton:NO];
    
    [self hideGradientBackground:web];
    
    if(strLink)
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strLink]]];
    else
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEBSITE_URL]]];
    
    web.hidden=TRUE;
    
    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate showHUDinView:self.view andTitle:NSLocalizedString(@"Please wait", nil)];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    if(!webView.loading){
    
        [appDelegate killHUD];
        webView.hidden=FALSE;
        [Utility fadeView:webView];
    
    }

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [appDelegate killHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:NSLocalizedString(@"Couldn't open website, please try again", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];

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

@end
