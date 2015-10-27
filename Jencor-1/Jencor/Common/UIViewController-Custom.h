

#import <Foundation/Foundation.h>


@interface UIViewController(AllCommon)


-(void)fillGradientToView:(UIView *)view roundCorner:(BOOL)round withCornerRadius:(CGFloat)radius;

- (void) hideGradientBackground:(UIView*)theView;
-(NSString *)getHTMLfromFile:(NSString *)html;
- (BOOL) validateEmail: (NSString *) emailID;

-(UIView *)addCommonHeaderForView:(NSString *)viewName modal:(BOOL)isModal showBackButton:(BOOL)showBackButton;
-(void)makeRoundedView:(UIView *)view;
-(void)adjustLabelSizeForLabel:(UILabel *)label andText:(NSString *)text;
-(CGFloat)adjustCellHeightForText:(NSString *)text;
-(void)makeRoundedViewWithoutBorder:(UIView *)view;

-(NSString *)mortgageQualifierCalculatorForAnualFamilyIncome:(NSString *)incomes  AnnualPropertyTaxes:(NSString *)taxes MonthlyHeatingCosts:(NSString *)healingCost  MinimumMonthlyPayments:(NSString *)monthlyPayments MonthlySecondaryFinancingPayment:(NSString *)secondaryPayment InterestRate:(NSString *)rate;


-(NSMutableArray *)rentBuyCalculatorForMonthlyPayment:(NSString *)monthlyPayments downPayment:(NSString *)downPayment annualPropertyTaxes:(NSString *)annualPropertyTaxes interestRate:(NSString *)rate annualIncrease:(NSString *)annualIncrease  monthlyRent:(NSString *)monthlyRent yearsOfComparison:(NSString *)years;

-(NSString *)prepareHTML:(NSMutableArray*)array;

-(NSString *)validateRentBuyCalculatorForFieldname:(NSString *)fieldName andFieldValue:(NSString *)fieldValue;

-(NSString *)validatemortgageQualifierCalculatorForFieldName:(NSString *)fieldName andFieldValue:(NSString *)fieldValue;

-(NSString *)validateMortgagePaymentCalculatorForFieldname:(NSString *)fieldName andFieldValue:(NSString *)fieldValue;

-(NSMutableArray *)mortgagePaymentCalculatorForPurchasePrice:(NSString *)purchasePrice DownPayment:(NSString *)downPayment Rate:(NSString *)rate Term:(NSString *)term Amortization:(NSString *)amortization;

-(NSString *)getMortgageAmountFromPurchasePrice:(NSString *)purchase andDownPayment:(NSString *)downPayment;

-(CGFloat)adjustCellHeightForBiggerText:(NSString *)text;
-(void)adjustLabelSizeForBiggerLabel:(UILabel *)label andText:(NSString *)text;
-(UIView *)addCommonHeaderForView:(NSString *)viewName modal:(BOOL)isModal showBackButton:(BOOL)showBackButton showEmailButton:(BOOL)showEmailButton;

@end
