//
//  CalculatorBusiness.m
//  iPhoneApp
//
//  Created by Haseeb Yousaf on 10/20/10.
//  Copyright 2010 Penta::Loop Pvt. Ltd. All rights reserved.
//

#import "CalculatorBusiness.h"
#import "CalcForm.h"

@implementation Payment
@synthesize paymentNumber;
@synthesize balance;
@synthesize principle;
@synthesize interest;
- (void)dealloc {
	[super dealloc];
}
@end


@implementation CalculatorBusiness

+(NSString *)getScreenSummaryWithData:(NSMutableArray *)data forType:(int)type{       
     NSString *str=@"\nHere is a summary of your calculations:\n\n";
    
    switch (type) {
        case 0:
            for(CalcForm *obj in data){
                NSString *value;
                if(obj.isSuffix){
                    value=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName],obj.valuePrefixSuffix];
                }else{
                    value=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName]];
                    value=[value stringByReplacingOccurrencesOfString:@"$ " withString:@"$"];
                }
                
                if(![obj.fieldName isEqualToString:@"schedule"])
                    str=[str stringByAppendingFormat:@"%@: %@ \n",obj.fieldLabel,value];
            }
           NSLog(@"string is %@",str);
            break;
        case 1:
            
            for(CalcForm *obj in [data objectAtIndex:0]){
                NSString *value;
                if(obj.isSuffix){
                    value=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName],obj.valuePrefixSuffix];
                }else{
                    value=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName]];
                    value=[value stringByReplacingOccurrencesOfString:@"$ " withString:@"$"];
                }
                
                str=[str stringByAppendingFormat:@"%@: %@ \n",obj.fieldLabel,value];
            }
            str=[str stringByAppendingFormat:@"%@ \n\n\n",@"\n\n"];
            for(CalcForm *obj in [data objectAtIndex:1]){
                NSString *value;
                if(obj.isSuffix){
                    value=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName],obj.valuePrefixSuffix];
                }else{
                    value=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName]];
                     value=[value stringByReplacingOccurrencesOfString:@"$ " withString:@"$"];
                }
                
                str=[str stringByAppendingFormat:@"%@: %@ \n",obj.fieldLabel,value];
            }

            break;
        case 2:
            
            str=[str stringByAppendingFormat:@"\n\nOPTION A\n\n"];
            for(CalcForm *obj in data){                               
                NSString *value;
                NSArray *vals=[obj.fieldValue componentsSeparatedByString:@"="];
                if(obj.isSuffix){
                    value=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:[vals objectAtIndex:0] andField:obj.fieldName],obj.valuePrefixSuffix];
                }else{
                   value=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:[vals objectAtIndex:0] andField:obj.fieldName]];
                    value=[value stringByReplacingOccurrencesOfString:@"$ " withString:@"$"];
                }
                
                str=[str stringByAppendingFormat:@"%@: %@ \n",obj.fieldLabel,value];
            }
            str=[str stringByAppendingFormat:@"\n\nOPTION B\n\n"];
            for(CalcForm *obj in data){                               
                NSString *value;
                NSArray *vals=[obj.fieldValue componentsSeparatedByString:@"="];
                if(obj.isSuffix){
                    value=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:[vals objectAtIndex:1] andField:obj.fieldName],obj.valuePrefixSuffix];
                }else{
                    value=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:[vals objectAtIndex:1] andField:obj.fieldName]];
                     value=[value stringByReplacingOccurrencesOfString:@"$ " withString:@"$"];
                }
                
                str=[str stringByAppendingFormat:@"%@: %@ \n",obj.fieldLabel,value];
            }

            break;
        case 3:
            for (NSDictionary *dic in data) {
                str=[str stringByAppendingFormat:@"%@ \n",[dic objectForKey:@"title"]];
                for (CalcForm *obj in [dic objectForKey:@"data"]) {
                    NSString *value;
                    if(obj.isSuffix){
                        value=[NSString stringWithFormat:@"%@ %@",[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName],obj.valuePrefixSuffix];
                    }else{
                        value=[NSString stringWithFormat:@"%@ %@",obj.valuePrefixSuffix,[self decideValueFormatForValue:obj.fieldValue andField:obj.fieldName]];
                        value=[value stringByReplacingOccurrencesOfString:@"$ " withString:@"$"];
                    }
                    
                    str=[str stringByAppendingFormat:@"%@: %@ \n",obj.fieldLabel,value];
                    
                }
            }

            break;
        default:
            break;
    }
 
    
    str=[str stringByAppendingFormat:@"\n\nCreated with JencorApp for iPod Touch and iPhone.\n Visit us at %@",WEBSITE_URL];
    
  

    return str;
}

