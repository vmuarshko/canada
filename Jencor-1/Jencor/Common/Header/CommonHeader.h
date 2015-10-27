//
//  CommonHeader.h
//  Sky Financial Corp
//
//  Created by Ved Prakash on 13/07/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommonHeader : UIView {
    BOOL fromBuyTickets;
    
    UILabel *lblHeader;
    
    NSString *headerText;
    UIViewController *parentController;
    UIView *viewButton;
    UILabel *lblBack;
    UIButton *btnBack;
    BOOL showButton;
    BOOL showEmail;
    BOOL fromRates;
    
   
    UIButton *btnHome;
    UILabel *lblSubTitle;
}
@property(nonatomic,retain)UIViewController *parentController;
@property(nonatomic,retain)NSString *headerText;
@property (nonatomic, retain) IBOutlet UILabel *lblHeader;
@property (nonatomic, retain) IBOutlet UIView *viewButton;
@property (nonatomic, retain) IBOutlet UILabel *lblBack;
@property (nonatomic, retain) IBOutlet UIButton *btnBack;
@property (nonatomic)BOOL showButton;
@property (nonatomic)BOOL showEmail;
@property (retain, nonatomic) IBOutlet UIButton *emailButton;
@property (nonatomic)BOOL fromRates;
-(void)initViewComponents;

@property (nonatomic, retain) IBOutlet UIButton *btnHome;
@property (nonatomic, retain) IBOutlet UILabel *lblSubTitle;
@property (retain, nonatomic) IBOutlet UIButton *curIcon;

-(void)setHeaderLabelText:(NSString *)titleText;
@end
