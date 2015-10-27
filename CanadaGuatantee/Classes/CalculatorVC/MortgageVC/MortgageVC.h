//
//  MortgageVC.h
//  CanadaGuatantee
//
//  Created by root1 on 23/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MortgageVC : UIViewController <UITextFieldDelegate> {

	IBOutlet UITableView *tblMortgage;
	IBOutlet UILabel *lblTitle;

	IBOutlet UIButton *btnBack;
	IBOutlet UIButton *btnCalculate;

	NSMutableArray *arrMortgage;
	NSMutableArray *arrMortgageValue;

	UITextField *txt;
	
}

-(IBAction)backAction;
-(IBAction)settingAction;

-(IBAction)calculateAction;
-(void)setResult:(double)monthly;

@end
