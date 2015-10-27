

#import "UIViewController-Custom.h"
#import <QuartzCore/QuartzCore.h>
#import "CommonHeader.h"


@implementation UIViewController(AllCommon)

-(void)fillGradientToView:(UIView *)view roundCorner:(BOOL)round withCornerRadius:(CGFloat)radius{
    //Fill the view with gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    // gradient.colors = [NSArray arrayWithObjects:(id)[APP_COLOR CGColor], (id)[APP_ALTERNATE_COLOR_2 CGColor], nil]; //Dark Green
    
    
    
    [view.layer insertSublayer:gradient atIndex:0];
    
    if(round){
        //Make corners round
        [[view layer] setCornerRadius:radius];
        
    }
    [view setClipsToBounds:YES];
    [[view layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    //[[view layer] setBorderWidth:1.0];
    
}

-(void)makeRoundedViewWithoutBorder:(UIView *)view{
    [[view layer] setCornerRadius:10];
}



-(void)makeRoundedView:(UIView *)view{
    [[view layer] setCornerRadius:10];
    [[view layer] setBorderWidth:10];
    [[view layer] setBorderColor:[[UIColor blackColor] CGColor]];
}


-(NSString *)prepareDate:(NSString *)inputDate{
    
    NSMutableArray *MonthArray=[[NSMutableArray alloc]init ];
    [MonthArray addObject:NSLocalizedString(@"Janvier",nil)];
    [MonthArray addObject:NSLocalizedString(@"Février",nil)];
    [MonthArray addObject:NSLocalizedString(@"Mars",nil)];
    [MonthArray addObject:NSLocalizedString(@"Avril",nil)];
    [MonthArray addObject:NSLocalizedString(@"Mai",nil)];
    [MonthArray addObject:NSLocalizedString(@"Juin",nil)];
    [MonthArray addObject:NSLocalizedString(@"Juillet",nil)];
    [MonthArray addObject:NSLocalizedString(@"Août",nil)];
    [MonthArray addObject:NSLocalizedString(@"Septembre",nil)];
    [MonthArray addObject:NSLocalizedString(@"Octobre",nil)];
    [MonthArray addObject:NSLocalizedString(@"Novembre",nil)];
    [MonthArray addObject:NSLocalizedString(@"Décembre",nil)];
    
    NSArray *components=[inputDate componentsSeparatedByString:@"-"];
    
    NSString *date=[NSString stringWithFormat:@"%@, %@ %@ %@",[components objectAtIndex:3],[components objectAtIndex:1],[MonthArray objectAtIndex:[[components objectAtIndex:0] intValue]],[components objectAtIndex:2]];
    
    
    return date;
    
}



-(UIButton *)addBackButton:(BOOL)isModal{
    //isModal= decides the view is opened as modal view or, not
    
    UIButton *btnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(6,9,58,30)];
    [btnBack setClipsToBounds:YES];
    
    [btnBack setImage:[UIImage imageNamed:@"retour.png"] forState:UIControlStateNormal];
    
    if(isModal)
        [btnBack addTarget:self action:@selector(closeFromModal:) forControlEvents:UIControlEventTouchUpInside];
    else
        [btnBack addTarget:self action:@selector(closeMe:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnBack];    
    
    return btnBack;
    
}




-(NSString *)sentenceCase:(NSString *)string{
    
    NSArray *parts=[[string lowercaseString] componentsSeparatedByString:@" "];
    
    NSString *final=@"";
    
    for(NSString *s in parts){
        NSString *firstLetter=[[s substringToIndex:1] uppercaseString];
        s=[s substringWithRange:NSMakeRange(1, [s length] - 1)];
        s=[firstLetter stringByAppendingString:s];
        final=[final stringByAppendingFormat:@"%@ ",s];
    }
    
    return final;
}


-(UIView *)addCommonHeaderForView:(NSString *)viewName modal:(BOOL)isModal showBackButton:(BOOL)showBackButton showEmailButton:(BOOL)showEmailButton{
    
    //Adds common header wherever required.
    
    self.navigationController.navigationBarHidden=YES;
    
    UIViewController *controller=[[UIViewController alloc] initWithNibName:@"CommonHeader" bundle:nil];
    CommonHeader *header=(CommonHeader *)controller.view;
    header.parentController=self;
    header.headerText=viewName;
    header.showButton=showBackButton;
    header.showEmail=showEmailButton;
    
    [header initViewComponents];
    [self.view addSubview:header];

    

        [header setFrame:CGRectMake(0, 20, header.frame.size.width, header.frame.size.height)];

    
    
    if(isModal)
        [header.btnBack addTarget:self action:@selector(closeFromModal:) forControlEvents:UIControlEventTouchUpInside];
    else
        [header.btnBack addTarget:self action:@selector(closeMe:) forControlEvents:UIControlEventTouchUpInside];
    
    if(![viewName isEqualToString:@"Rates"] && !isModal){
        
        [header.btnHome addTarget:self action:@selector(homeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(isModal){
        [header.btnHome addTarget:self action:@selector(closeFromModal:) forControlEvents:UIControlEventTouchUpInside];
    }
       
    
    return header;
    
    
}


- (IBAction)homeButtonAction:(id)sender {
    JencorAppDelegate *appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIButton *firstTabButton=nil;
    
    for(UIButton *btn in [appDelegate.viewButtons subviews]){
        
        if([btn isKindOfClass:[UIButton class]]){
            
            if(btn.tag == 0){
                firstTabButton=btn;
                break;
            }
            
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromTab"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    firstTabButton.tag=99;
    [appDelegate tabButtonAction:firstTabButton];
}


-(void)adjustLabelSizeForLabel:(UILabel *)label andText:(NSString *)text{
	
	//Adjust Label height
	
	CGSize maximumLabelSize = CGSizeMake(label.frame.size.width,300);
	
	CGSize expectedLabelSize = [text sizeWithFont:label.font 
								constrainedToSize:maximumLabelSize 
									lineBreakMode:label.lineBreakMode]; 
	
	//adjust the label the the new height.
	CGRect newFrame = label.frame;
    if(expectedLabelSize.height < 20.0)
        newFrame.size.height = 32.0;
    else
        newFrame.size.height = expectedLabelSize.height;
	label.frame = newFrame;
}

-(CGFloat)adjustCellHeightForText:(NSString *)text{
	
	//Adjust Label height
    
    
	
	CGSize maximumLabelSize = CGSizeMake(320, 300);
	
	UIFont *font=[UIFont boldSystemFontOfSize:14.0];		
	
	CGSize expectedLabelSize = [text sizeWithFont:font 
                                constrainedToSize:maximumLabelSize 
                                    lineBreakMode:UILineBreakModeWordWrap];	
	
	CGFloat height=expectedLabelSize.height+15;
    
    if(height < 53.0)
        height=53.0;
    
	return height;
	
}

-(void)adjustLabelSizeForBiggerLabel:(UILabel *)label andText:(NSString *)text{
	
	//Adjust Label height
	
	CGSize maximumLabelSize = CGSizeMake(label.frame.size.width,800);
	
	CGSize expectedLabelSize = [text sizeWithFont:label.font 
								constrainedToSize:maximumLabelSize 
									lineBreakMode:label.lineBreakMode]; 
	
	//adjust the label the the new height.
	CGRect newFrame = label.frame;
    if(expectedLabelSize.height < 20.0)
        newFrame.size.height = 32.0;
    else
        newFrame.size.height = expectedLabelSize.height;
	label.frame = newFrame;
}

-(CGFloat)adjustCellHeightForBiggerText:(NSString *)text{
	
	//Adjust Label height
	
	CGSize maximumLabelSize = CGSizeMake(280, 800);
	
	UIFont *font=[UIFont fontWithName:@"Helvetica" size:14.0];		
	
	CGSize expectedLabelSize = [text sizeWithFont:font 
                                constrainedToSize:maximumLabelSize 
                                    lineBreakMode:UILineBreakModeWordWrap];	
	
	CGFloat height=expectedLabelSize.height+20;
    
	return height;
	
}




-(IBAction)closeFromModal:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(IBAction)closeMe:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) hideGradientBackground:(UIView*)theView
{
    
    //Clears background of WebView
    
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

-(NSString *)getHTMLfromFile:(NSString *)html{
    
    //Reads inputted html file
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:html ofType:@"html"];
	NSString *strHTML = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    return strHTML;
    
}

- (BOOL) validateEmail: (NSString *) emailID {
    
    emailID=[emailID lowercaseString];
    
    NSString *emailRegex = @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:emailID];
}

#pragma mark-
#pragma mark Calculators

-(NSString *)mortgageQualifierCalculatorForAnualFamilyIncome:(NSString *)incomes  AnnualPropertyTaxes:(NSString *)taxes MonthlyHeatingCosts:(NSString *)healingCost  MinimumMonthlyPayments:(NSString *)monthlyPayments MonthlySecondaryFinancingPayment:(NSString *)secondaryPayment InterestRate:(NSString *)rate{
    
    NSString *results=@"";
    
    float RATE = [rate floatValue]/100;
    float income = [incomes floatValue];
    //  float tax = [taxes floatValue];
    //  float heat = [healingCost floatValue]*12;
    // float debt = [monthlyPayments floatValue]*12;
    // float second = [secondaryPayment floatValue]*12;
    float compound = (float )2/12;
    float monTime = 25 * 12;
    float yrRate = RATE/2;
    float rdefine    = pow((1.0 + yrRate),compound)-1.0;
    float purchcompound = pow((1.0 + rdefine),monTime);
    
    
    float maxgdsr =.32;
    float maxtdsr =.42;
    
    
    float GDSPAY = (maxgdsr*income) - [taxes floatValue] - ([healingCost floatValue]*12) - ([secondaryPayment floatValue]*12);
    float TDSPAY = (maxtdsr*income) - [taxes floatValue] - ([healingCost floatValue]*12) - ([secondaryPayment floatValue]*12) - ([monthlyPayments floatValue]*12);
    
    float PAYMENT = (GDSPAY<TDSPAY) ? GDSPAY/12 : TDSPAY/12;
    float MORTGAGE = (0 +((PAYMENT*(purchcompound-1.0))/rdefine))/purchcompound;
    NSLog(@"PAYMENT= %f ,MORTGAGE=%f"  ,PAYMENT,MORTGAGE);
    
    
    results=[NSString stringWithFormat:@"%0.2f,%0.2f",MORTGAGE,PAYMENT];
    NSLog(@"results %@  length is %d",results,[results length]);
    //document.maxcalc.amt.value = '$'+roundPen(MORTGAGE);
    //  document.maxcalc.pay.value = '$'+roundPen(PAYMENT);
    NSArray *arr=[results componentsSeparatedByString:@","];
    NSLog(@"maximum mortage=%@,monthly payment =%@",[arr objectAtIndex:0],[arr objectAtIndex:1]);
    
    
    return results;
}


-(NSString *)validatemortgageQualifierCalculatorForFieldName:(NSString *)fieldName andFieldValue:(NSString *)fieldValue
{
    if ([fieldName isEqualToString:@"incomes"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 10000) ||([fieldValue intValue] > 1000000)))
        {
            return @"Please enter a number between 10000 and 1000000 for Annual Family Income.";
        }
        
    }  
    
    else if ([fieldName isEqualToString:@"taxes"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 100) ||([fieldValue intValue] > 50000)))
        {
            return @"Please enter a number between 100 and 50000 for Annual Property Taxes.";
        }
        
    }   
    else if ([fieldName isEqualToString:@"healingCost"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 20) ||([fieldValue intValue] > 1500)))
        {
            return @"Please enter a number between 20 and 1500 for Monthly Healing Cost.";
        }
        
    }   
    
    else if ([fieldName isEqualToString:@"monthlyPayments"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 0) ||([fieldValue intValue] > 5000)))
        {
            return @"Please enter a number between 0 and 5000 for Minimun MOnthly Payments";
        }
        
    }   
    
    else if ([fieldName isEqualToString:@"secondaryPayment"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 0) ||([fieldValue intValue] > 5000)))
        {
            return @"Please enter a number between 0 and 5000 for Monthly Secondary Financing Payment.";
        }
        
    }   
    else if ([fieldName isEqualToString:@"rate"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 2) ||([fieldValue intValue] > 25)))
        {
            return @"Please enter a number between 2.0 and 25.0 for Interest Rate";
        }
        
    }   
    
    
    
    return @"VALID";
}




