//
//  CalcForm.m
//  Jencor
//
//  Created by Ved Prakash on 11/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "CalcForm.h"


@implementation CalcForm
@synthesize fieldName,fieldType,mandatory,fieldLabel,fieldValue,valuePrefixSuffix,isSuffix;

- (void)dealloc {
    [fieldLabel release];
    [fieldName release];
    [fieldValue release];
    [fieldType release];
    [valuePrefixSuffix release];
    [super dealloc];
}


-(id)getMortgageCalcWithRate:(Rate *)rate type:(NSString *)type{   
    
    availableRate=rate;
    
    NSString *strLabel=@"";
    
    
    if([type isEqualToString:@"Payment"])
        strLabel=@"Mortage Amount,Text,1,amount,250000.00,$,0#Amortization,PickerDateMonth,1,amort,35,years,1#Interest,Text,1,rate,4.25,%,1#Payment Frequency,Picker,1,payfrequency,Monthly,,0#Payment,Result,0,paymentresult,1139.08,$,0#Schedule,Schedule,1,schedule,,,0";
    else if([type isEqualToString:@"Mortgage"])
        strLabel=@"Mortage Payment,Text,1,payment,1139.08,$,0#Amortization,PickerDateMonth,1,amort,35,years,1#Interest,Text,1,rate,4.25,%,1#Payment Frequency,Picker,1,payfrequency,Monthly,,0#Mortgage Amount,Result,0,amountresult,250000.11,$,0#Schedule,Schedule,1,schedule,,,0";
    else if([type isEqualToString:@"Amort"])
        strLabel=@"Mortage Amount,Text,1,amount,250000.00,$,0#Mortage Payment,Text,1,payment,1139.08,$,0#Interest,Text,1,rate,4.25,%,1#Payment Frequency,Picker,1,payfrequency,Monthly,,0#Amortization,Result,0,amortresult,35,years,1#Schedule,Schedule,1,schedule,,,0";
    
  
    
    NSMutableArray *mainArr=[self prepareArrayWithLabels:strLabel];    
        
    return mainArr;    
}



-(id)getCompareCalcPaymentWithRate:(Rate *)rate type:(NSString *)type{   
    
    availableRate=rate;
    isCreatingCompareForm=TRUE;
    
    NSString *strLabel=@"";
    if([type isEqualToString:@"Payment"])

      strLabel=@"Mortage Amount,Text,1,amount,250000.00=250000.00,$,0#Amortization,PickerDateMonth,1,amort,35=35,years,1#Interest,Text,1,rate,4.25=4.25,%,1#Payment Frequency,Picker,1,payfrequency,Monthly=Monthly,,0#Term,Picker,1,term,5=5,years,1#Balance (end of term),Result,1,balanceresult,232575.55=232575.55,$,0#Payment Amount,Result,1,paymentresult,1139.08=1139.08,$,0";
     else if([type isEqualToString:@"Mortgage"])
         strLabel=@"Mortage Pyment,Text,1,amount,1139.08=1139.08,$,0#Amortization,PickerDateMonth,1,amort,35=35,years,1#Interest,Text,1,rate,4.25=4.25,%,1#Term,Picker,1,term,5=5,years,1#Balance (end of term),Result,1,balanceresult,232575.66=232575.66,$,0,0#Mortage Amount,Result,1,mortgagetresult,250000.11=250000.11,$,0";
    
    else if([type isEqualToString:@"Amort"])
        strLabel=@"Mortage Amount,Text,1,amount,250000.00=250000.00,$,0#Monthly Mortage Amount,Text,1,mortgage,1349.15=1139.08,$,0#Interest,Text,1,rate,4.25=4.25,%,1#Amortization,AmortResult,1,amort,25=35,years,1";

    NSMutableArray *mainArr=[self prepareArrayWithLabels:strLabel];    
    
    return mainArr;
    
    
    
}


-(id)getHomePurchaseCalcWithRate:(Rate *)rate{   
    
    availableRate=rate;
    
    NSString *strLabel=@"Purchase Price,Text,1,price,250000.00,$,0#Down Payment,TextWithOption,1,downpayment,5,%,1#Down Payment,Result,1,downpaymentresult,12500.00,$,0#Balance,Result,1,balance,237500.00,$,0#Term,Picker,1,term,5,years,1#Interest Rate,Rate,1,rate,4.25,%,1#Amortization,PickerDateMonth,1,amort,25,years,1#Payment Frequency,Picker,1,payfrequency,Monthly,,0#Annual Property Taxes,Text,1,propertytax,1500.00,$,0#Monthly Condo Fees,Text,1,condos,0.00,$,0";
    
    
    
    NSMutableArray *mainArr=[[NSMutableArray alloc]init];
    
    [mainArr addObject:[self prepareArrayWithLabels:strLabel]];
    
    
    
    strLabel=@"High Ratio Insurance Premium,Result,0,premium,6531.25,$,0#Total Mortgage Required,Result,0,mortgage,244031.25,$,0#Monthly Payment,Result,0,monthpayment,1316.94,$,0#Mortgage Balance(end of term),Result,0,mortbalance,213354.30,$,0#Estimated Annual Income Required to Qualify,Result,1,qualifyingincome,57900.00,$,0";
    
    
    [mainArr addObject:[self prepareArrayWithLabels:strLabel]];
    
    
    return mainArr;    
    
}


