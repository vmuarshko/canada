//
//  CalculatorUIController.m
//  Jencor
//
//  Created by Teknowledge Software on 24/02/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "CalculatorUIController.h"
#import "CalcUICell.h"
#import "CalculatorBusiness.h"
#import "ScheduleControler.h"
#import "RatesApi.h"

@implementation CalculatorUIController
@synthesize container;
@synthesize imgView;


@synthesize lblTitle;
@synthesize mortCalcs;
@synthesize tbl,type,appdelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    JencorAppDelegate *appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];


    imgView.clipsToBounds = YES;

    
    // Do any additional setup after loading the view from its nib.
    [self addCommonHeaderForView:@"Calculators" modal:NO showBackButton:YES showEmailButton:NO];
    appdelegate=(JencorAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *title=@"";

    if(type == 0)
        title=@"Mortgage Planning";
    else if(type == 1)
        title=@"Home Purchase";
    else if(type == 2)
        title=@"Mortgage Comparison";
    else if(type == 3)
        title=@"What can I afford";
    
    lblTitle.text=title;
    
    mortCalcs.hidden=TRUE;
    
    RatesApi *api=[[RatesApi alloc] init];
    api.parent=self;
    api.toGetRate=TRUE;
    [api makeRequest];

}

- (IBAction)mortSelection:(id)sender {

    switch (mortCalcs.selectedSegmentIndex) {
        case 0:
            if (type==0) 
                tblData=[arrMortPaymentCalc retain];
            else
                tblData=[arrCompPaymentCals retain];
            
            break;
            
        case 1:
            if (type==0)
                tblData=[arrMortMortCalc retain];
            else
                tblData=[arrCompMortCals retain];   
            break;
            
        case 2:
            if (type==0)
                tblData=[arrMortAmortCalc retain];
            else
                tblData=[arrCompAmortCals retain];
            
            break;
    }
    
   // [tbl reloadData];
    
    [self calculateValues];
}

-(void)setupViewWithRate:(Rate *)rate{

    CGRect frame=tbl.frame;
    
    
    
    if(type == 0){
    
        arrMortMortCalc=[[[CalcForm alloc] init] getMortgageCalcWithRate:rate type:@"Mortgage"];
        
        arrMortPaymentCalc=[[[CalcForm alloc] init] getMortgageCalcWithRate:rate type:@"Payment"];
        
        arrMortAmortCalc=[[[CalcForm alloc] init] getMortgageCalcWithRate:rate type:@"Amort"];
    
        tblData=[arrMortPaymentCalc retain];
        
        
        frame.size.height= appdelegate.isIphone5 ? 300 :  195;
        frame.origin.y = container.frame.origin.y+container.frame.size.height;
        mortCalcs.hidden=FALSE;
        
    }else if(type == 1){
        
        tblData=[[[CalcForm alloc] init] getHomePurchaseCalcWithRate:rate];
        
        if(!tempPercentage){
            
            tempPercentage=[[CalcForm alloc] init];
            [tempPercentage setFieldLabel:@"Down Payment"];
            [tempPercentage setFieldValue:@"5"];
            [tempPercentage setFieldType:@"TextWithOption"];
            [tempPercentage setFieldName:@"downpayment"];
            [tempPercentage setIsSuffix:YES];
            [tempPercentage setMandatory:YES];
            [tempPercentage setValuePrefixSuffix:@"%"];
            
        }
               
        if(!tempDollar){
            
            tempDollar=[[CalcForm alloc] init];
            [tempDollar setFieldLabel:@"Down Payment"];
            [tempDollar setFieldValue:@"12500.00"];
            [tempDollar setFieldType:@"TextWithOption"];
            [tempDollar setFieldName:@"downpayment"];
            [tempDollar setIsSuffix:NO];
            [tempDollar setMandatory:YES];
            [tempDollar setValuePrefixSuffix:@"$"];
        
        }
        frame.size.height= appdelegate.isIphone5 ? 300 :  225;
        frame.origin.y = container.frame.origin.y+container.frame.size.height - 30;
    
    }else if(type == 2){
        arrCompPaymentCals =[[[CalcForm alloc] init] getCompareCalcPaymentWithRate:rate type:@"Payment"];     
        arrCompMortCals =[[[CalcForm alloc] init] getCompareCalcPaymentWithRate:rate type:@"Mortgage"];
        arrCompAmortCals =[[[CalcForm alloc] init] getCompareCalcPaymentWithRate:rate type:@"Amort"];
        tblData=[arrCompPaymentCals retain];
        frame.size.height= appdelegate.isIphone5 ? 280 :  195;
        frame.origin.y = container.frame.origin.y+container.frame.size.height;

        mortCalcs.hidden=FALSE;

    
    }else if(type == 3){
        tblData=[[[CalcForm alloc] init] getAffordCalcWithRate:rate];
        frame.size.height= appdelegate.isIphone5 ? 300 :  225;
        frame.origin.y = container.frame.origin.y+container.frame.size.height - 30;
    }
    
     [tbl setFrame:frame];
        
    //Calculate for the first time
    [self calculateValues];

     
}

  


