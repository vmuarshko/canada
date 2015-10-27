//
//  ScheduleControler.m
//  Jencor
//
//  Created by Teknowledge Software on 03/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "ScheduleControler.h"
#import "PaymentCell.h"
#import "CalculatorBusiness.h"
#define PLTableCellHeight 20

@implementation ScheduleControler
@synthesize tbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark CUSTOM GETTER/SETTERS
//=========================================================================
- (void) setPaymentsSchedule: (NSMutableArray *) newValue {
	_paymentsSchedule = newValue;
	[tbl reloadData];
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
    
    
	MFMailComposeViewController *pickerMail = [[MFMailComposeViewController alloc] init];
	pickerMail.mailComposeDelegate = self;
    [pickerMail setSubject:@"Your Jencor App Calculations."];
    
	// Attach an image to the email
    
	// Fill out the email body text
	NSString *emailBody = @"Attachment: Payment Schedule";
    
    NSString *attachment=[self getScheduleSummary];
    if (attachment != nil)
    {
        NSData *myData = [attachment dataUsingEncoding:NSUTF8StringEncoding];
        [pickerMail addAttachmentData:myData mimeType:@"text/html" fileName:@"schedule.htm"];
    }   
    emailBody = [NSString stringWithFormat:@"%@\n\n%@",emailBody,@"Information and interactive calculators are made available to you as self-help tools for your independent use and are not intended to provide mortgage advice. We cannot and do not guarantee their applicability or accuracy in regards to your individual circumstances. All examples are hypothetical and are for illustrative purposes. We encourage you to seek personalized advice from one of our qualified mortgage professionals regarding all personal mortgage needs."];

    [pickerMail setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:pickerMail animated:YES];
    
    appDelegate.viewButtons.hidden=TRUE;
    [pickerMail release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	//message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Result: saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Result: sent");
            break;
		case MFMailComposeResultFailed:
			NSLog( @"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
    
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
    //NSString *error1 = NSLocalizedString(@"No Mail Account!", nil);
    
    NSString *error2 = NSLocalizedString(@"Please check the login status in the Mail app and try again.", nil);
    
    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"No Mail Account!" message:error2
                              
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [AlertView show];
    
    [AlertView release];
    
}

- (NSString*) getScheduleSummary {
	NSString * summary=@"";
	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"#,###,###,###,##0.00"];
	summary = [summary stringByAppendingFormat:@"<html><head>Payment Schedule</head><body><table border='0'><tr><td>Payment No.</td><td>Balance</td><td>Principle</td><td>Interest</td></tr>"];
	for (int i = 0; i < [_paymentsSchedule count]; i++) {
		Payment* obj = [_paymentsSchedule objectAtIndex:i];
		summary = [summary stringByAppendingFormat:@"<tr><td>%d</td><td>$%@</td><td>$%@</td><td>$%@</td></tr>",
				   obj.paymentNumber,
				   [numberFormatter stringFromNumber:[NSNumber numberWithFloat:obj.balance]],
				   [numberFormatter stringFromNumber:[NSNumber numberWithFloat:obj.principle]],
				   [numberFormatter stringFromNumber:[NSNumber numberWithFloat:obj.interest]]
				   ];
	}
	summary = [summary stringByAppendingFormat:@"</head></html>"];
	return summary;
}

- (IBAction)emailAction:(id)sender {
    
    NSLog(@"Email");
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    appDelegate.viewButtons.hidden=FALSE;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    header=(CommonHeader *)[self addCommonHeaderForView:@"Schedule" modal:NO showBackButton:YES showEmailButton:YES];
    [header.emailButton addTarget:self action:@selector(emailAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //_paymentsSchedule = [NSMutableArray new];
	tbl.separatorColor = JCOLOR(11,42,85);
    
    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
}

//==============================================================================
#pragma mark -
#pragma mark Payments table 
//==============================================================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_paymentsSchedule count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PLTableCellHeight;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PaymentCell";
    PaymentCell *cell =	(PaymentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController *controller=[[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
        cell = (PaymentCell *)controller.view;
		//cell.backgroundView = [[[GradientView alloc] init] autorelease];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		
    }
	if (indexPath.row % 2 == 0) {
		cell.contentView.backgroundColor = [UIColor whiteColor];
	} else {
		cell.contentView.backgroundColor = JCOLOR(225,225,225);
	}
	Payment* obj = [_paymentsSchedule objectAtIndex:indexPath.row];

    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"###,###,###,##0.00"];
    
    cell.lblIndex.text=[NSString stringWithFormat:@"%d",obj.paymentNumber];
    NSNumber *amt = [NSNumber numberWithFloat:obj.balance];
    cell.lblBalance.text=[NSString stringWithFormat:@"$%@", [numberFormatter stringFromNumber:amt]];
    
    amt = [NSNumber numberWithFloat:obj.principle];
    cell.lblPrinciple.text=[NSString stringWithFormat:@"$%@", [numberFormatter stringFromNumber:amt]];
    
    amt = [NSNumber numberWithFloat:obj.interest];
    cell.lblInterest.text=[NSString stringWithFormat:@"$%@", [numberFormatter stringFromNumber:amt]];

    return cell;
}

- (void)viewDidUnload
{
    [self setTbl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [tbl release];
    [super dealloc];
}
@end
