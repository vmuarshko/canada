//
//  MortgageVC.m
//  CanadaGuatantee
//
//  Created by root1 on 23/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MortgageVC.h"
#import "TableCell.h"
#import "PickerView.h"
#import "ValuesMort.h"
@implementation MortgageVC
{
    double loanAmt;

}
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


-(void)viewWillAppear:(BOOL)animated{
	
	[super viewWillAppear:YES];
    
    
    BOOL isEmpty = FALSE;
	for(NSString *strVal in arrMortgageValue){
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
    
    [tblMortgage reloadData];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self isIphone5])
    {
        CGRect frame = tblMortgage.frame;
        frame.size.height = 360;
        tblMortgage.frame = frame;
    }
    else
    {
        CGRect frame = tblMortgage.frame;
        frame.size.height = 280;
        tblMortgage.frame = frame;
    }
    
	lblTitle.text = [self getString:@"Mortgage Payment Calculator"];

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
		arrMortgage = [[[NSMutableArray alloc] initWithObjects:@"* Purchase Price $:",@"* Down Payment:",@"Initial Mortgage Amount:",@"* Insurance Products:",@"Premium Rate:", @"Premium Amount:", @"Total Mortgage Amount:", @"* Interest Rate:",  @"* Term:",@"* Amortization:",nil]retain];
	else
		arrMortgage = [[[NSMutableArray alloc] initWithObjects:@"* Prix de vente $:",@"* Mise de fonds:",@"Montant de l'emprunt hypothécaire:",@"* Produits d'assurance:",@"Taux de la prime:",@"Montant de la prime:",@"Montant total de prêts hypothécaires:", @"* Taux:",  @"* Terme:",@"* Amortissement:",nil]retain];
	
	arrMortgageValue = [[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",[NSString stringWithFormat:@"%.2f %@", 0.0, @""], [NSString stringWithFormat:@"$ %.2f", 0.0], [NSString stringWithFormat:@"$ %.2f", 0.0], @"", @"",@"",nil]retain];
	

    
    
	[[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"term"];
	[[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"amortization"];
    [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"down"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"products"];

	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

-(IBAction)backAction{
	[self.navigationController popViewControllerAnimated:YES];

}

-(IBAction)settingAction{
	[self showSettings];
}

-(IBAction)calculateAction{
	
	BOOL isEmpty = FALSE;
	for(NSString *strVal in arrMortgageValue){
		if([strVal length] == 0){
			isEmpty = TRUE;
			[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please ensure all fields are completed."]];
			break;
		}
	}
	if(isEmpty)
		return;
	else{
		//double purchasePrice = [[arrMortgageValue objectAtIndex:0] doubleValue];	//mcPrice

		
        
        
        double downPay = [[arrMortgageValue objectAtIndex:1] doubleValue];
        double purchasePrice = [[arrMortgageValue objectAtIndex:0] doubleValue];
		
		double finalLoadAmt;
        
		finalLoadAmt = purchasePrice - round(purchasePrice * downPay / 100);
		
		loanAmt = finalLoadAmt;
		
		//type rate(LVR) amort(term)
		NSString *strInsType = [arrMortgageValue objectAtIndex:3];
		double insRate = downPay;
		double amortTerm = [[[arrMortgageValue objectAtIndex:9] substringToIndex:2] doubleValue];
        
		//Premium rate
		double singlePrem = [self getSinglePre:strInsType :insRate :amortTerm];
    
		//premium amount //loanamount * singlepremium / 100
		double premiumAmt = (finalLoadAmt * singlePrem) / 100;
        
        
        double amt = premiumAmt + loanAmt;	//mcPrice
		double rate = [[arrMortgageValue objectAtIndex:7] doubleValue];		//mcRate
		double years = [[[arrMortgageValue objectAtIndex:9] substringToIndex:2] doubleValue];	//mcAmort
		
		double itwoval = pow((1+ rate/200), 0.16666667);
		double payamt = (amt * (itwoval -1) / (1 - (pow(itwoval, -(years*12)))));
        
        
        
        
		if (payamt) {
			NSLog(@"monthlyAmt :%f", payamt);
            [self setResult:payamt premRate:singlePrem == 0 ? rate : singlePrem premAmt:premiumAmt ];
		}else{
			NSLog(@"monthlyAmt error");
			[self setResult:0.0 premRate:singlePrem == 0 ? rate : singlePrem premAmt:premiumAmt];
		}
		
		NSLog(@"finalL %f",payamt);
		
		//TODO: calculate the values here
	}
	
}


-(double)getSinglePre:(NSString*)type :(double)LVR :(double)term{
    
	LVR = 100 - LVR;
	
	double premium = 0.0;
	
	NSInteger ix = [[NSUserDefaults standardUserDefaults] integerForKey:@"products"];
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


-(void)setResult:(double)monthly premRate:(double)premRate premAmt:(double)premAmt{
	
	if([arrMortgage count]>10){
		for (int x=1;x<4; x++) {
			[arrMortgage removeLastObject];
			[arrMortgageValue removeLastObject];
		}
	}
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		
		[arrMortgage addObject:@"Monthly"];
		[arrMortgage addObject:@"Bi-Weekly Accelerated"];
		[arrMortgage addObject:@"Weekly Accelerated"];

       

	}else {
		
		[arrMortgage addObject:@"Versement mensuel"];
		[arrMortgage addObject:@"Aux quinzaines accélérés"];
		[arrMortgage addObject:@"Versements hebdomadaires accélérés"];
        
	}
	
	
	if (monthly > 0) {
		
		[arrMortgageValue addObject:[NSString stringWithFormat:@"$ %.2f", monthly]];
		
		double new = monthly;
		
		monthly = monthly / 2;
		[arrMortgageValue addObject:[NSString stringWithFormat:@"$ %.2f", monthly]];
       

		new = new / 4;
		[arrMortgageValue addObject:[NSString stringWithFormat:@"$ %.2f", new]];
       
	}else {
		[arrMortgageValue addObject:@"$ 0.0"];
		[arrMortgageValue addObject:@"$ 0.0"];
		[arrMortgageValue addObject:@"$ 0.0"];
       
	}
    if (premRate > 0) {
		NSString *str = @"%";
        [arrMortgageValue replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%.2f %@", premRate, str]];

        [arrMortgageValue replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"$ %.2f", premAmt]];
		[arrMortgageValue replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"$ %.2f", premAmt + loanAmt]];


	}else {
        [arrMortgageValue replaceObjectAtIndex:5 withObject:@"$ 0.0"];
		[arrMortgageValue replaceObjectAtIndex:4 withObject:@"0.0 %"];
		[arrMortgageValue replaceObjectAtIndex:6 withObject:@"$ 0.0"];
	}
    
	
	[arrMortgage retain];
	[arrMortgageValue retain];
	
	[tblMortgage reloadData];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[arrMortgage count]-1 inSection:0];
	[tblMortgage scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

}

#pragma mark -
#pragma mark - Table view methods
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	int rowId = indexPath.row;
	if(rowId == 0 || rowId == 1 || rowId == 7 || rowId == 3)
		return 50;
	else
		return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrMortgage count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	int rowId = indexPath.row;

    
    NSLog(@"rowid %i", rowId);
	if(rowId == 0 || rowId == 7){
		
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
		
		if(rowId == 0)
			cell.lblDesc.hidden = YES;
		else
			cell.lblDesc.hidden = NO;
		
		cell.lblTitle.text = [arrMortgage objectAtIndex:rowId];
        
        if(rowId == 0)
        {
            NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
            [fmt setNumberStyle:NSNumberFormatterDecimalStyle]; // to get commas (or locale equivalent)
            [fmt setMaximumFractionDigits:0]; // to avoid any decimal
            
            NSInteger value = [[arrMortgageValue objectAtIndex:rowId] integerValue];
            
            NSString *result = [fmt stringFromNumber:@(value)];
            cell.textField.text = result;

        }
        else
        {
            cell.textField.text = [arrMortgageValue objectAtIndex:rowId];

        }
        
        [[cell.contentView viewWithTag:101] removeFromSuperview];
        
		return cell;

	}else if (rowId == 4|| rowId == 5 || rowId == 6 ){
		
		CellIdentifier = @"RESULT";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = nil;
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
			//cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:15];
			//cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:15];
			//cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
			//cell.textLabel.textColor = [UIColor darkGrayColor];
			//cell.accessoryType = UITableViewCellAccessoryNone;
		}
		
        UILabel *lblTitletext = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 230, 50)];
        lblTitletext.font = [UIFont boldSystemFontOfSize:15];
        lblTitletext.text =  [arrMortgage objectAtIndex:rowId];
        lblTitletext.numberOfLines = 0;
        lblTitletext.lineBreakMode = NSLineBreakByWordWrapping;
        lblTitletext.tag  =501;
        [cell.contentView addSubview:lblTitletext];
        
        
        UILabel *lblDetails = [[UILabel alloc] initWithFrame:CGRectMake(225, 2, 90, 50)];
        lblDetails.font = [UIFont systemFontOfSize:15];
        lblDetails.textColor = [UIColor lightGrayColor];
        lblDetails.tag  =502;
        lblDetails.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:lblDetails];
        
		
		lblTitletext.text = [arrMortgage objectAtIndex:rowId];
		lblDetails.text = [arrMortgageValue objectAtIndex:rowId];
		
		//UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calc_bar.png"]];
		//imgView.contentMode = UIViewContentModeScaleToFill;
		//cell.backgroundView = imgView;
		      
        [[cell.contentView viewWithTag:101] removeFromSuperview];
		return cell;
    }else if (rowId == 3){
		
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
        [self selectedValueForProduct:rowId];

        cell.textLabel.text = [arrMortgage objectAtIndex:rowId];

        cell.detailTextLabel.text = [arrMortgageValue objectAtIndex:rowId];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
		      
        [[cell.contentView viewWithTag:101] removeFromSuperview];
		return cell;
		
	
	}else{
		CellIdentifier = @"PickerCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = nil;
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
			//cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:15];
			//cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:15];
			//cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
			//cell.textLabel.textColor = [UIColor darkGrayColor];
			
		}
        
        UILabel *lblTitletext = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 230, 50)];
        lblTitletext.font = [UIFont boldSystemFontOfSize:15];
        lblTitletext.text =  [arrMortgage objectAtIndex:rowId];
        lblTitletext.numberOfLines = 0;
        lblTitletext.lineBreakMode = NSLineBreakByWordWrapping;
        lblTitletext.tag  =501;
        [cell.contentView addSubview:lblTitletext];
        
        
        UILabel *lblDetails = [[UILabel alloc] initWithFrame:CGRectMake(225, 2, 70, 50)];
        lblDetails.font = [UIFont systemFontOfSize:15];
        lblDetails.textColor = [UIColor lightGrayColor];
        lblDetails.tag  =502;
        lblDetails.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:lblDetails];
        
		//cell.textLabel.text = [arrMortgage objectAtIndex:rowId];
		cell.accessoryType = UITableViewCellAccessoryNone;
        [[cell.contentView viewWithTag:101] removeFromSuperview];

		if (rowId == 8) {
			NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"term"];
			NSMutableArray *arrTTT = [[NSMutableArray alloc] init];
			for (int x=1; x<36; x++) {
				if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
					[arrTTT addObject:[NSString stringWithFormat:@"%d Years",x]];
				else 
					[arrTTT addObject:[NSString stringWithFormat:@"%d Ans",x]];
			}
			[arrMortgageValue replaceObjectAtIndex:rowId withObject:[arrTTT objectAtIndex:ii]];

			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (rowId == 2) {
            NSString *strPP = [arrMortgageValue objectAtIndex:0];
            NSString *strDP = [arrMortgageValue objectAtIndex:1];
            if([strPP length]>0 && [strDP length]>0){
                
                double pp = [strPP doubleValue];
                double dp = [strDP doubleValue];
                if(dp>100)
                    [self showAlert:[self getString:@"Warning!"] :[self getString:@"Down Payment should not exceed 100."]];
                else {
                    int mAmt = pp - pp * dp / 100;
                    [arrMortgageValue replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d", mAmt]];
                }
            }
            
		}else if (rowId == 9) {
			
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"amortization"];
			NSArray *arr;
            if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0){
                if([arrMortgageValue[3] isEqualToString:@"Flex 95 Advantage"])
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
                if([arrMortgageValue[3] isEqualToString:@"Avantage Flex 95"])
                {
                    arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",nil];
                    
                }
                else
                {
                    arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",@"30 Ans",nil];
                    
                }
                
                
                
            }
			[arrMortgageValue replaceObjectAtIndex:rowId withObject:[arr objectAtIndex:ii]];
		}else if (rowId == 1) {
			
			cell.accessoryType = UITableViewCellAccessoryNone;
			
			NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"down"];
			NSArray *arr;
            arr  = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];
			[arrMortgageValue replaceObjectAtIndex:rowId withObject:[arr objectAtIndex:ii]];
            
            UILabel *lblPercent =[[UILabel alloc] initWithFrame:CGRectMake(305, 10, 25, 25)];
            lblPercent.text = @"%";
            lblPercent.font = [UIFont boldSystemFontOfSize:15];
            lblPercent.tag = 101;
            lblPercent.textColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:lblPercent];
            //cell.detailTextLabel.text = [arrMortgageValue objectAtIndex:rowId];
            lblDetails.text = [arrMortgageValue objectAtIndex:rowId];

            return cell;
		}

		
		//cell.detailTextLabel.text = [arrMortgageValue objectAtIndex:rowId];
        lblDetails.text = [arrMortgageValue objectAtIndex:rowId];
		
		cell.backgroundView = nil;
		return cell;
	}
}