#pragma mark ---
#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(type == 1 || type == 3)
        return [tblData count];
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(type == 1){
        CalcForm *obj=[[tblData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        if([obj.fieldType isEqualToString:@"TextWithOption"])
            return 80;
        
        return 40;
    }else if(type == 2)
        return 50.0;
    
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if(type == 3){
    
        if([[[tblData objectAtIndex:section] objectForKey:@"title"] isEqualToString:@""])
            return 0;
        
        return 20.0;
    
    }

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{


    if(type == 3){
        
        UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
        [header setBackgroundColor:[UIColor clearColor]];
        
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 250, 20)];
        
        [lbl setTextColor:[UIColor colorWithRed:50.0/255.0 green:97.0/255.0 blue:158.0/255.0 alpha:1.0]];
        [lbl setFont:[UIFont boldSystemFontOfSize:14.0]];

        [lbl setBackgroundColor:[UIColor clearColor]];
        
        [header addSubview:lbl];
        
        lbl.text=[[tblData objectAtIndex:section] objectForKey:@"title"];
        
        
        return header;
    }
    
    return nil;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(type == 1)
        return [[tblData objectAtIndex:section] count];
    else if(type == 3)
        return [[[tblData objectAtIndex:section] objectForKey:@"data"] count];
    
    return [tblData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier=@"CalcUICell";
    
    CalcForm *obj=[self getCurrentObjectForIndexPath:indexPath];
    
    if((type == 0 || type == 1 || type == 3) && ([obj.fieldType isEqualToString:@"Result"] || [obj.fieldType isEqualToString:@"Schedule"]))
        CellIdentifier=@"ResultCell";
    else if(type == 2 && [obj.fieldType isEqualToString:@"Result"] )
        CellIdentifier=@"ComparisonResultCell";
    else if(type == 2 && [obj.fieldType isEqualToString:@"AmortResult"])
         CellIdentifier=@"ComparisonResultCell";
    else if(type == 2)
        CellIdentifier=@"ComparisonInputCell";
    else if(type == 1 && [obj.fieldType isEqualToString:@"TextWithOption"])
        CellIdentifier=@"SegmentCell";
    else
        CellIdentifier=@"InputCell";
    
    
    
    CalcUICell *cell=(CalcUICell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        UIViewController *controller=[[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
        cell=(CalcUICell *)controller.view;
        
        cell.backgroundView=nil;
        [cell setBackgroundColor:[UIColor clearColor]];
        [tableView setSeparatorColor:[UIColor clearColor]];
        
        if(type == 2){
            cell.txtInput1.delegate=self;
            cell.txtInput2.delegate=self;
        }else if(type == 1){
            [cell.toggler addTarget:self action:@selector(toggleAction:) forControlEvents:UIControlEventValueChanged];
            cell.txtInput.delegate=self;
        }else
            cell.txtInput.delegate=self;
        
    }
    
    if(![obj.fieldType isEqualToString:@"Result"] || ![obj.fieldType isEqualToString:@"Schedule"])
        cell.lblTitle.text=[NSString stringWithFormat:@"%@:",obj.fieldLabel];
    else
        cell.lblTitle.text=obj.fieldLabel;
    
    
    
    //Getting values
   
    
    if(type == 2){ //Comparison Calculator.
        
        cell.txtInput1.tag=[[NSString stringWithFormat:@"10%d%d",indexPath.row,indexPath.section] intValue];
        cell.txtInput2.tag=[[NSString stringWithFormat:@"10%d%d",indexPath.row,indexPath.section] intValue];
        
        NSString *value1;
        NSString *value2;
        
        NSArray *vals=[obj.fieldValue componentsSeparatedByString:@"="];
      
        if(obj.isSuffix){
            value1=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:[vals objectAtIndex:0] andField:obj.fieldName],obj.valuePrefixSuffix];
            
            value2=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:[vals objectAtIndex:1] andField:obj.fieldName],obj.valuePrefixSuffix];
        }else{
            value1=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:[vals objectAtIndex:0] andField:obj.fieldName]];
            value2=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:[vals objectAtIndex:1] andField:obj.fieldName]];
        }
        
        
        if([obj.fieldType isEqualToString:@"Result"]){
            cell.lblResult1.text=value1;
            cell.lblResult2.text=value2;
        }
        else if([obj.fieldType isEqualToString:@"AmortResult"])
        {
            NSArray *arr=[obj.fieldValue componentsSeparatedByString:@"="];
            cell.lblResult1.text=[arr objectAtIndex:0];
            cell.lblResult2.text=[arr objectAtIndex:1];

        }
        else{
            cell.txtInput1.text=value1;
            cell.txtInput2.text=value2;
        }
    
    }else{
    
        cell.txtInput.tag=[[NSString stringWithFormat:@"10%d%d",indexPath.row,indexPath.section] intValue];
        
        NSString *value;
        
        if(obj.isSuffix){
            value=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName],obj.valuePrefixSuffix];
        }else{
            value=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName]];
        }
        
        
        if([obj.fieldType isEqualToString:@"Result"] || [obj.fieldType isEqualToString:@"Schedule"]){
            cell.lblValue.text=value;
        }else
            cell.txtInput.text=value;
    
    }
    
    
    if(type == 1){//Special Case Home Purchase        
        
        if([obj.fieldName isEqualToString:@"downpayment"])
            cell.lblTitle.text=[NSString stringWithFormat:@"%@ (%@):",obj.fieldLabel,obj.valuePrefixSuffix];
        
        if([obj.fieldName isEqualToString:@"downpaymentresult"])
            cell.lblTitle.text=[NSString stringWithFormat:@"%@ (%@):",obj.fieldLabel,obj.isSuffix?@"%":@"$"];
        
        cell.toggler.tag=indexPath.row;
        cell.toggler.selectedSegmentIndex=selectedIndex;
        
    }
    
       
    //Deciding images for the cell.
    
    int rows=[tblData count] - 1;
    
    if(type == 1){
        rows=[[tblData objectAtIndex:indexPath.section] count] - 1;
    }else if(type == 3){
        rows=[[[tblData objectAtIndex:indexPath.section] objectForKey:@"data"] count] - 1;
    }
    
    if(indexPath.row == 0 && rows == 0){
        cell.bgImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"calc_cell_single.png")];
    }else if(indexPath.row == 0)
        cell.bgImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"calc_cell_top.png")];
    else if(indexPath.row == rows){
        if([obj.fieldType isEqualToString:@"Schedule"])
            cell.bgImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"calc_cell_schedule.png")];
        else
            cell.bgImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"calc_cell_bottom.png")];
    }else
        cell.bgImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"calc_cell_middle.png")];    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    CalcForm *obj=[self getCurrentObjectForIndexPath:indexPath];
    
    if([obj.fieldType isEqualToString:@"Schedule"]){
        ScheduleControler *controller=[[ScheduleControler alloc] initWithNibName:@"ScheduleControler" bundle:nil];
        
        controller.paymentsSchedule = paymentsSchedule;

        [self.navigationController pushViewController:controller animated:YES];
        //[controller setPaymentsSchedule:paymentsSchedule];
        
        [controller.tbl reloadData];
        [controller release];
    }

}

