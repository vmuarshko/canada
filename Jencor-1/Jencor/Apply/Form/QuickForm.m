//
//  QuickForm.m
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "QuickForm.h"


@implementation QuickForm
@synthesize fieldName,fieldType,mandatory,fieldLabel,fieldValue;

- (void)dealloc {
    [fieldLabel release];
    [fieldName release];
    [fieldValue release];
    [fieldType release];
    [super dealloc];
}

-(id)getForm{

    
    
    NSString *strLabel=@"Name,Text,1,name#Phone,Phone,1,phone#Email,Email,1,email#Purpose of loan,List,1,purpose#Amount requested,Text,1,amount";
    
    
    NSArray *arr=[strLabel componentsSeparatedByString:@"#"];
    
    NSMutableArray *mainArr=[[NSMutableArray alloc]init];
    
    for(NSString *s in arr){
        NSArray *vals=[s componentsSeparatedByString:@","];
        QuickForm *obj=[[QuickForm alloc] init];
        [obj setFieldLabel:[NSString stringWithFormat:@"%@",NSLocalizedString([vals objectAtIndex:0], nil)]];
        
        NSString *format=[vals objectAtIndex:1];
        NSString *field=[vals objectAtIndex:3];
        int mandate=[[vals objectAtIndex:2] intValue];
        
        [obj setMandatory:mandate];
        [obj setFieldType:format];
        [obj setFieldName:field];
        
        [mainArr addObject:obj];    
        
    }
    
    return mainArr;
    
    /*
     
     Purpose of loan, Dropdown, values  Purchase, Refinance, Renewal, HELOC,
     Amount requested, Dollar value (numeric)
     Name, text
     Email, email validated
     Phone, numeric
     
     */

}
@end
