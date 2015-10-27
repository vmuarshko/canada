//
//  CommonHeader.m
//  Sky Financial Corp
//
//  Created by Ved Prakash on 13/07/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "CommonHeader.h"


@implementation CommonHeader
@synthesize emailButton;
@synthesize btnHome;
@synthesize lblSubTitle;
@synthesize curIcon;
@synthesize lblHeader,headerText,parentController,lblBack,viewButton,btnBack,showButton,fromRates,showEmail;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initViewComponents{
    viewButton.hidden=!showButton;
    emailButton.hidden=!showEmail;
    
    UIImage *icon=nil;
    if([headerText isEqualToString:@"Rates"]){
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"rates.png")];
    }else if([headerText isEqualToString:@"Calculators"]){
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"calculator.png")];
        headerText=@"Mortgage Calculators";
    }else if([headerText isEqualToString:@"Apply"]){
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"apply.png")];
        headerText=@"Schedule a call back - Quick App";
    }else if([headerText isEqualToString:@"News"]){
        headerText=@"Mortgage News";
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"news.png")];
    }else if([headerText isEqualToString:@"Contact"]){
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact.png")];
    }else if([headerText isEqualToString:@"Facebook"]){
        //icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact_facebook.png")];
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact.png")];
    }else if([headerText isEqualToString:@"Linkedin"]){
        //icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact_in.png")];
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact.png")];
    }else if([headerText isEqualToString:@"Twitter"]){
        //icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact_tweeter.png")];
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact.png")];
    }else if([headerText isEqualToString:@"Rss"]){
        //icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact_rss.png")];
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"contact.png")];
    }else if([headerText isEqualToString:@"Partners"]){
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"preferred_partners_icon.png")];
    }else if([headerText isEqualToString:@"Glossary"]){
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"mortgage_glossary_icon.png")];
        headerText=@"Mortgage Glossary";
    }else if([headerText isEqualToString:@"Schedule"]){
        icon=[UIImage imageWithContentsOfFile:JBUNDLE(@"calculator.png")];
        headerText=@"Payment Schedules";
    }
    
    lblSubTitle.text=headerText;

    if(icon)
        [curIcon setImage:icon forState:UIControlStateNormal];
    else{
    
        CGRect frame=lblSubTitle.frame;
        frame.origin.x=curIcon.frame.origin.x;
        lblSubTitle.frame=frame;
    
    }

    
}

-(void)setHeaderLabelText:(NSString *)titleText{

    lblSubTitle.text=titleText;

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [lblBack release];
    [viewButton release];
    [lblHeader release];
    [parentController release];
    [btnBack release];
    [btnHome release];
    [lblSubTitle release];
    [curIcon release];
    [emailButton release];
    [super dealloc];
}



@end
