//
//  ScheduleControler.h
//  Jencor
//
//  Created by Teknowledge Software on 03/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShadowedTableView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "CommonHeader.h"

@interface ScheduleControler : UIViewController<MFMailComposeViewControllerDelegate>{

    JencorAppDelegate *appDelegate;
    
    CommonHeader *header;

}
@property (retain, nonatomic) IBOutlet ShadowedTableView *tbl;
@property (retain, nonatomic) NSMutableArray* paymentsSchedule;
- (void) setPaymentsSchedule: (NSMutableArray *) newValue;
- (NSString*) getScheduleSummary;
-(void)launchMailAppOnDevice;
-(void)displayComposerSheet ;

@end