-(NSString *)decideValueFormatForValue:(NSString *)fieldValue andField:(NSString *)field{
    
    if([field isEqualToString:@"payfrequency"] || [field isEqualToString:@"schedule"])
        return fieldValue;
    
    float value=[fieldValue floatValue];
        

    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	
    if([field isEqualToString:@"amount"] || [field isEqualToString:@"payment"] || [field isEqualToString:@"amountresult"] || [field isEqualToString:@"paymentresult"] || [field isEqualToString:@"price"] || [field isEqualToString:@"downpayment"] || [field isEqualToString:@"downpaymentresult"] || [field isEqualToString:@"balance"] || [field isEqualToString:@"antaxes"] || [field isEqualToString:@"condos"] || [field isEqualToString:@"premium"] || [field isEqualToString:@"mortgage"] || [field isEqualToString:@"monthpayment"] || [field isEqualToString:@"mortbalance"] || [field isEqualToString:@"qualifyingincome"] || [field isEqualToString:@"balanceresult"] || [field isEqualToString:@"income"] || [field isEqualToString:@"minmonthly"] || [field isEqualToString:@"taxes"] || [field isEqualToString:@"heatingcost"] || [field isEqualToString:@"condofees"] || [field isEqualToString:@"maxmortamount"] ||[field isEqualToString:@"mortgagetresult"])
        [numberFormatter setPositiveFormat:@"#,###,###,##0.00"];
    else if([field isEqualToString:@"rate"])
        [numberFormatter setPositiveFormat:@"##0.00####"];

	
    //NSLog(@"field %@,value %f",field,value);
    
    NSNumber *theScore = [NSNumber numberWithFloat:value];

    return [numberFormatter stringFromNumber:theScore];
}

-(IBAction)toggleAction:(id)sender{

    UISegmentedControl *toggler=(UISegmentedControl *)sender;
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:toggler.tag inSection:0];    
    
    CalcForm *temp=[self getCurrentObjectForIndexPath:indexPath];
    
    if(toggler.selectedSegmentIndex == 0){
        
        [tempDollar setFieldValue:temp.fieldValue];
        
        [temp setFieldValue:tempPercentage.fieldValue];
        [temp setValuePrefixSuffix:tempPercentage.valuePrefixSuffix];
        [temp setIsSuffix:tempPercentage.isSuffix];
    
    }else if(toggler.selectedSegmentIndex == 1){

        [tempPercentage setFieldValue:temp.fieldValue];
        
        [temp setFieldValue:tempDollar.fieldValue];
        [temp setValuePrefixSuffix:tempDollar.valuePrefixSuffix];
        [temp setIsSuffix:tempDollar.isSuffix];
    }
    
    [[tblData objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:temp];
    
    indexPath=[NSIndexPath indexPathForRow:toggler.tag+1 inSection:0];
    
    CalcForm *resultObj=[self getCurrentObjectForIndexPath:indexPath];
    
    resultObj.isSuffix=!temp.isSuffix;
    resultObj.fieldValue=temp.isSuffix?tempDollar.fieldValue:tempPercentage.fieldValue;
    resultObj.valuePrefixSuffix=temp.isSuffix?@"$":@"%";
    
    [[tblData objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:resultObj];
    
    
    selectedIndex=toggler.selectedSegmentIndex;
    
    //[tbl reloadData];
    
    //Calculate for changed values
    [self calculateValues];

}

-(void)getAllValues{
    
    for(CalcUICell *cell in [tbl visibleCells]){
        
        if([cell isKindOfClass:[CalcUICell class]]){
            if(type == 2){
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:cell.txtInput1.tag inSection:0];
                CalcForm *form=[tblData objectAtIndex:indexPath.row];
                [form setFieldValue:[NSString stringWithFormat:@"%@=%@",cell.txtInput1.text,cell.txtInput2.text]];
            }else{
                
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:cell.txtInput.tag inSection:0];
                CalcForm *form=[tblData objectAtIndex:indexPath.row];
                [form setFieldValue:cell.txtInput.text];
            }
        }
    }
    
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(picker){
        [picker hideModal];
        picker=nil;
    }
    
    NSIndexPath *indexPath=[self getIndexPathForTag:textField.tag - 1000];
    
    CalcForm *obj=[self getCurrentObjectForIndexPath:indexPath];
    
    if([obj.fieldType isEqualToString:@"Picker"] || [obj.fieldType isEqualToString:@"PickerDateMonth"]){
        
        if(type == 2){
        
            CalcUICell *cell=(CalcUICell *)[tbl cellForRowAtIndexPath:indexPath];
            
            if(textField == cell.txtInput1)
                selectedInput = 1;
            else if(textField == cell.txtInput2)
                selectedInput = 2;
        
        }
        
        [self openListForIndexPath:indexPath];
        
        return NO;
    }

    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:tbl];
    CGPoint pt = rc.origin;
    pt.x = 0;
    pt.y =  appdelegate.isIphone5 ? 0: (pt.y - 50);
    [tbl setContentOffset:pt animated:YES];

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    NSIndexPath *indexPath=[self getIndexPathForTag:textField.tag - 1000];
    NSString *val=textField.text;    
    
    if(type == 2){
        CalcUICell *cell=(CalcUICell *)[tbl cellForRowAtIndexPath:indexPath];
        val=[NSString stringWithFormat:@"%@=%@",[self removeExtraCharactersFromValue:cell.txtInput1.text],[self removeExtraCharactersFromValue:cell.txtInput2.text]];
    }else
        val=[self removeExtraCharactersFromValue:val];
        
    [self setValueForIndexPath:indexPath andValue:val];
    
    CGPoint pt;
    pt.x = 0;
    pt.y = 0;
    [tbl setContentOffset:pt animated:YES];
    
    
    
    return YES;
}