-(NSMutableArray *)rentBuyCalculatorForMonthlyPayment:(NSString *)monthlyPayments downPayment:(NSString *)downPayment annualPropertyTaxes:(NSString *)annualPropertyTaxes interestRate:(NSString *)rate annualIncrease:(NSString *)annualIncrease  monthlyRent:(NSString *)monthlyRent yearsOfComparison:(NSString *)years
{
    //NSString *results=@"";
    
    float RATE =([rate floatValue]/100);
    float downp =[downPayment floatValue];
    float tax = [annualPropertyTaxes floatValue];
    float incr = [annualIncrease floatValue]/100;
    float monpay = [monthlyPayments floatValue];
    float rent = [monthlyRent floatValue];
    int compare = [years intValue];
    
    float compound = (float)2/12;
    float monTime = 25 * 12;
    float yrRate = (float)RATE/2;
    float rdefine    = pow((1.0 + yrRate),compound)-1.0;
    float purchcompound = pow((1.0 + rdefine),monTime);
    
    float a1 = monpay - (tax/12);
    float b1 = (0+((a1*(purchcompound-1.0))/rdefine))/purchcompound;
    float c1 = downp+b1;
    float res = (b1*(pow((1.0 + rdefine),(12*compare)))) -  ((a1 * ((pow((1.0 + rdefine),(12*compare))) - 1.0))/rdefine);
    float d1 = b1-res;
    float e1 = c1*((pow((1+incr),compare))-1);
    float f1 = monpay - rent;
    float g1 = (downp+(f1*12))*(pow((1.04),compare))-downp;
    float h1 = d1+e1;
    // NSLog( @"a1,b1,c1,d1,e1,f1,g1,h1,res")
    
    
    NSString *decide =[NSString stringWithFormat:@"%@",(h1>g1) ? @"BUY" : @"CONTINUE TO RENT"];
    
    NSString *words = [NSString stringWithFormat:@"%@",(h1>g1) ? @"greater" : @"less"]; 
    //results=[NSString stringWithFormat:@"%@,%@",decide,words];
    NSMutableArray *arrResults=[[NSMutableArray alloc]initWithObjects:decide,[NSString stringWithFormat:@"%0.2f",b1],[NSString stringWithFormat:@"%0.2f",d1],[NSString stringWithFormat:@"%0.2f",a1],[NSString stringWithFormat:@"%0.2f",e1],[NSString stringWithFormat:@"%0.2f",h1],words,[NSString stringWithFormat:@"%0.2f",g1],[NSString stringWithFormat:@"%0.2f",f1],[NSString stringWithFormat:@"%0.2f",downp],[NSString stringWithFormat:@"%0.0f",rate], [NSString stringWithFormat:@"%d",compare],[NSString stringWithFormat:@"%0.2f",c1],nil];
    
    NSLog(@"array is %@",arrResults);
    
    //results=[self prepareHTML:arrResults];
    //[arrResults release];
    return arrResults;
}



