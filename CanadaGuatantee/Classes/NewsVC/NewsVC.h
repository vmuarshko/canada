//
//  NewsVC.h
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsVC : UIViewController <NSXMLParserDelegate>
{
	IBOutlet UITableView *tblNews;
	IBOutlet UILabel *lblTitle;
	
	//parser required
	BOOL isItem;
 	NSMutableString *strValue;
	NSMutableDictionary *dicItem;
	
	//tbl array
	NSMutableArray *arrItem;
	
}

-(IBAction)settingAction;


@end