#pragma mark ====
#pragma mark Calculators


-(void)calculateValues{
    //Calculating Values

    if(type == 0)
        [self mortgageCalculator];
    else if(type == 1)
        [self homePurchaseCalculator];
    else if(type == 2)
        [self comparisonCalculator];
    else if(type == 3)
        [self affordCalculator];
    
    
    [tbl reloadData];


}


-(void)mortgageCalculator{

    if(mortCalcs.selectedSegmentIndex == 0){//Payment
        
        float amount,period,interest,paymentResult;
        int PLPLPaymentFrequency;
        
        CalcForm *resultObj;
        
        for(CalcForm *obj in tblData){
            
            if([obj.fieldName isEqualToString:@"amount"]){
                amount=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"amort"]){
                period=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"rate"]){
                interest=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"payfrequency"]){
                PLPLPaymentFrequency=[self getFrequecy:obj.fieldValue];
            }else if([obj.fieldName isEqualToString:@"paymentresult"]){
                resultObj=obj;
            }
            
        }
        
        //Validation
        amount=amount==0.0?250000.0f:amount;
        interest=interest==0.0?4.25f:interest;
        paymentResult=[CalculatorBusiness calculatePaymentsPayment:amount period:period*12 intrest:interest frequency:PLPLPaymentFrequency];
        
        [resultObj setFieldValue:[NSString stringWithFormat:@"%f",paymentResult]];
        
        if (!paymentsSchedule) {
            paymentsSchedule = [NSMutableArray new];
        }
        [paymentsSchedule removeAllObjects];
    
        [paymentsSchedule addObjectsFromArray:[CalculatorBusiness calculatePaymentsTablePayment:amount period:period*12 intrest:interest frequency:PLPLPaymentFrequency]];
        
    }else if(mortCalcs.selectedSegmentIndex == 1){//Mortgage
        
        float payment,period,interest,paymentResult;
        int PLPLPaymentFrequency;
        
        CalcForm *resultObj;
        
        for(CalcForm *obj in tblData){
            
            if([obj.fieldName isEqualToString:@"payment"]){
                payment=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"amort"]){
                period=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"rate"]){
                interest=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"payfrequency"]){
                PLPLPaymentFrequency=[self getFrequecy:obj.fieldValue];
            }else if([obj.fieldName isEqualToString:@"amountresult"]){
                resultObj=obj;
            }
            
        }
        
        //Validation
        payment=payment==0.0?1139.080f:payment;
        interest=interest==0.0?4.25f:interest;
        
        paymentResult=[CalculatorBusiness calculateMortgageAmountWithPayment:payment period:period*12 intrest:interest frequency:PLPLPaymentFrequency];
        
        [resultObj setFieldValue:[NSString stringWithFormat:@"%f",paymentResult]];
        
        if (!paymentsSchedule) {
            paymentsSchedule = [NSMutableArray new];
        }
        [paymentsSchedule removeAllObjects];
        [paymentsSchedule addObjectsFromArray:[CalculatorBusiness calculatePaymentsTablePayment:paymentResult period:period*12 intrest:interest frequency:PLPLPaymentFrequency]];
        
        
    }else if(mortCalcs.selectedSegmentIndex == 2){//Amortization
        float amount,payment,period,interest,amortResult;
        int PLPLPaymentFrequency;
        
        CalcForm *resultObj;
        
        for(CalcForm *obj in tblData){
            
            if([obj.fieldName isEqualToString:@"payment"]){
                payment=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"amort"]){
                period=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"rate"]){
                interest=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"payfrequency"]){
                PLPLPaymentFrequency=[self getFrequecy:obj.fieldValue];
            }else if([obj.fieldName isEqualToString:@"amortresult"]){
                resultObj=obj;
            }else if([obj.fieldName isEqualToString:@"amount"]){
                amount=[obj.fieldValue floatValue];
            }
            
        }
        
        //Validation
        amount=amount==0.0?250000.0f:amount;
        payment=payment==0.0?1139.080f:payment;
        interest=interest==0.0?4.25f:interest;
        
        amortResult=[CalculatorBusiness calculateAmortization:amount payment:payment intrest:interest frequency:PLPLPaymentFrequency];
        
        if (amortResult > 100.0f || isnan(amortResult) || isinf(amortResult) )
            [resultObj setFieldValue:@">100"];
        else
            [resultObj setFieldValue:[NSString stringWithFormat:@"%f",amortResult]];
        
        
        if (!paymentsSchedule) {
            paymentsSchedule = [NSMutableArray new];
        }
        [paymentsSchedule removeAllObjects];
        if (! (amortResult > 100.0f || isnan(amortResult) || isinf(amortResult)) )
        {
        [paymentsSchedule addObjectsFromArray:[CalculatorBusiness calculatePaymentsTablePayment:amount period:(amortResult * 12.0f) intrest:interest frequency:PLPLPaymentFrequency]];
        }
        
        
    }

}