-(NSString *)prepareHTML:(NSMutableArray*)array{
	NSString *strHTML=@"";
	NSString *fileName = [[NSBundle mainBundle] pathForResource:@"rentBuy" ofType:@"html"];
	strHTML = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
	
    
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#DECIDE#" withString:[array objectAtIndex:0]];
	strHTML	= [strHTML stringByReplacingOccurrencesOfString:@"#B1#" withString:[array objectAtIndex:1]];
	strHTML	= [strHTML stringByReplacingOccurrencesOfString:@"#D1#" withString:[array objectAtIndex:2]];
	strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#A1#" withString:[array objectAtIndex:3]];
	strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#E1#" withString:[array objectAtIndex:4]];
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#H1#" withString:[array objectAtIndex:5]];
 	strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#WORDS#" withString:[array objectAtIndex:6]];
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#G1#" withString:[array objectAtIndex:7]];
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#F1#" withString:[array objectAtIndex:8]];
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#DOWNP#" withString:[array objectAtIndex:9]];
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#RATE#" withString:[array objectAtIndex:10]];
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#COMPARE#" withString:[array objectAtIndex:11]];
    strHTML = [strHTML stringByReplacingOccurrencesOfString:@"#C1#" withString:[array objectAtIndex:12]];
    
    
    
    
    NSLog(@"%@",strHTML);
	[strHTML retain];
    
	return strHTML;
}


