//
//  InsuranceVC.m
//  CanadaGuatantee
//
//  Created by root1 on 23/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InsuranceVC.h"
#import "TableCell.h"
#import "PickerView.h"
#import "UICustomSwitch.h"
#import "Values.h"

@implementation InsuranceVC

-(BOOL)isIphone5
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 960) {
                //NSLog(@"iPhone 4 Resolution");
                return NO;
            }
            if(result.height == 1136) {
                //NSLog(@"iPhone 5 Resolution");
                //[[UIScreen mainScreen] bounds].size =result;
                return YES;
            }
        }
        else{
            // NSLog(@"Standard Resolution");
            return NO;
        }
    }
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calculateAction) name:@"picker" object:nil];

    
    if([self isIphone5])
    {
        CGRect frame = tblInsurance.frame;
        frame.size.height = 360;
        tblInsurance.frame = frame;
    }
    else
    {
        CGRect frame = tblInsurance.frame;
        frame.size.height = 280;
        tblInsurance.frame = frame;
    }
    
	lblTitle.text = [self getString:@"Insurance Premium Calculator"];

	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateSelected];
		
		[btnCalculate setImage:[UIImage imageNamed:@"calculate1.png"] forState:UIControlStateNormal];
		[btnCalculate setImage:[UIImage imageNamed:@"calculate1.png"] forState:UIControlStateHighlighted];
		[btnCalculate setImage:[UIImage imageNamed:@"calculate1.png"] forState:UIControlStateSelected];
		
	}else {
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateSelected];
		
		[btnCalculate setImage:[UIImage imageNamed:@"calculate2.png"] forState:UIControlStateNormal];
		[btnCalculate setImage:[UIImage imageNamed:@"calculate2.png"] forState:UIControlStateHighlighted];
		[btnCalculate setImage:[UIImage imageNamed:@"calculate2.png"] forState:UIControlStateSelected];
		
	}
	
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
		arrInsurance = [[[NSMutableArray alloc] initWithObjects:@"Insurance Products:",@"Down Payment:",@"Purchase Price $:",@"Amortization:",nil]retain];
	else
		arrInsurance = [[[NSMutableArray alloc] initWithObjects:@"Produits d'assurance:",@"Mise de fonds:",@"Prix de vente $:",@"Amortissement:",nil]retain];
	
	arrInsuranceValue = [[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",nil]retain];

	NSArray *arr1 = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];
	NSArray *arr2 = [NSArray arrayWithObjects:@"5",nil];
	NSArray *arr3 = [NSArray arrayWithObjects:@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",nil];
	NSArray *arr4 = [NSArray arrayWithObjects:@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",nil];
	
	arrInsuranceRate = [[[NSMutableArray alloc] initWithObjects:arr1,arr2,arr3,arr4,nil] retain];
	
	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"switch"];
	[[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"amortization"];
	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"insurancetype"];
	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"insurancerate"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
}

-(void)viewWillAppear:(BOOL)animated{
	
	[super viewWillAppear:YES];
    
    BOOL isEmpty = FALSE;
	for(NSString *strVal in arrInsuranceValue){
		if([strVal length] == 0){
			isEmpty = TRUE;
			//[self showAlert:[self getString:@"Warning!"] :[self getString:@"Please Enter Some Value."]];
			break;
		}
	}
	if(!isEmpty)
    {
        [self calculateAction];
        
    }

    
    
	[tblInsurance reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)settingAction{
	[self showSettings];
}

-(IBAction)calculateAction{
	
	BOOL isEmpty = FALSE;
	for(NSString *strVal in arrInsuranceValue){
		if([strVal length] == 0){
			isEmpty = TRUE;
			[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please ensure all fields are completed."]];
			break;
		}
	}
	if(isEmpty)
		return;
	
	else{
		
		double downPay = [[arrInsuranceValue objectAtIndex:1] doubleValue];
//		if([[NSUserDefaults standardUserDefaults] integerForKey:@"switch"] == 0){
//			if(downPay>100){
//				[self showAlert:[self getString:@"Warning!"] :[self getString:@"Down Payment Rate should not exceed 100."]];
//				return;
//			}
//		}

		double purchasePrice = [[arrInsuranceValue objectAtIndex:2] doubleValue];
		
		double finalLoadAmt;
//		if ([[NSUserDefaults standardUserDefaults] integerForKey:@"switch"] == 0){
//			NSLog(@"switch off '%' val");
//			finalLoadAmt = purchasePrice - (purchasePrice * downPay / 100);
//		}else {
//			NSLog(@"switch on $ val");
//			finalLoadAmt = purchasePrice - downPay;
//		}

		finalLoadAmt = purchasePrice - round(purchasePrice * downPay / 100);
		
		loanAmt = finalLoadAmt;
		
		//type rate(LVR) amort(term)
		NSString *strInsType = [arrInsuranceValue objectAtIndex:0];
		double insRate = downPay;		//[[arrInsuranceValue objectAtIndex:1] doubleValue];
		double amortTerm = [[[arrInsuranceValue objectAtIndex:3] substringToIndex:2] doubleValue];

		//Premium rate
		double singlePrem = [self getSinglePre:strInsType :insRate :amortTerm];

		//premium amount //loanamount * singlepremium / 100
		double premiumAmt = (finalLoadAmt * singlePrem) / 100; 
//		if ([[NSUserDefaults standardUserDefaults] integerForKey:@"switch"] == 0){
//			premiumAmt = (finalLoadAmt * downPay) / 100;
//		}else {
//			NSLog(@"down payment:  %f", downPay);
//			premiumAmt = (downPay * singlePrem) / 100;
//		}
		
		[self setResult:singlePrem :premiumAmt];
		//TODO: calculate the values here
	}
	
}

-(double)getSinglePre:(NSString*)type :(double)LVR :(double)term{

	LVR = 100 - LVR;
	
	double premium = 0.0;
	
	NSInteger ix = [[NSUserDefaults standardUserDefaults] integerForKey:@"insurancetype"];
	switch (ix) {
		case 0:
				if (LVR <= 65) premium = .6;
				else if ((LVR > 65) && (LVR <= 75)) premium = .75;
				else if ((LVR > 75) && (LVR <= 80)) premium = 1.25;
				else if ((LVR > 80) && (LVR <= 85)) premium = 1.80;
				else if ((LVR > 85) && (LVR <= 90)) premium = 2.40;
				else if ((LVR > 90) && (LVR <= 95)) premium = 3.60;
			
			break;
		case 1:
                if (LVR <= 65) premium = .5;
                else if ((LVR > 65) && (LVR <= 75)) premium = .65;
                else if ((LVR > 75) && (LVR <= 80)) premium = 1.0;
                else if ((LVR > 80) && (LVR <= 85)) premium = 1.75;
                else if ((LVR > 85) && (LVR <= 90)) premium = 2.0;
                else if ((LVR > 90) && (LVR <= 95)) premium = 3.85;
			break;
		case 2:
				if (LVR <= 65) premium = .9;
				else if ((LVR > 65) && (LVR <= 75)) premium = 1.15;
				else if ((LVR > 75) && (LVR <= 80)) premium = 1.90;
				else if ((LVR > 80) && (LVR <= 85)) premium = 3.35;
				else if ((LVR > 85) && (LVR <= 90)) premium = 5.45;
			break;
		case 3:
				if (LVR <= 65) premium = 1.45;
				else if ((LVR > 65) && (LVR <= 75)) premium = 2.0;
				else if ((LVR > 75) && (LVR <= 80)) premium = 2.90;
			break;
	}
	
	if ((term > 25) && (term <= 30)) premium = premium + 0.25;
	else if ((term > 30) && (term <= 35)) premium = premium + 0.4;

	return premium;
}

-(void)setResult:(double)premRate :(double)premAmt{
	
	if([arrInsurance count]>5){
		for (int x=1;x<4; x++) {
			[arrInsurance removeLastObject];
			[arrInsuranceValue removeLastObject];
		}
	}
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		
		[arrInsurance addObject:@"Loan Amount:"];
		[arrInsurance addObject:@"Premium Rate:"];
		[arrInsurance addObject:@"Premium Amount:"];
		
	}else {
		[arrInsurance addObject:@"Montant du prêt:"];
		[arrInsurance addObject:@"Taux de la prime:"];
		[arrInsurance addObject:@"Montant de la prime:"];
	}
	
	if (premRate > 0) {
		[arrInsuranceValue addObject:[NSString stringWithFormat:@"$ %.2f", loanAmt]];
		NSString *str = @"%";
		[arrInsuranceValue addObject:[NSString stringWithFormat:@"%.2f %@", premRate, str]];
		[arrInsuranceValue addObject:[NSString stringWithFormat:@"$ %.2f", premAmt]];
	}else {
		[arrInsuranceValue addObject:@"$ 0.0"];
		[arrInsuranceValue addObject:@"0.0 %"];
		[arrInsuranceValue addObject:@"$ 0.0"];
	}
	
	[arrInsurance retain];
	[arrInsuranceValue retain];
	
	[tblInsurance reloadData];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[arrInsurance count]-1 inSection:0];
	[tblInsurance scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
	
}




#pragma mark -
#pragma mark - Table view methods
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if(indexPath.row == 99 )
		return 70;
	else if(indexPath.row == 3 || indexPath.row == 2)
		return 45;
	else if(indexPath.row == 0)
		return 50;
	else
		return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrInsurance count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	int rowId = indexPath.row;
	
	if(rowId == 99 ){
		
		CellIdentifier = @"PickerCell";
		TableCell *cell = (TableCell *)[tblInsurance dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			UIViewController* controller = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
			cell = (TableCell *) controller.view;
			[controller release];
			cell.lblTitle.textColor = [UIColor darkGrayColor];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		}
		
		UICustomSwitch *custSwitch = [[UICustomSwitch alloc] init];
		custSwitch.frame = CGRectMake(216, 5, custSwitch.frame.size.width, custSwitch.frame.size.height);
		custSwitch.rightLabel.text = @"% Val";
		custSwitch.leftLabel.text = @"$ Amt";
		[custSwitch addTarget:self action:@selector(toggleRadio:) forControlEvents:UIControlEventValueChanged];

		if ([[NSUserDefaults standardUserDefaults] integerForKey:@"switch"] == 0)
			custSwitch.on = NO;
		else
			custSwitch.on = YES;
		
		[cell addSubview:custSwitch];
		
		cell.textField.delegate = self;
		cell.textField.tag = rowId;
			
		cell.lblTitle.text = [arrInsurance objectAtIndex:rowId];
		cell.textField.text = [arrInsuranceValue objectAtIndex:rowId];

		return cell;

	}else if(rowId == 2){
		
		CellIdentifier = @"EnglishCell";
		TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			UIViewController* controller = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
			cell = (TableCell *) controller.view;
			[controller release];
			cell.lblTitle.textColor = [UIColor darkGrayColor];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		}
		cell.textField.delegate = self;
		cell.textField.tag = rowId;
		
		cell.textField.text = [arrInsuranceValue objectAtIndex:rowId];
		
		cell.lblTitle.text = [arrInsurance objectAtIndex:rowId];
		
		cell.lblDesc.hidden = YES;

		return cell;
	
	}else if(rowId == 0){	
		
		if (rowId == 0) {
			NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"insurancetype"];
			NSArray *arr;
			if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
				arr  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Flex 95 Advantage",@"Low Doc Advantage (Self-Employed)",@"Rental Advantage",nil];
			else
				arr  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Flex 95",@"Avantage Autonome (Travailleurs autonomes)",@"Avantage Locatif",nil];
			[arrInsuranceValue replaceObjectAtIndex:rowId withObject:[arr objectAtIndex:ii]];
		}

		CellIdentifier = @"MyBigCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:15];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
			cell.textLabel.textColor = [UIColor darkGrayColor];
			cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:15];
			cell.detailTextLabel.textColor = [UIColor darkGrayColor];
		}
		cell.textLabel.text = [arrInsurance objectAtIndex:rowId];
		cell.detailTextLabel.text =[arrInsuranceValue objectAtIndex:rowId];
		
		return cell;
	}else{
		
		if(rowId == 1){

			NSInteger ii = 0;//(NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"insurancetype"];
			NSArray *arr = [arrInsuranceRate objectAtIndex:0];
			ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"insurancerate"];
			[arrInsuranceValue replaceObjectAtIndex:rowId withObject:[arr objectAtIndex:ii]];
			
		}
		
		if(rowId == 3){
			
			NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"amortization"];
			NSArray *arr;
            if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0){
                if([arrInsuranceValue[0] isEqualToString:@"Flex 95 Advantage"])
                {
                    arr  = [NSArray arrayWithObjects:@"5 Years",@"10 Years",@"15 Years",@"20 Years",@"25 Years",nil];

                }
                else
                {
                    arr  = [NSArray arrayWithObjects:@"5 Years",@"10 Years",@"15 Years",@"20 Years",@"25 Years",@"30 Years",nil];

                }
            }
			else
            {
                if([arrInsuranceValue[0] isEqualToString:@"Avantage Flex 95"])
                {
                    arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",nil];

                }
                else
                {
                    arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",@"30 Ans",nil];

                }

                
                

            }
			[arrInsuranceValue replaceObjectAtIndex:rowId withObject:[arr objectAtIndex:ii]];
			
		}
		
		CellIdentifier = @"MyCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
			cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:15];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
			cell.textLabel.textColor = [UIColor darkGrayColor];
			cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:15];
		}
		cell.textLabel.text = [arrInsurance objectAtIndex:rowId];
		
		
		if(rowId == 3){
			cell.detailTextLabel.text = [arrInsuranceValue objectAtIndex:rowId];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}else if(rowId == 1){
			NSString *str = @"%";
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",[arrInsuranceValue objectAtIndex:rowId],str];
			cell.accessoryType = UITableViewCellAccessoryNone;
		}else {
			cell.detailTextLabel.text = [arrInsuranceValue objectAtIndex:rowId];
			cell.accessoryType = UITableViewCellAccessoryNone;
		}

		if(rowId > 3){
			UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calc_bar.png"]];
			imgView.contentMode = UIViewContentModeScaleToFill;
			cell.backgroundView = imgView;
		}else {
			cell.backgroundView = nil;
		}
		
		return cell;
	}
}

