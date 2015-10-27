//
//  WebVC.m
//  CanadaGuatantee
//
//  Created by root1 on 25/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebVC.h"


@implementation WebVC

@synthesize dic;
@synthesize strTitle, strImage;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	imgTitle.image = [UIImage imageNamed:strImage];
	lblTitle.text = [self getString:strTitle];
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateSelected];
	}else {
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateSelected];
	}

	if([strTitle isEqualToString:@"INSURANCE PRODUCTS"])
		[self openProduct];
	else
		[self openNews];
}

-(void)openProduct{

	NSString *path = [[NSBundle mainBundle] pathForResource:@"ProductWeb" ofType:@"html"];
	NSError *error;
	NSString *filebuf = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error ]; 
	
	if(dic && [dic count] > 0){
	
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"CATEGORY" withString:[dic objectForKey:@"category"]];
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"TITLE" withString:[dic objectForKey:@"title"]];
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"SUBT" withString:[dic objectForKey:@"subtitle"]];
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"DESCRIPTION" withString:[dic objectForKey:@"description"]];

		//
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"LVR" withString:[self getString:@"Loan-to-Value Ratio"]];
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"SP" withString:[self getString:@"Single Premium"]];
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"TP" withString:[self getString:@"Top-Up Premium"]];
		
		//POINTDATA
		
		NSMutableArray *arrPointData = [dic objectForKey:@"productsheetdata"];
		
		NSMutableString *strFinalPoints = [[NSMutableString alloc] init];
		
		for(NSDictionary *dic1 in arrPointData){
		
			NSString *strPointTitle = [NSString stringWithFormat:@"<div class=\"pointTitle\"><strong>%@</strong></div>", [dic1 objectForKey:@"pointtitle"]];
			NSMutableString *strPointDesc = [[NSMutableString alloc] initWithString:@"<ul class=\"ul\">"];
			NSMutableArray *arrPoints = [dic1 objectForKey:@"points"];
			for(NSString *strPoints in arrPoints){
				[strPointDesc appendFormat:@"<li>%@</li>", strPoints];
			}
			[strPointDesc appendString:@"</ul>"];	
			
			NSString *strNotes = [NSString stringWithFormat:@"<div class=\"pointNotes\">%@</div><br/>", [dic1 objectForKey:@"pointnotes"]];
			
			[strFinalPoints appendFormat:@"<div class=\"point\">%@%@%@</div>",strPointTitle, strPointDesc,strNotes];
		}
		
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"POINTDATA" withString:strFinalPoints];
	
		//PREMIUMS
		NSMutableString *strFinalPremium;
		if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
			strFinalPremium = [[NSMutableString alloc] initWithString:@"<div class=\"pointTitle\"><strong>Applicable Premiums</strong></div>"];
		else
			strFinalPremium = [[NSMutableString alloc] initWithString:@"<div class=\"pointTitle\"><strong>Primes établies</strong></div>"];
		
		NSMutableArray *arrPrem = [dic objectForKey:@"applicationpremiums"];
		for(NSDictionary *dic2 in arrPrem){
		
			NSMutableString *strPremium = [[NSMutableString alloc] initWithString:@""];
			
			[strPremium appendString:@"<tr>"];
			
			[strPremium appendString:@"<td>"];
			[strPremium appendString:[dic2 objectForKey:@"ltv"]];
			[strPremium appendString:@"</td>"];
			
			[strPremium appendString:@"<td>"];
			[strPremium appendString:[dic2 objectForKey:@"singlepremium"]];
			[strPremium appendString:@"</td>"];
			
			[strPremium appendString:@"<td>"];
			[strPremium appendString:[dic2 objectForKey:@"topup"]];
			[strPremium appendString:@"</td>"];
			
			[strPremium appendString:@"</tr>"];
			
			[strFinalPremium appendString:strPremium];
		}
		
		
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"PREMIUMS" withString:strFinalPremium];
	}
	
	[webView loadHTMLString:filebuf baseURL:nil];
	webView.delegate = self;
	webView.scalesPageToFit = TRUE;
	
}

-(void)openNews{
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"web" ofType:@"html"];
	NSError *error;
	NSString *filebuf = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error ]; 
	
	if(dic && [dic count] > 0){
		
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"TITLE" withString:[dic objectForKey:@"title"]];
		
		NSString *strDesc = [dic objectForKey:@"content:encoded"];
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"SUBT" withString:[dic objectForKey:@"pubDate"]];
		
		strDesc = [strDesc stringByReplacingOccurrencesOfString:@"(Download to print PDF)" withString:@" "];
		strDesc = [strDesc stringByReplacingOccurrencesOfString:@"(Download to view complete PDF)" withString:@" "];
		filebuf = [filebuf stringByReplacingOccurrencesOfString:@"DESCRIPTION" withString:strDesc];
	}
	
	[webView loadHTMLString:filebuf baseURL:nil];
	webView.delegate = self;
	webView.scalesPageToFit = TRUE;
	
	
}

-(IBAction)settingAction{
	[self showSettings];
}


-(IBAction)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark === UIWebView delegates
#pragma mark -

- (BOOL)webView:(UIWebView *)mywebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark -
#pragma mark === memory methods
#pragma mark -


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {}

- (void)dealloc {
    [super dealloc];
	if(dic)
		dic = nil;
	
	if(lblTitle)
		lblTitle = nil;
	
	if(imgTitle)
		imgTitle = nil;
}


@end