-(NSString *)validateRentBuyCalculatorForFieldname:(NSString *)fieldName andFieldValue:(NSString *)fieldValue
{
    
    
    // NSLog(@"field value is %@",fieldValue);
    if ([fieldName isEqualToString:@"monthlyPayments"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 200) ||([fieldValue intValue] > 10000)))
        {
            return @"Please enter a number between 200 and 10000 for Monthly Payment.";
        }
        
    }   
    else if ([fieldName isEqualToString:@"downPayment"])
    {
        if(([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 2000) || ([fieldValue intValue] > 1000000)))
        {
            
            return @"Please enter a number between 2000 and 1000000 for Down Payment.";
        }
        
    }
    else if([fieldName isEqualToString:@"annualPropertyTaxes"])
    {
        if (([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 300) || ([fieldValue intValue] > 10000)))
        {
            return @"Please enter a number between 300 and 10000 for Annual Property Taxes.";
        }
        
    }
    else if ([fieldName isEqualToString:@"rate"])
    {
        if (([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) || (([fieldValue intValue] < 2)  || ([fieldValue intValue] > 25))) {
            return @"Please enter a number between 2 and 25 for Interest Rate.";
        }
    }
    else if ([fieldName isEqualToString:@"annualIncrease"])
    {
        
        if ([fieldValue isEqualToString: NULL]) {
            return @"You have not answered Annual increase in Home Value, click on the CHOOSE button to select your option.";
        }
    }
    else if([fieldName isEqualToString:@"monthlyRent"])
    {
        if ((([fieldValue intValue] < 0)  || ([fieldValue length] == 0)) || (([fieldValue intValue] < 0 ) || ([fieldValue intValue] > 5000))) {
            return @"Please enter a number between 0 and 5000 for Monthly Rent.";
        }
        
    }
    else if ([fieldName isEqualToString:@"years"])
        
    {
        
        if ([fieldValue isEqualToString: NULL]) {
            return @"You have not answered Years of Comparison, click on the CHOOSE button to select your option.";
        }
    }
    
    
    return @"VALID";
}

