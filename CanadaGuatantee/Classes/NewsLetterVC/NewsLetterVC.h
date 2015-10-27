//
//  NewsLetterVC.h
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsLetterVC : UIViewController <UIWebViewDelegate>{

	IBOutlet UITableView *tblNewsletter;
	IBOutlet UILabel *lblTitle;

	IBOutlet UIButton *btnSignup;
	
	NSMutableArray *arrLetter;
	NSMutableArray *arrLetterValue;
	
	UITextField *txt;
    IBOutlet UIWebView *webView;
	
}

-(void)setValues;

-(IBAction)signupAction;
-(BOOL)validateEmail:(NSString*)email;
-(IBAction)settingAction;

//@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
