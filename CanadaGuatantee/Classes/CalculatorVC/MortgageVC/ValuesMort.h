//
//  Values.h
//  AustinTree
//
//  Created by root1 on 11/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ValuesMort : UIViewController {
	IBOutlet UILabel *lblTitle;
	IBOutlet UITableView *tblValues;
	IBOutlet UIButton *btnBack;
    
	NSMutableArray *arrTblVal;
}

@property (nonatomic, assign) NSInteger valueSection;

-(IBAction)settingAction;
-(IBAction)backAction;


@end