-(void)toggleRadio:(id)sender{
	
	UISwitch *myswitch = sender;
	if (myswitch.on) 
		[[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"switch"];
	else
		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"switch"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
	
	int rowid = indexPath.row;
	
	if(txt){
		CGRect rc = [txt bounds];
		UITableView * v = tblInsurance;
		rc = [txt convertRect:rc toView:v];
		CGPoint pt = rc.origin ;
		pt.y = 0 ;
		pt.x = 0;
		[v setContentOffset:pt animated:YES];
		[txt resignFirstResponder];
		
//		if(txt.tag == 1){
//			double downPay = [[arrInsuranceValue objectAtIndex:2] doubleValue];
//			if(downPay>100)
//				[self showAlert:[self getString:@"Warning!"] :@"Interest Rate should not exceed 100."];
//			
//			//			else if(![self validateNo:[arrMortgageValue objectAtIndex:3]])
//			//				[self showAlert:[self getString:@"Warning!"] :@"Please enter valid number."];
//		}
		
	}
	
	[txt resignFirstResponder];
	
	if(rowid == 0){
		
		Values *val = [[Values alloc] initWithNibName:@"Values" bundle:nil];
		[self.navigationController pushViewController:val animated:YES];
		
//		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
//		[picker showPicker:[NSArray arrayWithObjects:@"Standard(Down Payment Advantage)",@"Flex 95 Advantage",@"Low Doc Advantage (Self-Employed)",@"Rental Advantage",nil]
//						  :@"insurancetype" :tblInsurance];

	}else if (rowid == 1) {
	
		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"insurancetype"];
		NSArray *arr = [arrInsuranceRate objectAtIndex:0];
		[picker showPicker:arr :@"insurancerate" :tblInsurance];
		
	}else if(rowid == 3){
	
		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		NSArray *arr;
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0){
            if([arrInsuranceValue[0] isEqualToString:@"Flex 95 Advantage"])
            {
                arr  = [NSArray arrayWithObjects:@"5 Years",@"10 Years",@"15 Years",@"20 Years",@"25 Years",nil];
                
            }
            else
            {
                arr  = [NSArray arrayWithObjects:@"5 Years",@"10 Years",@"15 Years",@"20 Years",@"25 Years",@"30 Years",nil];
                
            }
        }
        else
        {
            if([arrInsuranceValue[0] isEqualToString:@"Avantage Flex 95"])
            {
                arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",nil];
                
            }
            else
            {
                arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",@"30 Ans",nil];
                
            }
            
            
            
            
        }
		
		[picker showPicker:arr 
						  :@"amortization" :tblInsurance];
	}
	
}

