//
//  PickerView.m
//  ModalViewController
//
//  Created by root1 on 02/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PickerView.h"
#import "CanadaGuatanteeAppDelegate.h"

@implementation PickerView

@synthesize picker, btnCancel, btnDone ;

#pragma mark -
#pragma mark === Life Cycle Function ===
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		
		[btnCancel setImage:[UIImage imageNamed:@"cancel1.png"] forState:UIControlStateNormal];
		[btnCancel setImage:[UIImage imageNamed:@"cancel1.png"] forState:UIControlStateHighlighted];
		[btnCancel setImage:[UIImage imageNamed:@"cancel1.png"] forState:UIControlStateSelected];
		
		[btnDone setImage:[UIImage imageNamed:@"done1.png"] forState:UIControlStateNormal];
		[btnDone setImage:[UIImage imageNamed:@"done1.png"] forState:UIControlStateHighlighted];
		[btnDone setImage:[UIImage imageNamed:@"done1.png"] forState:UIControlStateSelected];
		
	}else {
		
		[btnCancel setImage:[UIImage imageNamed:@"cancel2.png"] forState:UIControlStateNormal];
		[btnCancel setImage:[UIImage imageNamed:@"cancel2.png"] forState:UIControlStateHighlighted];
		[btnCancel setImage:[UIImage imageNamed:@"cancel2.png"] forState:UIControlStateSelected];
		
		[btnDone setImage:[UIImage imageNamed:@"done2.png"] forState:UIControlStateNormal];
		[btnDone setImage:[UIImage imageNamed:@"done2.png"] forState:UIControlStateHighlighted];
		[btnDone setImage:[UIImage imageNamed:@"done2.png"] forState:UIControlStateSelected];
	}
	
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden=TRUE;
}
- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
}

#pragma mark -
#pragma mark === Class delegate Function ===
#pragma mark -

-(void)showPicker:(NSArray*)arr :(NSString*)key :(UITableView*)tbl{

	if(tbl){
		tblmain = tbl;
		[tblmain retain];
	}
	
	strKeyName = key;
	[strKeyName retain];
	
	arrItems = [[[NSMutableArray alloc] initWithArray:arr] retain];
	
	[self showModal];
	
	NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:strKeyName];
	[picker selectRow:row inComponent:0 animated:YES];

}

-(IBAction)cancelAct{
	[self hideModal];
}

-(IBAction)doneAct{
	
	NSLog(@"selected row: %@", [arrItems objectAtIndex:selectedIdx]);
	
	if(tblmain)
		[tblmain reloadData];
	
	[[NSUserDefaults standardUserDefaults] setInteger:selectedIdx forKey:strKeyName];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	if ([strKeyName isEqualToString:@"language"]) {
		
		[self.tabBarController.view removeFromSuperview];
		[[NSNotificationCenter defaultCenter] postNotificationName:TABRELOADTEXT object:nil];
		
	}
	
    [[NSNotificationCenter defaultCenter] postNotificationName:@"picker" object:nil];

    
	[self hideModal];
	
}

#pragma mark -
#pragma mark === Model Function ===
#pragma mark -

-(void)showModal{
	
	UIView* modalView=self.view;
	modalView.frame=CGRectOffset(modalView.frame, 0, 0);
	UIWindow* mainWindow = (((CanadaGuatanteeAppDelegate*) [UIApplication sharedApplication].delegate).window);   
	CGPoint middleCenter = modalView.center;   
	CGSize offSize = [UIScreen mainScreen].bounds.size;   
	CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);   
	modalView.center = offScreenCenter;
	//[self.view addSubview:picker];
	// we start off-screen   
	[mainWindow addSubview:modalView];    
	// Show it with a transition effect     
	[UIView beginAnimations:nil context:nil];   
	[UIView setAnimationDuration:0.4]; // animation duration in seconds   
	modalView.center = middleCenter;
	[UIView commitAnimations]; 
	
}

- (void)hideModal{
	
	UIView *modalView =  self.view;
	CGSize offSize = [UIScreen mainScreen].bounds.size;
	CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
	[UIView beginAnimations:nil context:modalView];
	[UIView setAnimationDuration:0.7];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(hideModalEnded:finished:context:)];
	modalView.center = offScreenCenter;
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark === UIPickerView Function ===
#pragma mark -

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [arrItems count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [arrItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	selectedIdx = row;
}

#pragma mark -
#pragma mark === Memory Management Function ===
#pragma mark -

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}
- (void)viewDidUnload {
}

- (void)dealloc {
    [super dealloc];
}


@end
