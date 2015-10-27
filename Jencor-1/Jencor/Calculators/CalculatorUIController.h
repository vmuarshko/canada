//
//  CalculatorUIController.h
//  Jencor
//
//  Created by Teknowledge Software on 24/02/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeader.h"
#import "PickerViewController.h"
#import "CalcForm.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface CalculatorUIController : UIViewController<UITextFieldDelegate,MFMailComposeViewControllerDelegate>{

    int type;
    NSMutableArray *tblData;
    
    
    //For Mortgage Planning Calculators
    NSMutableArray *arrMortPaymentCalc;
    NSMutableArray *arrMortMortCalc;
    NSMutableArray *arrMortAmortCalc;
    NSMutableArray *arrCompPaymentCals;
    NSMutableArray *arrCompMortCals;
    NSMutableArray *arrCompAmortCals;

    PickerViewController *picker;
    
    int selectedInput;
    
    //For Home Purchase Calculator
    CalcForm *tempDollar;
    CalcForm *tempPercentage;
    int selectedIndex;
    double mDownPaymentAmount;
    
    NSMutableArray *paymentsSchedule;
    JencorAppDelegate *appdelegate;
}

@property (retain, nonatomic) IBOutlet UIView *container;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic) int type;
@property (retain, nonatomic) IBOutlet UITableView *tbl;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UISegmentedControl *mortCalcs;
@property (retain, nonatomic)JencorAppDelegate *appdelegate;
- (IBAction)mortSelection:(id)sender;
-(void)setValueForIndexPath:(NSIndexPath *)indexPath andValue:(NSString *)value;
-(void)setupViewWithRate:(Rate *)rate;
-(void)getAllValues;
-(void)hideModal;
-(void)openListForIndexPath:(NSIndexPath *)indexPath;
-(NSIndexPath *)getIndexPathForTag:(int)tTag;
-(CalcForm *)getCurrentObjectForIndexPath:(NSIndexPath *)indexPath;
-(NSString *)removeExtraCharactersFromValue:(NSString *)value;
-(void)calculateValues;
-(int)getFrequecy:(NSString *)frequency;
-(NSString *)decideValueFormatForValue:(NSString *)fieldValue andField:(NSString *)field;

-(void)mortgageCalculator;
-(void)homePurchaseCalculator;
-(void)affordCalculator;
-(void)comparisonCalculator;
-(NSString *)getResultTextForAmort1:(float)amortization;

-(void)shareViaMail;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

- (NSString*) getScheduleSummary ;
- (IBAction)emailAction:(id)sender;



@end
