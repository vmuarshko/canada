//
//  ContactWV.h
//  CanadaGuatantee
//
//  Created by root1 on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactWV : UIViewController <UIWebViewDelegate, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate> {

	IBOutlet UIWebView *contactWVC;
	IBOutlet UILabel *lblTitle;
	IBOutlet UIButton *btnBack;
	
	NSString *strTitle;
    UITableView *table;
    
    //parser required
	BOOL isItem;
 	NSMutableString *strValue;
	NSMutableDictionary *dicItem;
	
	//tbl array
	NSMutableArray *arrItem;
    NSMutableArray *sections;
    
}
@property(nonatomic,retain) NSString *strTitle;



-(IBAction)backBtn;
-(IBAction)settingAction;

@end