-(NSArray *)selectedValueForProduct:(NSInteger)rowId
{
    
    
    NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"down"];
    NSArray *arr  = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];

    NSString *val = arr[ii];
    
    NSInteger valInt = [val integerValue];
    NSArray *temp;

    if(valInt == 5)
    {
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Flex 95 Advantage", nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Flex 95",nil];
        NSInteger iii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"products"];
        NSString *val = @"";
        switch (iii) {
            case 0:
                val = [temp objectAtIndex:0];
                break;
            case 1:
                val = [temp objectAtIndex:1];
                break;
            default:
                break;
        }
        [arrMortgageValue replaceObjectAtIndex:3 withObject:val];
    }
    if(valInt == 10 || valInt == 15)
    {
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        NSInteger iii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"products"];
        NSString *val = @"";
        switch (iii) {
            case 0:
                val = [temp objectAtIndex:0];
                break;
            case 2:
                val = [temp objectAtIndex:1];
                break;
            default:
                break;
        }
        [arrMortgageValue replaceObjectAtIndex:3 withObject:val];
        
    }
    if(valInt >= 20 && valInt <= 85)
    {
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",@"Rental Advantage",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",@"Avantage Locatif",nil];
        NSInteger iii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"products"];
        NSString *val = @"";
        switch (iii) {
            case 0:
                val = [temp objectAtIndex:0];
                break;
            case 2:
                val = [temp objectAtIndex:1];
                break;
            case 3:
                val = [temp objectAtIndex:2];
                break;
            default:
                break;
        }
        [arrMortgageValue replaceObjectAtIndex:3 withObject:val];
    }
    if(valInt == 90 || valInt == 95)
    {
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        
        NSInteger iii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"products"];
        NSString *val = @"";
        switch (iii) {
            case 0:
                val = [temp objectAtIndex:0];
                break;
            case 2:
                val = [temp objectAtIndex:1];
                break;
            default:
                break;
        }
        [arrMortgageValue replaceObjectAtIndex:3 withObject:val];
    }
    if(valInt == 100)
    {
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",nil];
        NSInteger iii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"products"];
        NSString *val = @"";
        switch (iii) {
            case 0:
                val = [temp objectAtIndex:0];
                break;
            
            default:
                break;
        }
        [arrMortgageValue replaceObjectAtIndex:3 withObject:val];
    }
    
    return temp;
    
}