-(void)homePurchaseCalculator{

    float purchasePrice,interestRate,amortization,propertyTax,condoFees,periodInMonths;
	float downPaymentPercent = 5.0f;
	float downPayment = 0.0f;
    
    int PLPaymentFrequency = PLPaymentFrequencyMonthly;
    
    BOOL isDownPaymentByPercentSelected=FALSE;
    
    for(CalcForm *obj in [tblData objectAtIndex:0]){
        
        if([obj.fieldName isEqualToString:@"price"]){
            purchasePrice=[obj.fieldValue floatValue];
        }else if([obj.fieldName isEqualToString:@"amort"]){
            amortization=[obj.fieldValue floatValue];
        }else if([obj.fieldName isEqualToString:@"rate"]){
            interestRate=[obj.fieldValue floatValue];
        }else if([obj.fieldName isEqualToString:@"payfrequency"]){
            PLPaymentFrequency=[self getFrequecy:obj.fieldValue];
        }else if([obj.fieldName isEqualToString:@"propertytax"]){
            propertyTax=[obj.fieldValue floatValue];
        }else if([obj.fieldName isEqualToString:@"condos"]){
            condoFees=[obj.fieldValue floatValue];
        }else if([obj.fieldName isEqualToString:@"term"]){
            periodInMonths=[obj.fieldValue floatValue];
        }else if([obj.fieldName isEqualToString:@"downpayment"]){
            if(obj.isSuffix){//Percentage
                isDownPaymentByPercentSelected=YES;
                downPaymentPercent=[obj.fieldValue floatValue];
            }else{//Dollar
                downPayment=[obj.fieldValue floatValue];
            }
        }
        
    }
    
    
	if (isDownPaymentByPercentSelected) {
		//downPaymentPercent = ([downPaymentPercentField.text isEqualToString:@""]) ? 5.0f : [downPaymentPercentField.text floatValue];
        mDownPaymentAmount = downPayment;
		downPaymentPercent *= 0.01;
		downPayment = purchasePrice * downPaymentPercent;
		
	} else {
		if (mDownPaymentAmount <= 0) {
			mDownPaymentAmount = purchasePrice * 0.05f;
		}else 
            mDownPaymentAmount=downPayment;
		//downPayment = ([downPaymentAmountField.text isEqualToString:@""]) ? purchasePrice * 0.05f : mDownPaymentAmount;
        downPayment=downPayment==0.0?purchasePrice * 0.05f:downPayment;
        
		if (purchasePrice >= -0.01f && purchasePrice <= 0.01f)
			downPaymentPercent = 0.0f;
		else
			downPaymentPercent = downPayment / purchasePrice;
		if (downPaymentPercent < 0.0f)	downPaymentPercent = 0.0f;
		if (downPaymentPercent > 1.0f)	downPaymentPercent = 1.0f;
	}
	
	float balance = purchasePrice - downPayment;
	
	interestRate *= 0.01;
    
    
    //Validation
    purchasePrice=purchasePrice==0.0?250000.0f:purchasePrice;
    downPaymentPercent=downPaymentPercent==0.0?5.0f:downPaymentPercent;
    
    interestRate=interestRate==0.0?4.25f:interestRate;
    amortization=amortization==0?25.0f:amortization;
    propertyTax=propertyTax==0.0?1500.00f:propertyTax;
    
    HomePurchasePayment homePurchasePayment = [CalculatorBusiness calculateHomePurchasePaymentWithPrice:purchasePrice
																	downPaymentRate:downPaymentPercent
																		downPayment:downPayment
																			balance:balance
																			   term:periodInMonths*12
																	   interestRate:interestRate
																	   amortization:amortization
																  annualPropertyTax:propertyTax
																		  condoFees:condoFees
																		  frequency:PLPaymentFrequency];

    
    for(CalcForm *obj in [tblData objectAtIndex:0]){
    
        if(isDownPaymentByPercentSelected && [obj.fieldName isEqualToString:@"downpaymentresult"]){
            [obj setFieldValue:[NSString stringWithFormat:@"%f",downPayment]];
            [tempDollar setFieldValue:obj.fieldValue];
        }else if(isDownPaymentByPercentSelected && [obj.fieldName isEqualToString:@"downpayment"]){
            [obj setFieldValue:[NSString stringWithFormat:@"%f",downPaymentPercent * 100.0f]];
            [tempPercentage setFieldValue:obj.fieldValue];
        }else if(!isDownPaymentByPercentSelected && [obj.fieldName isEqualToString:@"downpayment"]){
            [obj setFieldValue:[NSString stringWithFormat:@"%f",downPayment]];
            [tempDollar setFieldValue:obj.fieldValue];
        }else if(!isDownPaymentByPercentSelected && [obj.fieldName isEqualToString:@"downpaymentresult"]){
            [obj setFieldValue:[NSString stringWithFormat:@"%f",downPaymentPercent * 100.0f]];
            [tempPercentage setFieldValue:obj.fieldValue];
        }
        
        
        if([obj.fieldName isEqualToString:@"balance"])
        {
            [obj setFieldValue:[NSString stringWithFormat:@"%f",balance]];
        }    
    
    }
    
    //Put the calculated values back to display
    for(CalcForm *obj in [tblData objectAtIndex:1]){                    
            if([obj.fieldName isEqualToString:@"monthpayment"]){
                [obj setFieldValue:[NSString stringWithFormat:@"%f",homePurchasePayment.monthlyPayment]];
            }else if([obj.fieldName isEqualToString:@"premium"]){
                [obj setFieldValue:[NSString stringWithFormat:@"%f",homePurchasePayment.highRatioInsurrancePremmium]];
            }else if([obj.fieldName isEqualToString:@"mortgage"]){
                [obj setFieldValue:[NSString stringWithFormat:@"%f",homePurchasePayment.totalMortgageRequired]];
            }else if([obj.fieldName isEqualToString:@"mortbalance"]){
                [obj setFieldValue:[NSString stringWithFormat:@"%f",homePurchasePayment.mortgageBalance]];
            }else if([obj.fieldName isEqualToString:@"qualifyingincome"]){
                [obj setFieldValue:[NSString stringWithFormat:@"%d",homePurchasePayment.requiredAnnualIncomeToQualify]];
            }
        
    }
    
}


