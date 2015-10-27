//
//  CalcForm.h
//  Jencor
//
//  Created by Ved Prakash on 11/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rate.h"

@interface CalcForm : NSObject {
    NSString *fieldValue;
    NSString *fieldName;
    BOOL mandatory;
    NSString *fieldType;
    NSString *fieldLabel;
    NSString *valuePrefixSuffix;
    
    BOOL isSuffix;
    
    Rate *availableRate;
    
    BOOL isCreatingCompareForm;
}

@property(nonatomic,retain) NSString *fieldValue;
@property(nonatomic,retain) NSString *fieldName;
@property(nonatomic) BOOL mandatory;
@property(nonatomic) BOOL isSuffix;
@property(nonatomic,retain) NSString *fieldType;
@property(nonatomic,retain) NSString *fieldLabel;
@property(nonatomic,retain) NSString *valuePrefixSuffix;

-(id)getMortgageCalcWithRate:(Rate *)rate type:(NSString *)type;
-(id)getHomePurchaseCalcWithRate:(Rate *)rate;
-(id)getCompareCalcPaymentWithRate:(Rate *)rate type:(NSString *)type;

-(id)getAffordCalcWithRate:(Rate *)rate;

-(NSMutableArray *)prepareArrayWithLabels:(NSString *)strLabel;


@end