- (void)deselect{   
	[tblInsurance deselectRowAtIndexPath:[tblInsurance indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark - UITextField Lifecycle Methods 
#pragma mark -

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	
	CGRect rc = [textField bounds];
	UITableView * v = tblInsurance;
	rc = [textField convertRect:rc toView:v];
	CGPoint pt = rc.origin ;
	pt.y = 0 ;
	pt.x = 0;
	[v setContentOffset:pt animated:YES];
	[textField resignFirstResponder];
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
	
	txt =textField;
	[txt retain];

	tblInsurance.scrollEnabled = NO;
	//	NSLog(@"Selected TextField is %d", textField.tag);
	CGRect rc = [textField bounds];
	UITableView * v = tblInsurance;
	rc = [textField convertRect:rc toView:v];
	CGPoint pt = rc.origin ;
	pt.y = pt.y - 50;
	pt.x = 0 ;
	[v setContentOffset:pt animated:YES];
}        

- (void) textFieldDidEndEditing:(UITextField *)textField{
	
	tblInsurance.scrollEnabled = YES;
	if ( textField ){
		int tID = textField.tag;
		if ( textField.text ){
			
//			if(textField.tag == 1){
//				double downPay = [textField.text doubleValue];
//				NSInteger ii = [[NSUserDefaults standardUserDefaults] integerForKey:@"switch"];
//				if(downPay>100 && ii == 0)
//					[self showAlert:[self getString:@"Warning!"] :[self getString:@"Down Payment Rate should not exceed 100%."]];
//			}
			
			[arrInsuranceValue replaceObjectAtIndex:tID withObject:textField.text];		
		}
	}
	if([textField isFirstResponder])
		[textField resignFirstResponder];
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