-(void)comparisonCalculator{

    if(mortCalcs.selectedSegmentIndex == 0){//Payment

    float amount1,amount2,intrestRate1,intrestRate2 ,periodInMonths1,periodInMonths2,termInMonths1,termInMonths2,payment1,payment2,balance1,balance2;
    
	PLPaymentFrequency frequency1,frequency2;
    
    
    for(CalcForm *obj in tblData){
    
        NSArray *arr=[obj.fieldValue componentsSeparatedByString:@"="];
        
        if([obj.fieldName isEqualToString:@"amount"]){
            amount1=[[arr objectAtIndex:0] floatValue];
            amount2=[[arr objectAtIndex:1] floatValue];
        }else if([obj.fieldName isEqualToString:@"rate"]){
            intrestRate1=[[arr objectAtIndex:0] floatValue];
            intrestRate2=[[arr objectAtIndex:1] floatValue];
        }else if([obj.fieldName isEqualToString:@"amort"]){
            periodInMonths1=[[arr objectAtIndex:0] floatValue];
            periodInMonths2=[[arr objectAtIndex:1] floatValue];
        }else if([obj.fieldName isEqualToString:@"term"]){
            termInMonths1=[[arr objectAtIndex:0] floatValue];
            termInMonths2=[[arr objectAtIndex:1] floatValue];
        }else if([obj.fieldName isEqualToString:@"payfrequency"]){
            frequency1=[self getFrequecy:[arr objectAtIndex:0]];
            frequency2=[self getFrequecy:[arr objectAtIndex:1]];
        }   
    }
    
    //Validation
    amount1=amount1==0.0?250000.0f:amount1;
    amount2=amount2==0.0?250000.0f:amount2;
    
    intrestRate1=intrestRate1==0.0?4.25f:intrestRate1;
    intrestRate2=intrestRate2==0.0?4.25f:intrestRate2;
    
	
	// Calculate Payments for column 1
	payment1 = [CalculatorBusiness calculatePaymentsPayment:amount1 period:periodInMonths1*12 intrest:intrestRate1 frequency:frequency1];
	balance1 = [CalculatorBusiness calculateBalanceAmount:amount1 paymentAmount:payment1 intrest:(float)intrestRate1 termPeriod:termInMonths1*12 frequency:frequency1];
    
	// Calculate Payments for column 2
	payment2 = [CalculatorBusiness calculatePaymentsPayment:amount2 period:periodInMonths2*12 intrest:intrestRate2 frequency:frequency2];
	balance2 = [CalculatorBusiness calculateBalanceAmount:amount2 paymentAmount:payment2 intrest:(float)intrestRate2 termPeriod:termInMonths2*12 frequency:frequency2];
    
    
    //Put back the result
    
    for(CalcForm *obj in tblData){
        if([obj.fieldType isEqualToString:@"Result"]){
            if([obj.fieldName isEqualToString:@"balanceresult"]){
                obj.fieldValue=[NSString stringWithFormat:@"%f=%f",balance1,balance2];
            }else if([obj.fieldName isEqualToString:@"paymentresult"]){
                obj.fieldValue=[NSString stringWithFormat:@"%f=%f",payment1,payment2];
            }
        
        }
    
    }
    }
    if(mortCalcs.selectedSegmentIndex == 1){//Mortgage
        
        float amount1,amount2,intrestRate1,intrestRate2 ,periodInMonths1,periodInMonths2,termInMonths1,termInMonths2,payment1,payment2,balance1,balance2;
        
               
        
        for(CalcForm *obj in tblData){
            
            NSArray *arr=[obj.fieldValue componentsSeparatedByString:@"="];
            
            if([obj.fieldName isEqualToString:@"amount"]){
                payment1=[[arr objectAtIndex:0] floatValue];
                payment2=[[arr objectAtIndex:1] floatValue];
            }else if([obj.fieldName isEqualToString:@"rate"]){
                intrestRate1=[[arr objectAtIndex:0] floatValue];
                intrestRate2=[[arr objectAtIndex:1] floatValue];
            }else if([obj.fieldName isEqualToString:@"amort"]){
                periodInMonths1=[[arr objectAtIndex:0] floatValue];
                periodInMonths2=[[arr objectAtIndex:1] floatValue];
            }else if([obj.fieldName isEqualToString:@"term"]){
                termInMonths1=[[arr objectAtIndex:0] floatValue];
                termInMonths2=[[arr objectAtIndex:1] floatValue];
            }
//            }else if([obj.fieldName isEqualToString:@"payfrequency"]){
//                frequency1=[self getFrequecy:[arr objectAtIndex:0]];
//                frequency2=[self getFrequecy:[arr objectAtIndex:1]];
//            }   
        }
        
        //Validation
        payment1=payment1==0.0?1139.08f:payment1;
        payment2=payment2==0.0?1139.08f:payment2;
        
        intrestRate1=intrestRate1==0.0?4.25f:intrestRate1;
        intrestRate2=intrestRate2==0.0?4.25f:intrestRate2;
        
        
        amount1 = [CalculatorBusiness calculateMortgageAmountWithPayment:payment1 period:periodInMonths1*12 intrest:intrestRate1 frequency:PLPaymentFrequencyMonthly];
        balance1 = [CalculatorBusiness calculateBalanceAmount:amount1 paymentAmount:payment1 intrest:(float)intrestRate1 termPeriod:termInMonths1*12 frequency:PLPaymentFrequencyMonthly];
        
        // Calculate Payments for column 2
        amount2 = [CalculatorBusiness calculateMortgageAmountWithPayment:payment2 period:periodInMonths2*12 intrest:intrestRate2 frequency:PLPaymentFrequencyMonthly];
        balance2 = [CalculatorBusiness calculateBalanceAmount:amount2 paymentAmount:payment2 intrest:(float)intrestRate2 termPeriod:termInMonths2*12 frequency:PLPaymentFrequencyMonthly];
        //Put back the result
        for(CalcForm *obj in tblData){
            if([obj.fieldType isEqualToString:@"Result"]){
                if([obj.fieldName isEqualToString:@"balanceresult"]){
                    obj.fieldValue=[NSString stringWithFormat:@"%f=%f",balance1,balance2];
                }else if([obj.fieldName isEqualToString:@"mortgagetresult"]){
                    obj.fieldValue=[NSString stringWithFormat:@"%f=%f",amount1,amount2];
                }
                
            }
            
        }

    }
    if(mortCalcs.selectedSegmentIndex == 2){//AMortization
        float amount1,amount2,intrestRate1,monthlyMortgage1,monthlyMortgage2,intrestRate2,amortization1,amortization2;
        
        for(CalcForm *obj in tblData){
            
            NSArray *arr=[obj.fieldValue componentsSeparatedByString:@"="];
            
            if([obj.fieldName isEqualToString:@"amount"]){
                amount1=[[arr objectAtIndex:0] floatValue];
                amount2=[[arr objectAtIndex:1] floatValue];
            }else if([obj.fieldName isEqualToString:@"rate"]){
                intrestRate1=[[arr objectAtIndex:0] floatValue];
                intrestRate2=[[arr objectAtIndex:1] floatValue];
            }else if([obj.fieldName isEqualToString:@"mortgage"]){
                monthlyMortgage1=[[arr objectAtIndex:0] floatValue];
                monthlyMortgage2=[[arr objectAtIndex:1] floatValue];
            }
        }

        amount1=amount1==0.0?250000.00f:amount1;
        amount2=amount2==0.0?250000.00f:amount2;

        monthlyMortgage1 = 0.0?1349.15f:monthlyMortgage1;
        monthlyMortgage2 = 0.0?1139.08f:monthlyMortgage2;
        intrestRate1=intrestRate1==0.0?4.25f:intrestRate1;
        intrestRate2=intrestRate2==0.0?4.25f:intrestRate2;

        
        // Calculate Payments for column 1
        amortization1 = [CalculatorBusiness calculateAmortization:amount1 payment:monthlyMortgage1 intrest:intrestRate1 frequency:PLPaymentFrequencyMonthly];
        
        // Calculate Payments for column 2
        amortization2 = [CalculatorBusiness calculateAmortization:amount2 payment:monthlyMortgage2 intrest:intrestRate2 frequency:PLPaymentFrequencyMonthly];
        
        //NSLog(@"answer is %@",[self getResultTextForAmort1:amortization1 andAmort2:amortization2]);
       
        for(CalcForm *obj in tblData){
            if([obj.fieldType isEqualToString:@"AmortResult"]){
                if([obj.fieldName isEqualToString:@"amort"]){
                    obj.fieldValue=[NSString stringWithFormat:@"%@=%@",[self getResultTextForAmort1:amortization1],[self getResultTextForAmort1:amortization2]];
                }
                
            }
            
        }

    }

    
}

