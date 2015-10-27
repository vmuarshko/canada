//
//  CalculatorsVC.m
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorsVC.h"
#import "MortgageVC.h"
#import "InsuranceVC.h"

@implementation CalculatorsVC

- (void)viewDidLoad {
    [super viewDidLoad];
	lblTitle.text = [self getString:@"CALCULATORS"];
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		[btnMPC setImage:[UIImage imageNamed:@"mort1.png"] forState:UIControlStateNormal];
		[btnMPC setImage:[UIImage imageNamed:@"mort1.png"] forState:UIControlStateHighlighted];
		[btnMPC setImage:[UIImage imageNamed:@"mort1.png"] forState:UIControlStateSelected];

		[btnIPC setImage:[UIImage imageNamed:@"ins1.png"] forState:UIControlStateNormal];
		[btnIPC setImage:[UIImage imageNamed:@"ins1.png"] forState:UIControlStateHighlighted];
		[btnIPC setImage:[UIImage imageNamed:@"ins1.png"] forState:UIControlStateSelected];
		
	}else {
		
		[btnMPC setImage:[UIImage imageNamed:@"mort2.png"] forState:UIControlStateNormal];
		[btnMPC setImage:[UIImage imageNamed:@"mort2.png"] forState:UIControlStateHighlighted];
		[btnMPC setImage:[UIImage imageNamed:@"mort2.png"] forState:UIControlStateSelected];

		[btnIPC setImage:[UIImage imageNamed:@"ins2.png"] forState:UIControlStateNormal];
		[btnIPC setImage:[UIImage imageNamed:@"ins2.png"] forState:UIControlStateHighlighted];
		[btnIPC setImage:[UIImage imageNamed:@"ins2.png"] forState:UIControlStateSelected];
	}
	
}

-(IBAction)mpcAction{
	MortgageVC *mpcObj = [[MortgageVC alloc] initWithNibName:@"MortgageVC" bundle:nil];
	[self.navigationController pushViewController:mpcObj animated:YES];
}

-(IBAction)ipcAction{
	InsuranceVC *ipcObj = [[InsuranceVC alloc] initWithNibName:@"InsuranceVC" bundle:nil];
	[self.navigationController pushViewController:ipcObj animated:YES];
}

-(IBAction)settingAction{
	[self showSettings];
}



#pragma mark -
#pragma mark === Memory Management Function ===
#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {}


- (void)dealloc {
    [super dealloc];
}

@end