-(id)getAffordCalcWithRate:(Rate *)rate{   
    
    availableRate=rate;
    
    NSString *strLabel=@"Annual Family Income(before Tax),Text,1,income,51870.00,$,0#Minimum Monthly Other Obligations,Text,1,obligations,0.00,$,0";    
    
    NSMutableArray *mainArr=[[NSMutableArray alloc]init];
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    
    [dic setObject:@"Your Information" forKey:@"title"];
    [dic setObject:[self prepareArrayWithLabels:strLabel] forKey:@"data"];

    [mainArr addObject:dic];
    
    
    
    strLabel=@"Annual Property Taxes,Text,1,propertyTaxes,1500.00,$,0#Monthly Heating Costs,Text,1,heatingcost,100,$,0#Monthly Condo Fees:(if applicable),Text,1,condofees,0,$,0";
    
    dic=[[NSMutableDictionary alloc] init];
    
    [dic setObject:@"Property Information" forKey:@"title"];
    [dic setObject:[self prepareArrayWithLabels:strLabel] forKey:@"data"];
    
    [mainArr addObject:dic];
    
    
    strLabel=@"Mortgage Interest Rate,Text,1,rate,4.25,%,1#Amortization,PickerDateMonth,1,amort,25,years,1";
    
    dic=[[NSMutableDictionary alloc] init];
    
    [dic setObject:@"Mortgage Information" forKey:@"title"];
    [dic setObject:[self prepareArrayWithLabels:strLabel] forKey:@"data"];
    
    [mainArr addObject:dic];
    
    strLabel=@"Max Mortgage Amount,Result,1,maxmortamount,214616.58,$,0";
    
    dic=[[NSMutableDictionary alloc] init];
    
    [dic setObject:@"" forKey:@"title"];
    [dic setObject:[self prepareArrayWithLabels:strLabel] forKey:@"data"];
    
    [mainArr addObject:dic];
    
    
    return mainArr;
    
    
    
}

-(NSMutableArray *)prepareArrayWithLabels:(NSString *)strLabel{
    
    NSArray *arr=[strLabel componentsSeparatedByString:@"#"];

    NSMutableArray *mainArr=[[NSMutableArray alloc]init];
    
    for(NSString *s in arr){
        NSArray *vals=[s componentsSeparatedByString:@","];
        CalcForm *obj=[[CalcForm alloc] init];
        [obj setFieldLabel:[NSString stringWithFormat:@"%@",NSLocalizedString([vals objectAtIndex:0], nil)]];
        
        NSString *format=[vals objectAtIndex:1];
        NSString *field=[vals objectAtIndex:3];
        NSString *value=[vals objectAtIndex:4];
        NSString *sufpref=[vals objectAtIndex:5];
        int mandate=[[vals objectAtIndex:2] intValue];

        int suffix=[[vals objectAtIndex:6] intValue];
        
        [obj setMandatory:mandate];
        [obj setFieldType:format];
        [obj setFieldName:field];
        
        [obj setIsSuffix:suffix];
        [obj setFieldValue:value];
        [obj setValuePrefixSuffix:sufpref];
        
        if([obj.fieldName isEqualToString:@"rate"]){
            if(!isCreatingCompareForm)
                [obj setFieldValue:availableRate.ourRate];
            else
                [obj setFieldValue:[NSString stringWithFormat:@"%@=%@",availableRate.ourRate,availableRate.ourRate]];
        }
        
        [mainArr addObject:obj];    
        
    }
    
    return mainArr;

}


-(id)getMortgagePayementFormWithRate:(Rate *)rate{   
    
    availableRate=rate;
    
    NSString *strLabel=@"Purchase Price,Text,1,price#Down Payment,Rate,1,downPayment#Mortgage Amount,Display,1,amount#Rate,Rate,1,rate#Term,List,1,term#Amortization,List,1,amort";
    
    
    NSArray *arr=[strLabel componentsSeparatedByString:@"#"];
    
    NSMutableArray *mainArr=[[NSMutableArray alloc]init];
    
    for(NSString *s in arr){
        NSArray *vals=[s componentsSeparatedByString:@","];
        CalcForm *obj=[[CalcForm alloc] init];
        [obj setFieldLabel:[NSString stringWithFormat:@"%@:",NSLocalizedString([vals objectAtIndex:0], nil)]];
        
        NSString *format=[vals objectAtIndex:1];
        NSString *field=[vals objectAtIndex:3];
        int mandate=[[vals objectAtIndex:2] intValue];
        
        [obj setMandatory:mandate];
        [obj setFieldType:format];
        [obj setFieldName:field];
        
        if([obj.fieldName isEqualToString:@"rate"]){
            [obj setFieldValue:rate.ourRate];
        }
        
        [mainArr addObject:obj];    
        
    }
    
    return mainArr;
    
    
    
}
@end