-(NSString *)getResultTextForAmort1:(float)amortization 
{
    NSString *result=@"";
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"###,##0.00"];
	
	if (amortization > 100.0f || isnan(amortization) || isinf(amortization) ) {
		result = [NSString stringWithFormat:@">100 years"];
	} else {
		NSNumber *yearsNum = [NSNumber numberWithFloat:amortization];
		result= [NSString stringWithFormat:@"%@ years", [numberFormatter stringFromNumber:yearsNum]];
	}
    
	    
    return result;
}

-(void)affordCalculator{

    
    float income,obligations,propertyTaxes,heatingCost,condoFees ,interestRate, payment;
    int amortization;
    
    
    for(NSDictionary *dic in tblData){
    
        for(CalcForm *obj in [dic objectForKey:@"data"]){
        
            if([obj.fieldName isEqualToString:@"income"]){
                income=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"obligations"]){
                obligations=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"heatingcost"]){
                heatingCost=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"propertyTaxes"]){
                propertyTaxes=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"condofees"]){
                condoFees=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"rate"]){
                interestRate=[obj.fieldValue floatValue];
            }else if([obj.fieldName isEqualToString:@"amort"]){
                amortization=[obj.fieldValue intValue];
            }        
        }
    
    }
    
    //Validation
    income=income==0.0?51870.0f:income;
    propertyTaxes=propertyTaxes==0.0?1500.0f:propertyTaxes;
    heatingCost=heatingCost==0.0?100.0f:heatingCost;
    interestRate=interestRate==0.0?4.25f:interestRate;
	
	// Calculate Payment
	payment = [CalculatorBusiness calculateAffordablePlanIncome:income 
												   Objligations:obligations 
												   PropetyTaxes:propertyTaxes 
													HeatingCost:heatingCost 
													  CondoFees:condoFees 
												   InterestRate:interestRate 
												   Amortization:amortization];
    
    
    
    for(NSDictionary *dic in tblData){
    
        if([[dic objectForKey:@"title"] isEqualToString:@""]){
        
            [[[dic objectForKey:@"data"] objectAtIndex:0] setFieldValue:[NSString stringWithFormat:@"%f",payment]];
        
        }
    
    }

}

#pragma mark =======


-(int)getFrequecy:(NSString *)frequency{

    if([frequency isEqualToString:@"Monthly"])
        return PLPaymentFrequencyMonthly;
    else if([frequency isEqualToString:@"Semi-Monthly"])
        return PLPaymentFrequencySemiMonthly;
    else if([frequency isEqualToString:@"Weekly"])
        return PLPaymentFrequencyWeekly;
    else if([frequency isEqualToString:@"Bi-Weekly"])
        return PLPaymentFrequencyBiWeekly;
    else if([frequency isEqualToString:@"Accelerated Weekly"])
        return PLPaymentFrequencyAcceleratedWeekly;
    else if([frequency isEqualToString:@"Accelerated Bi-Weekly"])
        return PLPaymentFrequencyAcceleratedBiWeekly;
    

    return PLPaymentFrequencyMonthly;
}