+(NSString *)decideValueFormatForValue:(NSString *)fieldValue andField:(NSString *)field{
    
    if([field isEqualToString:@"payfrequency"] || [field isEqualToString:@"schedule"])
        return fieldValue;
    
    float value=[fieldValue floatValue];
    
    
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	
    if([field isEqualToString:@"amount"] || [field isEqualToString:@"payment"] || [field isEqualToString:@"amountresult"] || [field isEqualToString:@"paymentresult"] || [field isEqualToString:@"price"] || [field isEqualToString:@"downpayment"] || [field isEqualToString:@"downpaymentresult"] || [field isEqualToString:@"balance"] || [field isEqualToString:@"antaxes"] || [field isEqualToString:@"condos"] || [field isEqualToString:@"premium"] || [field isEqualToString:@"mortgage"] || [field isEqualToString:@"monthpayment"] || [field isEqualToString:@"mortbalance"] || [field isEqualToString:@"qualifyingincome"] || [field isEqualToString:@"balanceresult"] || [field isEqualToString:@"income"] || [field isEqualToString:@"minmonthly"] || [field isEqualToString:@"taxes"] || [field isEqualToString:@"heatingcost"] || [field isEqualToString:@"condofees"] || [field isEqualToString:@"maxmortamount"] ||[field isEqualToString:@"mortgagetresult"])
        [numberFormatter setPositiveFormat:@"#,###,###,##0.00"];
    else if([field isEqualToString:@"rate"] || [field isEqualToString:@"term"])
        [numberFormatter setPositiveFormat:@"##0.00####"];
    
	
    //NSLog(@"field %@,value %f",field,value);
    
    NSNumber *theScore = [NSNumber numberWithFloat:value];
    
    return [numberFormatter stringFromNumber:theScore];
}