-(NSInteger)selectedIntegerProduct:(NSInteger)rowId
{
    
    
    NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"down"];
    NSArray *arr  = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];
    
    NSString *val = arr[ii];
    
    NSInteger valInt = [val integerValue];
    NSArray *temp;
    
    if(valInt == 5)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Flex 95 Advantage", nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Flex 95",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        else
        {
            return 1;
        }
        
    }
    if(valInt == 10 || valInt == 15)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        else
        {
            return 1;
        }
        
        
    }
    if(valInt >= 20 && valInt <= 85)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",@"Rental Advantage",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",@"Avantage Locatif",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        if(rowId == 3)
        {
            return 2;
        }
        if(rowId == 2)
        {
            return 1;
        }
        
        
    }
    if(valInt == 90 || valInt == 95)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        if(rowId == 2)
        {
            return 1;
        }
        
        
    }
    if(valInt == 100)
    {
        
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        
    }
    
    return temp;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
	
	int rowid = indexPath.row;
	
//	if([txt isFirstResponder])
	if(txt){
		CGRect rc = [txt bounds];
		UITableView * v = tblMortgage;
		rc = [txt convertRect:rc toView:v];
		CGPoint pt = rc.origin ;
		pt.y = 0 ;
		pt.x = 0;
		[v setContentOffset:pt animated:YES];
		[txt resignFirstResponder];

		if(txt.tag == 7){
			double rate = [[arrMortgageValue objectAtIndex:4] doubleValue];
			if(rate>100)
				[self showAlert:[self getString:@"Warning!"] :[self getString:@"Interest Rate should not exceed 100."]];
			
//			else if(![self validateNo:[arrMortgageValue objectAtIndex:3]])
//				[self showAlert:[self getString:@"Warning!"] :@"Please enter valid number."];
		}
		
	}
	
	[txt resignFirstResponder];
	
	if(rowid == 2){
		
		NSString *strPP = [arrMortgageValue objectAtIndex:0];
		NSString *strDP = [arrMortgageValue objectAtIndex:1];
		if([strPP length]>0 && [strDP length]>0){
			
			double pp = [strPP doubleValue];
			double dp = [strDP doubleValue];
			if(dp>100)
				[self showAlert:[self getString:@"Warning!"] :[self getString:@"Down Payment should not exceed 100."]];
			else {
				int mAmt = pp - pp * dp / 100;
				[arrMortgageValue replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d", mAmt]];
				[arrMortgageValue retain];
				[tblMortgage reloadData];
			}
		}
		
		
	}else if(rowid == 8 ){
		
		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		NSMutableArray *arrTTT = [[NSMutableArray alloc] init];
		for (int x=1; x<36; x++) {
			if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
				[arrTTT addObject:[NSString stringWithFormat:@"%d Years",x]];
			else 
				[arrTTT addObject:[NSString stringWithFormat:@"%d Ans",x]];
		}
		[picker showPicker:[NSArray arrayWithArray:arrTTT] :@"term" :tblMortgage];

	}else if(rowid == 9){
		
		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		NSArray *arr;
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0){
            if([arrMortgageValue[3] isEqualToString:@"Flex 95 Advantage"])
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
            if([arrMortgageValue[3] isEqualToString:@"Avantage Flex 95"])
            {
                arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",nil];
                
            }
            else
            {
                arr  = [NSArray arrayWithObjects:@"5 Ans",@"10 Ans",@"15 Ans",@"20 Ans",@"25 Ans",@"30 Ans",nil];
                
            }
            
            
            
            
        }
		[picker showPicker:arr 
						  :@"amortization" :tblMortgage];

	}else if(rowid == 1){
		
		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		NSArray *arr;
        arr  = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];

		[picker showPicker:arr
						  :@"down" :tblMortgage];
        
	}else if(rowid == 3){
		
        
        ValuesMort *val = [[ValuesMort alloc] initWithNibName:@"ValuesMort" bundle:nil];
        
        NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"down"];
        NSArray *arr  = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];
        
        NSString *vall = arr[ii];
        
        NSInteger valInt = [vall integerValue];
        
        
        val.valueSection = [self selectedIntegerProduct:[[NSUserDefaults standardUserDefaults] integerForKey:@"products"]];
        
        [self selectedValueForProduct:[[NSUserDefaults standardUserDefaults] integerForKey:@"products"]];
        
		[self.navigationController pushViewController:val animated:YES];
        
        
		/*PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		NSArray *arr;
        arr  = [self selectedValueForProduct:rowid];
        
		[picker showPicker:arr
						  :@"products" :tblMortgage];*/
        
	}

}

