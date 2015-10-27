//
//  ProductsVC.h
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductsVC : UIViewController <NSXMLParserDelegate>{
	IBOutlet UITableView *tblProducts;
	IBOutlet UILabel *lblTitle;

	//parser required
	BOOL isItem;
 	NSMutableString *strValue;
	NSMutableDictionary *dicItem;
	
	//tbl array
	NSMutableArray *arrItem;
	
	NSMutableArray *arrPointData;
	NSMutableArray *arrPoints;
	NSMutableDictionary *dicPoint;
	
	NSMutableArray *arrPremiums;
	NSMutableDictionary *dicPremium;
}
-(IBAction)settingAction;
@end