-(NSString *)removeExtraCharactersFromValue:(NSString *)value{
    
    //Remove % $ years etc from value
    
    NSRange found=[value rangeOfString:@"$"];
    
    if(found.location != NSNotFound){
        value=[value stringByReplacingOccurrencesOfString:@"$" withString:@""];
        value=[value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    found=[value rangeOfString:@"%"];
    
    if(found.location != NSNotFound){
        value=[value stringByReplacingOccurrencesOfString:@"%" withString:@""];
        value=[value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    found=[value rangeOfString:@"years"];
    
    if(found.location != NSNotFound){
        value=[value stringByReplacingOccurrencesOfString:@"years" withString:@""];
        value=[value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    found=[value rangeOfString:@","];
    
    if(found.location != NSNotFound){
        value=[value stringByReplacingOccurrencesOfString:@"," withString:@""];
        value=[value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    
    return value;
    
}

-(NSIndexPath *)getIndexPathForTag:(int)tTag{
    //Extracting exact row and section selected within textfield
    int row;
    int section;
    
    if(tTag == 0){
        row=section=0;
    }else{
        section=tTag % 10;
        row=tTag/10;
    }
    
    NSLog(@"Row = %d Section = %d",row,section);
    
    return [NSIndexPath indexPathForRow:row inSection:section];

}

-(CalcForm *)getCurrentObjectForIndexPath:(NSIndexPath *)indexPath{

    CalcForm *obj;
    if(type == 1)
        obj=[[tblData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    else if(type == 3)
        obj=[[[tblData objectAtIndex:indexPath.section] objectForKey:@"data"] objectAtIndex:indexPath.row];
    else
        obj=[tblData objectAtIndex:indexPath.row];
    
    return obj;

}

-(void)setValueForIndexPath:(NSIndexPath *)indexPath andValue:(NSString *)value{

    CalcForm *obj=[self getCurrentObjectForIndexPath:indexPath];
    
    [obj setFieldValue:value];
    
    [tbl reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self calculateValues];

}

-(void)openListForIndexPath:(NSIndexPath *)indexPath{
    
//    [self getAllValues];
    
    for(CalcUICell *cell in [tbl visibleCells]){
        
        if([cell isKindOfClass:[CalcUICell class]]){
            if(type == 2){
                [cell.txtInput1 resignFirstResponder];
                [cell.txtInput2 resignFirstResponder];
            }else    
                [cell.txtInput resignFirstResponder];

        }
        
    }
    
    CalcForm *form=[self getCurrentObjectForIndexPath:indexPath];
    
    if(!picker){
        NSString *selectedVal=form.fieldValue;
        
        if(type == 2){
            NSArray *vals=[selectedVal componentsSeparatedByString:@"="];
            if(selectedInput == 1)
                selectedVal=[vals objectAtIndex:0];
            else if(selectedInput == 2)
                selectedVal=[vals objectAtIndex:1];
        }
        
        
        picker=[[PickerViewController alloc] init];
        picker.parent=self;
        picker.selectedValue=selectedVal;
        picker.type=form.fieldName;
        picker.selectedForm=form;
        picker.selectedInput=selectedInput;
        [picker showModal];
        
    }else
        [picker hideModal];
    
    
}

-(void)hideModal{
    
    if(picker){
        [picker hideModal];
        picker=nil;
    }
    
    //Calculates if change
    [self calculateValues];
    
}


    

#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
    
    
	MFMailComposeViewController *pickerMail = [[MFMailComposeViewController alloc] init];
	pickerMail.mailComposeDelegate = self;
    [pickerMail setSubject:@"Your Jencor App Calculations."];

	// Attach an image to the email
    
	// Fill out the email body text
	NSString *emailBody = [CalculatorBusiness getScreenSummaryWithData:[tblData retain] forType:type];
    if (type == 0) {
        NSString *attachment=[self getScheduleSummary];
        if (attachment != nil)
        {
            NSData *myData = [attachment dataUsingEncoding:NSUTF8StringEncoding];
            [pickerMail addAttachmentData:myData mimeType:@"text/html" fileName:@"schedule.htm"];
        }

       
    }
    
    emailBody = [NSString stringWithFormat:@"%@\n\n\n\n%@",emailBody,@"Information and interactive calculators are made available to you as self-help tools for your independent use and are not intended to provide mortgage advice. We cannot and do not guarantee their applicability or accuracy in regards to your individual circumstances. All examples are hypothetical and are for illustrative purposes. We encourage you to seek personalized advice from one of our qualified mortgage professionals regarding all personal mortgage needs."];
    [pickerMail setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:pickerMail animated:YES];
    
     appdelegate.viewButtons.hidden=TRUE;
    [pickerMail release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	//message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Result: saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Result: sent");
            break;
		case MFMailComposeResultFailed:
			NSLog( @"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
    
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
    //NSString *error1 = NSLocalizedString(@"No Mail Account!", nil);
    
    NSString *error2 = NSLocalizedString(@"Please check the login status in the Mail app and try again.", nil);
    
    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"No Mail Account!" message:error2
                              
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [AlertView show];
    
    [AlertView release];
    
}
 
- (NSString*) getScheduleSummary {
	NSString * summary=@"";
	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"#,###,###,###,##0.00"];
	summary = [summary stringByAppendingFormat:@"<html><head>Payment Schedule</head><body><table border='0'><tr><td>Payment No.</td><td>Balance</td><td>Principle</td><td>Interest</td></tr>"];
	for (int i = 0; i < [paymentsSchedule count]; i++) {
		Payment* obj = [paymentsSchedule objectAtIndex:i];
		summary = [summary stringByAppendingFormat:@"<tr><td>%d</td><td>$%@</td><td>$%@</td><td>$%@</td></tr>",
				   obj.paymentNumber,
				   [numberFormatter stringFromNumber:[NSNumber numberWithFloat:obj.balance]],
				   [numberFormatter stringFromNumber:[NSNumber numberWithFloat:obj.principle]],
				   [numberFormatter stringFromNumber:[NSNumber numberWithFloat:obj.interest]]
				   ];
	}
	summary = [summary stringByAppendingFormat:@"</head></html>"];
	return summary;
}

- (IBAction)emailAction:(id)sender {
    
    NSLog(@"Email");
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
    }

}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
     appdelegate.viewButtons.hidden=FALSE;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(picker){
        [picker hideModal];
        picker=nil;
    }
}
  
- (void)viewDidUnload
{
    [self setTbl:nil];
    [self setLblTitle:nil];
    [self setMortCalcs:nil];
     [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [tbl release];
    [lblTitle release];
    [mortCalcs release];
    [container release];
    [imgView release];
      [super dealloc];
}
@end
