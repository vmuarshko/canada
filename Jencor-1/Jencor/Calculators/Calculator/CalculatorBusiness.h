//
//  CalculatorBusiness.h
//  iPhoneApp
//
//  Created by Haseeb Yousaf on 10/20/10.
//  Copyright 2010 Penta::Loop Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment : NSObject
{
	NSInteger paymentNumber;
	float balance;
	float principle;
	float interest;
	
}

@property (assign) NSInteger paymentNumber;
@property (assign) float balance;
@property (assign) float principle;
@property (assign) float interest;

@end

typedef struct _HomePurchasePayment
{
	float highRatioInsurrancePremmium;
	float totalMortgageRequired;
	float monthlyPayment;
	float mortgageBalance;
	int requiredAnnualIncomeToQualify;
    //float balance;
   // float downpayment;
} HomePurchasePayment;

typedef enum _PLPaymentFrequency {
	PLPaymentFrequencyMonthly,
	PLPaymentFrequencySemiMonthly,
	PLPaymentFrequencyBiWeekly,
	PLPaymentFrequencyAcceleratedBiWeekly,
	PLPaymentFrequencyWeekly,
	PLPaymentFrequencyAcceleratedWeekly
} PLPaymentFrequency;

@interface CalculatorBusiness : NSObject {

}
+(float)calculatePaymentsPayment:(float)amount period:(float)period intrest:(float)intrest frequency:(PLPaymentFrequency)frequency;
+(NSArray*)calculatePaymentsTablePayment:(float)amount period:(float)period intrest:(float)intrest frequency:(PLPaymentFrequency)frequency;

+(float)calculateMortgageAmountWithPayment:(float)payment period:(float)period intrest:(float)intrest frequency:(PLPaymentFrequency)frequency;

+(float)calculateAmortization:(float)amount payment:(float)payment intrest:(float)intrest frequency:(PLPaymentFrequency)frequency;

+(HomePurchasePayment)calculateHomePurchasePaymentWithPrice:(float)purchasePrice 
											downPaymentRate:(float)downPaymentRate
												downPayment:(float)downPayment
													balance:(float)balance 
													   term:(int)term				// no. of months
											   interestRate:(float)interestRate
											   amortization:(float)amortization
										  annualPropertyTax:(float)annualPropTax
												  condoFees:(float)condoFees
												  frequency:(PLPaymentFrequency)frequency;


+ (float) calculateAffordablePlanIncome:(float)income 
						   Objligations:(float)objligations 
						   PropetyTaxes:(float)propertyTaxes 
							HeatingCost:(float)heatingCost 
							  CondoFees:(float)condoFees 
						   InterestRate:(float)interestRate
						   Amortization:(int)amortization;
+(float)calculateBalanceAmount:(float)amount paymentAmount:(float)paymentAmount intrest:(float)intrest termPeriod:(float)termPeriod frequency:(PLPaymentFrequency)frequency;

+(NSString *)getScreenSummaryWithData:(NSMutableArray *)data forType:(int)type;
+(NSString *)decideValueFormatForValue:(NSString *)fieldValue andField:(NSString *)field;
@end
