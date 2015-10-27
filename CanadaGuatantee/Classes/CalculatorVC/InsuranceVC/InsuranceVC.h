//
//  InsuranceVC.h
//  CanadaGuatantee
//
//  Created by root1 on 23/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InsuranceVC : UIViewController <UITextFieldDelegate>{
	IBOutlet UITableView *tblInsurance;
	IBOutlet UILabel *lblTitle;
	IBOutlet UIButton *btnBack;
	IBOutlet UIButton *btnCalculate;

	NSMutableArray *arrInsurance;
	NSMutableArray *arrInsuranceValue;

	UITextField *txt;

	NSMutableArray *arrInsuranceRate;
	
	double loanAmt;
	
}
-(IBAction)settingAction;
-(IBAction)backAction;
-(IBAction)calculateAction;

-(void)setResult:(double)monthly :(double)premAmt;
-(double)getSinglePre:(NSString*)type :(double)LVR :(double)term;

@end
