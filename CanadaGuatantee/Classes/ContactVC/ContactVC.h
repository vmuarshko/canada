//
//  ContactVC.h
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactVC : UIViewController {
	IBOutlet UITableView *tblContact;
	IBOutlet UILabel *lblTitle;

	NSArray *arrContacts;
}
-(IBAction)settingAction;
@end