- (void)deselect{   
	[tblMortgage deselectRowAtIndexPath:[tblMortgage indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark - UITextField Lifecycle Methods 
#pragma mark -

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	
	CGRect rc = [textField bounds];
	UITableView * v = tblMortgage;
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
	
	tblMortgage.scrollEnabled = NO;
//	NSLog(@"Selected TextField is %d", textField.tag);
	CGRect rc = [textField bounds];
	UITableView * v = tblMortgage;
	rc = [textField convertRect:rc toView:v];
	CGPoint pt = rc.origin ;
	pt.y = pt.y - 0;
	pt.x = 0 ;
	[v setContentOffset:pt animated:YES];
}        

- (void) textFieldDidEndEditing:(UITextField *)textField{
	
	tblMortgage.scrollEnabled = YES;
	if ( textField ){
		int tID = textField.tag;
		if ( textField.text ){
			
			if(tID == 1){
				
				NSString *strPP = [arrMortgageValue objectAtIndex:0];
				NSString *strDP = textField.text;
				
				if([strPP length]>0 && [strDP length]>0){
					
					if(![self validateNo:strPP])
						[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter valid number."]];

					if(![self validateNo:strDP])
						[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter valid number."]];

					double pp = [strPP doubleValue];
					double dp = [strDP doubleValue];
					if(dp>100)
						[self showAlert:[self getString:@"Attention!"] :[self getString:@"Down Payment should not exceed 100."]];

					else {
						int mAmt = pp - pp * dp / 100;
						[arrMortgageValue replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d", mAmt]];
						[arrMortgageValue retain];
						[tblMortgage reloadData];
					}
				}
			}else if(tID == 7){
				double rate = [textField.text doubleValue];
				if(rate>100)
					[self showAlert:[self getString:@"Attention!"] :[self getString:@"Interest Rate should not exceed 100."]];
				else if(![self validateNo:textField.text])
					[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter valid number."]];
			}
			
            [arrMortgageValue replaceObjectAtIndex:tID withObject:textField.text];

			if(tID == 0)
            {
                NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
                [fmt setNumberStyle:NSNumberFormatterDecimalStyle]; // to get commas (or locale equivalent)
                [fmt setMaximumFractionDigits:0]; // to avoid any decimal
                
                NSInteger value = [[arrMortgageValue objectAtIndex:tID] integerValue];
                
                NSString *result = [fmt stringFromNumber:@(value)];
                textField.text = result;
            }
            
            
            
            NSString *strPP = [arrMortgageValue objectAtIndex:0];
            NSString *strDP = [arrMortgageValue objectAtIndex:1];
            if([strPP length]>0 && [strDP length]>0){
                
                double pp = [strPP doubleValue];
                double dp = [strDP doubleValue];
                if(dp>100)
                    [self showAlert:[self getString:@"Attention!"] :[self getString:@"Down Payment should not exceed 100."]];
                else {
                    int mAmt = pp - pp * dp / 100;
                    [arrMortgageValue replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d", mAmt]];
                    [arrMortgageValue retain];
                    [tblMortgage reloadData];
                }
            }
            

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