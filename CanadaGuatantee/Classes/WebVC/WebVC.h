//
//  WebVC.h
//  CanadaGuatantee
//
//  Created by root1 on 25/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	IBOutlet UIImageView *imgTitle;

	IBOutlet UILabel *lblTitle;
	IBOutlet UIButton *btnBack;
	
	NSDictionary *dic;
	
	NSString *strTitle;
	NSString *strImage;
}

@property(nonatomic,retain) NSString *strTitle;
@property(nonatomic,retain) NSString *strImage;
@property(nonatomic,retain) NSDictionary *dic;

-(IBAction)backAction;
-(IBAction)settingAction;

-(void)openNews;
-(void)openProduct;

@end