-(NSString *)getMortgageAmountFromPurchasePrice:(NSString *)purchase andDownPayment:(NSString *)downPayment{

    double pp = [purchase doubleValue];
    double dp = [downPayment doubleValue];
    
    int mortgageAmt = pp - pp * dp / 100;

    return [NSString stringWithFormat:@"%d", mortgageAmt];
}

-(NSMutableArray *)mortgagePaymentCalculatorForPurchasePrice:(NSString *)purchasePrice DownPayment:(NSString *)downPayment Rate:(NSString *)rate Term:(NSString *)term Amortization:(NSString *)amortization{
    
    //the array arrMortgageValue contains results for mortgage amount,monthly,Bi-weekly Accelerated and Weekly Accelerated
    
    NSMutableArray *arrMortgageValue=[[NSMutableArray alloc]init];
    double pp = [purchasePrice doubleValue];
    double dp = [downPayment doubleValue];
    
    int mortgageAmt = pp - pp * dp / 100;
    
    //[arrMortgageValue addObject:[NSString stringWithFormat:@"%d", mortgageAmt]];
    double years = [amortization doubleValue];	
    
    double itwoval = pow((1+ [rate doubleValue]/200), 0.16666667);
    double payamt = (mortgageAmt * (itwoval -1) / (1 - (pow(itwoval, -(years*12)))));
    NSLog(@"%d,%f,%f,%f,%f",mortgageAmt,[rate doubleValue],years,itwoval,payamt);
    if (payamt) {
        NSLog(@"monthlyAmt :%f", payamt);
        //[self setResult:payamt];
    }else{
        NSLog(@"monthlyAmt error");
        // [self setResult:0.0];
    }
    
    NSLog(@"finalL %f",payamt);
    if (payamt > 0) {
		
		[arrMortgageValue addObject:[NSString stringWithFormat:@"%0.2f", payamt]];
		
		double new = payamt;
		
		payamt = payamt / 2;
		[arrMortgageValue addObject:[NSString stringWithFormat:@"%0.2f", payamt]];
		
		new = new / 4;
		[arrMortgageValue addObject:[NSString stringWithFormat:@"%0.2f", new]];
        
	}
    
    return arrMortgageValue;
}


-(NSString *)validateMortgagePaymentCalculatorForFieldname:(NSString *)fieldName andFieldValue:(NSString *)fieldValue
{
    
    
    // NSLog(@"field value is %@",fieldValue);
    if ([fieldName isEqualToString:@"purchasePrice"])
    {
        if([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0))
        {
            return @"Please enter valid number for Purchase Price.";
        }
        
    }   
    else if ([fieldName isEqualToString:@"downPayment"])
    {
        if([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0))
            
            return @"Please enter valid number.";
        else if([fieldValue intValue] > 100)
        {
            
            return @"Down Payment should not exceed 100.";
        }
        
    }
    else if([fieldName isEqualToString:@"rate"])
    {
        if ([fieldValue isEqualToString: NULL] || ([fieldValue length] == 0)) 
            return @"Please enter valid number.";
        
        else if ([fieldValue intValue] > 100)
        {
            return @"Interest Rate should not exceed 100.";
        }
        
    }
    
    else if ([fieldName isEqualToString:@"term"])
    {
        
        if ([fieldValue isEqualToString: NULL]) {
            return @"You have not answered this question, click on the CHOOSE button to select your option.";
        }
    }
    else if([fieldName isEqualToString:@"amortization"])
    {
        if ([fieldValue isEqualToString: NULL]) {
            return @"You have not answered this question, click on the CHOOSE button to select your option.";
        }
        
        
    }
    
    
    return @"VALID";
}



@end