+(float)calculatePaymentsPayment:(float)amount period:(float)period intrest:(float)intrest frequency:(PLPaymentFrequency)frequency {
	//((1+D7/2)^(1/6)-1)*(D5+(D5/((1+((1+D7/2)^(1/6)-1))^(D6*12)-1)))
	float timePeriod = period;
	float denom = 1.0f;
	float interestFactor = 6.0;
	switch (frequency) {
		case PLPaymentFrequencyMonthly: {
			interestFactor = 6.0;
		}
			break;
		case PLPaymentFrequencySemiMonthly: {
			timePeriod = timePeriod * 2.0f;
			interestFactor = 12.0;
		}
			break;
		case PLPaymentFrequencyBiWeekly: {
			timePeriod = (timePeriod / 12.0f) * 26.0f;
			interestFactor = 13.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedBiWeekly: {
			denom = 2.0f;
			interestFactor = 6.0;
		}
			break;
		case PLPaymentFrequencyWeekly: {
			timePeriod = (timePeriod / 12.0f) * 52.0f;
			interestFactor = 26.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedWeekly: {
			denom = 4.0f;
			interestFactor = 6.0;
		}
			break;
		default:
			break;
	}
	
	float ip = pow((1.0f+(intrest/100.0f)/2.0f),(1.0f/interestFactor)) - 1.0f; 
	float pmt = ip * (amount + (amount / (pow((1.0f + ip),(timePeriod))-1.0f)));
	pmt = pmt / denom;
	return pmt;
}

+(NSArray*)calculatePaymentsTablePayment:(float)amount period:(float)period intrest:(float)intrest frequency:(PLPaymentFrequency)frequency {
	NSMutableArray* result = [NSMutableArray new];
	
	float timePeriod = period;
	float denom = 1.0f;
	float interestFactor = 6.0;
	switch (frequency) {
		case PLPaymentFrequencyMonthly: {
			interestFactor = 6.0;
		}
			break;
		case PLPaymentFrequencySemiMonthly: {
			timePeriod = timePeriod * 2.0f;
			interestFactor = 12.0;
		}
			break;
		case PLPaymentFrequencyBiWeekly: {
			timePeriod = (timePeriod / 12.0f) * 26.0f;
			interestFactor = 13.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedBiWeekly: {
			denom = 2.0f;
			interestFactor = 13.0;
		}
			break;
		case PLPaymentFrequencyWeekly: {
			timePeriod = (timePeriod / 12.0f) * 52.0f;
			interestFactor = 26.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedWeekly: {
			denom = 4.0f;
			interestFactor = 26.0;
		}
			break;
		default:
			break;
	}
	
	float ip = pow((1.0f+(intrest/100.0f)/2.0f),(1.0f/interestFactor)) - 1.0f; 
	double NPER = 1;
	double PMT = -[CalculatorBusiness calculatePaymentsPayment:amount period:period intrest:intrest frequency:frequency];
	double pv = amount;
	//double type = 0;
	int paymentNumber = 0;
	// FV = ((-1) * PMT / ip) - [(1 + ip) ^ NPER * ( PV + ((-1) * (PMT / ip)] 
	//double FV = ((-1) * PMT / ip) - (pow((1 + ip),NPER) * ( pv + ((-1) * (PMT / ip)))); 
	//(PMT*(1+rate*type)*(1-(1+ rate)^NPER)/rate)-PV*(1+rate)^NPER 
	//double FV = -((PMT*(1+ip*type)*(1-pow((1+ ip),NPER))/ip)-pow(pv*(1+ip),NPER));
	double FV = -(( PMT/ ip) -(pow((1 + ip),(NPER)) *(pv+( PMT /(ip)))));
	Payment* payment = [Payment new];
	payment.paymentNumber = paymentNumber;
	payment.balance = amount;
	payment.principle = 0;
	payment.interest = 0;
	[result addObject:payment];
	paymentNumber++;
	while (FV > 0 && true) {
		//NPER = paymentNumber;
		Payment* payment = [Payment new];
		FV = -(( PMT/ ip) -(pow((1 + ip),(NPER)) *(pv+( PMT /(ip)))));
		//NSLog(@"%f",FV);
		payment.paymentNumber = paymentNumber;
		payment.balance = FV;
		payment.principle = pv - FV;
		payment.interest = (-PMT) - (pv - FV);
		[result addObject:payment];
		// Increment to new payment
		//PMT = -[CalculatorBusiness calculatePaymentsPayment:pv period:period intrest:intrest frequency:frequency];
		pv = FV;
		paymentNumber++;
	}
	return result;
}

+(float)calculateMortgageAmountWithPayment:(float)payment period:(float)period intrest:(float)intrest frequency:(PLPaymentFrequency)frequency {
	//((1+D7/2)^(1/6)-1)*(D5+(D5/((1+((1+D7/2)^(1/6)-1))^(D6*12)-1)))
	float timePeriod = period;
	//float denom = 1.0f;
	float interestFactor = 6.0;
	switch (frequency) {
		case PLPaymentFrequencyMonthly: {
			interestFactor = 6.0;
		}
			break;
		case PLPaymentFrequencySemiMonthly: {
			timePeriod = timePeriod * 2.0f;
			interestFactor = 12.0;
		}
			break;
		case PLPaymentFrequencyBiWeekly: {
			timePeriod = (timePeriod / 12.0f) * 26.0f;
			interestFactor = 13.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedBiWeekly: {
			timePeriod = (timePeriod / 12.0f) * 26.0f;
			interestFactor = 13.0;
		}
			break;
		case PLPaymentFrequencyWeekly: {
			timePeriod = (timePeriod / 12.0f) * 52.0f;
			interestFactor = 26.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedWeekly: {
			timePeriod = (timePeriod / 12.0f) * 52.0f;
			interestFactor = 26.0;
		}
			break;
		default:
			break;
	}
	
	float ip = pow((1.0f+(intrest/100.0f)/2.0f),(1.0f/interestFactor)) - 1.0f; 
	float pmt =  (-1.0f)*((payment/ip)*(1.0f/pow((1.0f + ip),(timePeriod)))-(payment/ip));
	return pmt;
}

+(float)calculateAmortization:(float)amount payment:(float)payment intrest:(float)intrest frequency:(PLPaymentFrequency)frequency {
	//((1+D7/2)^(1/6)-1)*(D5+(D5/((1+((1+D7/2)^(1/6)-1))^(D6*12)-1)))
	float interestFactor = 6.0;
	switch (frequency) {
		case PLPaymentFrequencyMonthly: {
			interestFactor = 6.0;
		}
			break;
		case PLPaymentFrequencySemiMonthly: {
			interestFactor = 12.0;
		}
			break;
		case PLPaymentFrequencyBiWeekly: {
			interestFactor = 13.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedBiWeekly: {
			interestFactor = 13.0;
		}
			break;
		case PLPaymentFrequencyWeekly: {
			interestFactor = 26.0;
		}
			break;
		case PLPaymentFrequencyAcceleratedWeekly: {
			interestFactor = 26.0;
		}
			break;
		default:
			break;
	}
	
	float ip = pow((1.0f+(intrest/100.0f)/2.0f),(1.0f/interestFactor)) - 1.0f; 
	float amort = (log10(-payment/(-payment+(amount*ip)))/(log10(1+ip)))/(interestFactor*2); //KYLE
	return amort;	
}

+(HomePurchasePayment)calculateHomePurchasePaymentWithPrice:(float)purchasePrice 
											downPaymentRate:(float)downPaymentRate
												downPayment:(float)downPayment
													balance:(float)balance 
													   term:(int)term				// no. of months
											   interestRate:(float)interestRate
											   amortization:(float)amortization
										  annualPropertyTax:(float)annualPropTax
												  condoFees:(float)condoFees
												  frequency:(PLPaymentFrequency)frequency
{
	// high ratio premium schedule for 3 amortization values (25yrs, 30 yrs, 35 yrs)
    float highRatioPremiumScheduleArray[][3] = {	{3.60,3.851,3.85}, // 5% down payment
                                                    {2.40,2.40,2.40}, // 10% down payment
                                                    {1.80,1.85,1.85}, // 15% down payment
                                                    {0.00,0.00,0.00}, // 20% down payment
	};
	
	// time 
	float timeUnit = 0;
	switch (frequency) {
		case PLPaymentFrequencyMonthly: {
			timeUnit = 12.0f;
		}
			break;
		case PLPaymentFrequencySemiMonthly: {
			timeUnit = 24.0f;
		}
			break;
		case PLPaymentFrequencyBiWeekly: {
			timeUnit = 26.0f;
		}
			break;
		case PLPaymentFrequencyAcceleratedBiWeekly: {
			timeUnit = 12.0f;
		}
			break;
		case PLPaymentFrequencyWeekly: {
			timeUnit = 52.0f;
		}
			break;
		case PLPaymentFrequencyAcceleratedWeekly: {
			timeUnit = 12.0f;
		}
			break;
		default:
			break;
	}
	
	// ip = ((1+B9/2)^(1/6)-1)
	float ip = pow(1.0f+interestRate/2.0f, 1.0f/(timeUnit/2.0f))-1.0f;

	int downPaymentIndex = ((int)((downPaymentRate * 100) / 5.0) - 1);
	if (downPaymentIndex < 0)
		downPaymentIndex = 0;
	else if (downPaymentIndex > 3)
		downPaymentIndex = 3;
	
	int amortizationIndex = 0;
	if (amortization <= 25)
		amortizationIndex = 0;
	else if (amortization <= 30)
		amortizationIndex = 1;
	else if (amortization <= 40)
		amortizationIndex = 2;
	
	float highRatioInsurrancePremiumRate = highRatioPremiumScheduleArray[downPaymentIndex][amortizationIndex];
	float highRatioInsurrancePremium = balance * highRatioInsurrancePremiumRate * 0.01;
	float totalMortgage = balance + highRatioInsurrancePremium;
	
	//monthly/semi/weekly/bi-weekly payemnet
	//=((1+B9/2)^(1/timeUnit/2)-1)*(B15+(B15/((1+((1+B9/2)^(1/timeUnit/2)-1))^(B11*timeUnit)-1)))
	float timeUnitPayment = (ip*(totalMortgage+(totalMortgage/(pow(1+ip,amortization*timeUnit)-1))));
	
	// Mortgage Balance (end of term)
	// =-((-B17/((1+B9/2)^(1/6)-1))-((1+((1+B9/2)^(1/6)-1))^((B8*12)+D8)*(B15+(-B17/(((1+B9/2)^(1/6)-1))))))
	int termYrs = term / 12; int termMonths = term % 12;
	float mortgageBalance =-((-timeUnitPayment/ip)-(pow(1+ip,(termYrs*timeUnit)+termMonths*(12/timeUnit))*(totalMortgage+(-timeUnitPayment/ip))));

	if (frequency == PLPaymentFrequencyAcceleratedBiWeekly) {
		timeUnitPayment /= 2.0f;
		timeUnit = 26.0f;
		float acc_ip = pow(1.0f+interestRate/2.0f, 1.0f/(timeUnit/2.0f))-1.0f;
		mortgageBalance =-((-timeUnitPayment/acc_ip)-(pow(1+acc_ip,(termYrs*timeUnit)+termMonths*(12/timeUnit))*(totalMortgage+(-timeUnitPayment/acc_ip))));
	}
	else if (frequency == PLPaymentFrequencyAcceleratedWeekly) {
		timeUnitPayment /= 4.0f;
		timeUnit = 52.0f;
		float acc_ip = pow(1.0f+interestRate/2.0f, 1.0f/(timeUnit/2.0f))-1.0f;
		mortgageBalance =-((-timeUnitPayment/acc_ip)-(pow(1+acc_ip,(termYrs*timeUnit)+termMonths*(12/timeUnit))*(totalMortgage+(-timeUnitPayment/acc_ip))));
	}
	
	float requiredIncome = ( ( (timeUnitPayment * timeUnit / 12.0f) + (100) + (0.50 * condoFees) + (annualPropTax / 12.0f) ) / (0.32) ) * 12;
	int requiredIncomeInt = round(requiredIncome);
	int rem = requiredIncomeInt%100;
	requiredIncomeInt += (100-rem);

	HomePurchasePayment payment;
	payment.highRatioInsurrancePremmium = highRatioInsurrancePremium;
	payment.totalMortgageRequired = totalMortgage;
	payment.monthlyPayment = timeUnitPayment;
	payment.mortgageBalance = mortgageBalance;
	payment.requiredAnnualIncomeToQualify = requiredIncomeInt;
	return payment;
}

+ (float) calculateAffordablePlanIncome:(float)income 
						   Objligations:(float)objligations 
						   PropetyTaxes:(float)propertyTaxes 
							HeatingCost:(float)heatingCost 
							  CondoFees:(float)condoFees 
						   InterestRate:(float)interestRate
						   Amortization:(int)amortization
{
	float tds = income / 12 * 0.4; // (40% of annual income, converted to a monthly payment)
	
	// mortgagePaymentA = E5-B6-(B10/12)-B11-(B12/2)
	float mortgagePaymentA = tds - objligations - (propertyTaxes/12)-heatingCost-(condoFees/2);

	float gds = income / 12 * 0.32; // (32% of annual income, converted to a monthly payment)
	
	// mortgagePaymentB = E10-(B10/12)-B11-(B12/2)
	float mortgagePaymentB = gds - (propertyTaxes/12)-heatingCost-(condoFees/2);
	
	float minMortgagePayment = (mortgagePaymentA < mortgagePaymentB) ? mortgagePaymentA : mortgagePaymentB;
	
	interestRate *= 0.01;
	// ip = ((1+B15/2)^(1/6)-1)
	float ip = (pow(1+interestRate/2,1/6.0f)-1);
	// result = ((-E15/((1+B15/2)^(1/6)-1))-0)*(1/((1+((1+B15/2)^(1/6)-1))^(360)))-(-E15/((1+B15/2)^(1/6)-1))
	float result = (-minMortgagePayment/ip-0)*(1/pow(1+ip,amortization*12))-(-minMortgagePayment/ip);
	
	return result;
}

+(float)calculateBalanceAmount:(float)amount paymentAmount:(float)paymentAmount intrest:(float)intrest termPeriod:(float)termPeriod frequency:(PLPaymentFrequency)frequency
{
	// =-((-D12/((1+D7/2)^(1/6)-1))-((1+((1+D7/2)^(1/6)-1))^((A9*12)+C9)*(D5+(-D12/(((1+D7/2)^(1/6)-1))))))
	
	// time 
	float timeUnit = 0;
	switch (frequency) {
		case PLPaymentFrequencyMonthly: {
			timeUnit = 12.0f;
		}
			break;
		case PLPaymentFrequencySemiMonthly: {
			timeUnit = 24.0f;
		}
			break;
		case PLPaymentFrequencyBiWeekly: {
			timeUnit = 26.0f;
		}
			break;
		case PLPaymentFrequencyAcceleratedBiWeekly: {
			timeUnit = 26.0f;
		}
			break;
		case PLPaymentFrequencyWeekly: {
			timeUnit = 52.0f;
		}
			break;
		case PLPaymentFrequencyAcceleratedWeekly: {
			timeUnit = 52.0f;
		}
			break;
		default:
			break;
	}
	
	// =((1+D7/2)^(1/6)-1)
	float ip = (pow(1+intrest*0.01f/2.0f,1/(timeUnit/2.0f))-1);
	
	int months = ((int)termPeriod)%12;
	int years = ((int)termPeriod)/12;
	
	// =-((-D12/ip)-((1+ip)^((A9*12)+C9)*(D5+(-D12/(ip)))))
	float balance = -((-paymentAmount/ip)-(pow(1+ip,(years*timeUnit)+(months*timeUnit/12.0f))*(amount+(-paymentAmount/(ip)))));
	
	return balance;
}

@end
