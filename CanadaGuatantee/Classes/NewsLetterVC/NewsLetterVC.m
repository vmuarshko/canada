//
//  NewsLetterVC.m
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsLetterVC.h"
#import "TableCell.h"
#import "PickerView.h"

#import "WebService.h"

@implementation NewsLetterVC
{
    BOOL agreed;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *strURL = @"";
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
        strURL = @"http://www.canadaguaranty.ca/newsletter-signup-responsive";
    }else {
        strURL = @"http://www.canadaguaranty.ca/fr/newsletter-signup-responsive";
    }

    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    webView.delegate = self;
    webView.scalesPageToFit = TRUE;
	
    
    //[self setValues];
	
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//	[self.navigationController popViewControllerAnimated:YES];
//}

-(void)setValues {
	
//    agreed = NO;
//	lblTitle.text = [self getString:@"Newsletter Sign-up"];
//	
//	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
//		
//		[btnSignup setImage:[UIImage imageNamed:@"sign_up1.png"] forState:UIControlStateNormal];
//		[btnSignup setImage:[UIImage imageNamed:@"sign_up1.png"] forState:UIControlStateHighlighted];
//		[btnSignup setImage:[UIImage imageNamed:@"sign_up1.png"] forState:UIControlStateSelected];
//		
//	}else {
//		
//		[btnSignup setImage:[UIImage imageNamed:@"sign_up2.png"] forState:UIControlStateNormal];
//		[btnSignup setImage:[UIImage imageNamed:@"sign_up2.png"] forState:UIControlStateHighlighted];
//		[btnSignup setImage:[UIImage imageNamed:@"sign_up2.png"] forState:UIControlStateSelected];
//	}
//	
//	
//	arrLetter = [[[NSMutableArray alloc] init] retain];
//	[arrLetter addObject:[self getString:@"First Name:"]];
//	[arrLetter addObject:[self getString:@"Last Name:"]];
//	[arrLetter addObject:[self getString:@"Email:"]];
//	[arrLetter addObject:[self getString:@"Province/Territory:"]];
//	[arrLetter addObject:[self getString:@"Company:"]];
//	[arrLetter addObject:[self getString:@"Preferred Language (English/French):"]];
//	[arrLetter retain];
//	
//	arrLetterValue = [[[NSMutableArray alloc] init] retain];
//	for(NSString *str in arrLetter){
//		[arrLetterValue addObject:@""];
//	}
//	[arrLetterValue retain];
//	
//	//[arrLetterValue replaceObjectAtIndex:3 withObject:@"Alberta"];
//	
//	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
//		[arrLetterValue replaceObjectAtIndex:5 withObject:@"English"];
//	else{
//		[arrLetterValue replaceObjectAtIndex:5 withObject:@"Français"];
//		[[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"nlpl"];
//	}
	
}

-(IBAction)signupAction{

//	if(txt)
//		[txt resignFirstResponder];	
//
//	
//    if(!agreed)
//    {
//        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
//        {
//            [self showAlert:@"Attention!" :@"To proceed, please accept the subscription terms."];
//
//        }
//        else
//        {
//            [self showAlert:@"Attention!" :@"Pour continuer, vous devez accepter les conditions d'abonnement."];
//
//        }
//        return;
//    }
//    
//	if([[arrLetterValue objectAtIndex:0] length] == 0)
//		[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter first name."]];
//
//	else if([[arrLetterValue objectAtIndex:1] length] == 0)
//		[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter last name."]];
//	
//	else if([[arrLetterValue objectAtIndex:2] length] == 0)
//		[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter email address."]];
//	
//	else if(![self validateEmail:[arrLetterValue objectAtIndex:2]])
//		[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter valid email address."]];
//
//	else if([[arrLetterValue objectAtIndex:3] length] == 0 || [[arrLetterValue objectAtIndex:3] isEqualToString:@"Please select"])
//		[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter province/territory."]];
//	
//	else if([[arrLetterValue objectAtIndex:4] length] == 0)
//		[self showAlert:[self getString:@"Attention!"] :[self getString:@"Please enter company."]];
//	
//	else{
//		[self showHUD:[self getString:@"Signing up"]];
//		[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(callWebService) userInfo:nil repeats:NO];
////		[self sendMail];
////		[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(makeRequest) userInfo:nil repeats:NO];
//	}
}

//-(void)callWebService{
//	
//	WebService *obj = [[WebService alloc] init];
//	NSDictionary *dic = [obj sendSignupRequest:arrLetterValue];
//	
//	[self killHUD];
//	
//	BOOL isError = FALSE;
//	
//	if(dic && [dic count] > 0){
//		if([[dic objectForKey:@"eventDescription"] isEqualToString:@"Success"] || [[dic objectForKey:@"eventId"] isEqualToString:@"10001"]){
//			
//			[self showAlert:[self getString:@"Thank you for subscribing to the Canada Guaranty newsletter."] :@""];
//			
//		}else
//			isError = TRUE;
//		
//	}else 
//		isError = TRUE;
//	
//	if(isError){
//	
//		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:[self getString:@"Error!"] 
//											message:[self getString:@"An unexpected error has occurred."] 
//											delegate:self cancelButtonTitle:[self getString:@"Cancel"] 
//												   otherButtonTitles:[self getString:@"Retry"], nil];
//		
//		[errorAlert setTag:10002];
//		[errorAlert show];
//	}
//	
//}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//	
//	if (alertView.tag == 10002 && buttonIndex == 1) {
//		
//		[self signupAction];
//		
//	}
}

-(BOOL)validateEmail:(NSString*)email{
//	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+[.]+[A-Za-z]{2,4}"; 
//	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
//	return [emailTest evaluateWithObject:email];
}

#pragma mark -
#pragma mark - Table view methods
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row == 3 || indexPath.row == 5)
		return 50;
	else{
        if (indexPath.row == 6)
        {
            return 150;
        }
    }
		
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrLetter count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	int rowId = indexPath.row;
	
	if (rowId == 3) {

		//news letter Provinces = province
		NSInteger ii = [[NSUserDefaults standardUserDefaults] integerForKey:@"province"];
		NSArray *arr  = [NSArray arrayWithObjects:
                         @"Please select",
						 @"Alberta",
						 @"British Columbia",
						 @"Manitoba",
						 @"New Brunswick",
						 @"Newfoundland",
						 @"Northwest Territories",
						 @"Nova Scotia",
						 @"Nunavut",
						 @"Quebec",
						 @"Ontario",
						 @"Prince Edward Island",
						 @"Saskatchewan",
						 @"Yukon",
						 nil];
		[arrLetterValue replaceObjectAtIndex:rowId withObject:[arr objectAtIndex:ii]];
		
		CellIdentifier = @"Subtitle1";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
			cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:15];
			cell.detailTextLabel.textAlignment = UITextAlignmentRight;
		}
		cell.textLabel.text = [arrLetter objectAtIndex:rowId];
		cell.detailTextLabel.text = [arrLetterValue objectAtIndex:rowId];
		return cell;
		
	}else if (rowId == 5) {
		
		//news letter prefered language = nlpl
		NSInteger ii = [[NSUserDefaults standardUserDefaults] integerForKey:@"nlpl"];
		NSArray *arr  = [NSArray arrayWithObjects:@"English",@"Français",nil];
		[arrLetterValue replaceObjectAtIndex:rowId withObject:[arr objectAtIndex:ii]];
		
		CellIdentifier = @"Subtitle2";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
			cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:15];
			cell.detailTextLabel.textAlignment = UITextAlignmentRight;
		}
		cell.textLabel.text = [arrLetter objectAtIndex:rowId];
		cell.detailTextLabel.text = [arrLetterValue objectAtIndex:rowId];
		return cell;
    }else if (rowId == 6) {
		
		
		
		CellIdentifier = @"agree";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			cell.accessoryType = UITableViewCellAccessoryNone;
			
		}
        
        UILabel *lblSTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 300, 20)];
        lblSTitle.font = [UIFont boldSystemFontOfSize:12];
        
        
        UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 103)];
        lblText.font = [UIFont systemFontOfSize:10];
        lblText.numberOfLines = 0;
        lblText.lineBreakMode = NSLineBreakByWordWrapping;
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
        {
            lblSTitle.text = @"Subscription Terms";
             lblText.text = @"I understand that by providing my full name, e-mail address, company name, city, province, and language preference, that I am subscribing to the Canada Guaranty e-newsletter and am consenting to being periodically contacted via e-mail. Canada Guaranty respects your privacy and will not, under any circumstances, disclose, distribute, share or sell your contact information. You may unsubscribe at any time.";
        }
        else
        {
            lblSTitle.text = @"Conditions de souscription";

            lblText.text = @"Je comprends qu'en signant ce formulaire et en fournissant mon nom, adresse courriel, province, nom de compagnie et préférence de langue, que je serai périodiquement contacté par Guaranty Canada par leur service de nouvelles. Canada Guaranty respecte vos confidentialité et ne divulguera ni distribuera vos informations personnelles en aucune circonstance. Vous pouvez en tout temps vous désabonner.";
        }
       
        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(250, 110, 110, 35)];
        [sw addTarget:self action:@selector(agreed:) forControlEvents:UIControlEventValueChanged];
        [sw setOn:agreed];
        
        [cell.contentView addSubview:lblText];
        [cell.contentView addSubview:lblSTitle];
        [cell.contentView addSubview:sw];

        
		return cell;
		
	}else {
		CellIdentifier = @"NewsLetter";
		TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			UIViewController* controller = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
			cell = (TableCell *) controller.view;
			[controller release];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			//cell.textField.keyboardType = UIKeyboardTypeNumberPad;
		}
		
		if(rowId != 2)
			cell.textField.keyboardType = UIKeyboardTypeNamePhonePad;
		else
			cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
		
		cell.textField.delegate = self;
		cell.textField.tag = rowId;
		
		cell.lblTitle.text = [arrLetter objectAtIndex:rowId];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChange:)
													 name:UITextFieldTextDidChangeNotification
												   object:cell.textField];
		
		if(rowId == 4)
			cell.textField.returnKeyType = UIReturnKeyDone;
		//		else
		//			cell.textField.returnKeyType = UIReturnKeyNext;
		
		return cell;
		
	}

}

-(IBAction)agreed:(id)sender
{
    UISwitch *sw = (UISwitch *)sender;
    if(sw.isOn)
    {
        agreed = YES;
    }
    else
    {
        agreed = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];

	int rowid = indexPath.row;
	
	if(txt){
		CGRect rc = [txt bounds];
		UITableView * v = tblNewsletter;
		rc = [txt convertRect:rc toView:v];
		CGPoint pt = rc.origin ;
		pt.y = 0 ;
		pt.x = 0;
		[v setContentOffset:pt animated:YES];
		[txt resignFirstResponder];
		
//		if(txt.tag == 1 && [arrLetterValue objectAtIndex:1]){
//			if(![self validateEmail:[arrLetterValue objectAtIndex:1]])
//				[self showAlert:[self getString:@"Warning!"] :@"Please enter correct email."];
//		}
		
	}
	
	[txt resignFirstResponder];

	if (rowid == 3) {
	
		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		NSArray *arr  = [NSArray arrayWithObjects:
                         @"Please select",
						 @"Alberta",
						 @"British Columbia",
						 @"Manitoba",
						 @"New Brunswick",
						 @"Newfoundland",
						 @"Northwest Territories",
						 @"Nova Scotia",
						 @"Nunavut",
						 @"Quebec",
						 @"Ontario",
						 @"Prince Edward Island",
						 @"Saskatchewan",
						 @"Yukon",
						 nil];
		
        
		[picker showPicker:arr :@"province" :tblNewsletter];
		
	}else if(rowid == 5){
		PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
		[picker showPicker:[NSArray arrayWithObjects:@"English",@"Français",nil]
							  :@"nlpl" :tblNewsletter];
		
	}
}

- (void)deselect{   
	[tblNewsletter deselectRowAtIndexPath:[tblNewsletter indexPathForSelectedRow] animated:YES];
}

-(IBAction)settingAction{
	[self showSettings];
}


#pragma mark -
#pragma mark - UITextField Lifecycle Methods 
#pragma mark -

//my own method
-(void)textFieldValueChange:(NSNotification*)aNotification{
	UITextField *newTxt = [aNotification object];
	
	if(newTxt.tag == 1 && [newTxt.text length]>0){
		txt.returnKeyType = UIReturnKeyDone;
		newTxt.returnKeyType = UIReturnKeyDone;
	}
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	
	CGRect rc = [textField bounds];
	UITableView * v = tblNewsletter;
	rc = [textField convertRect:rc toView:v];
	CGPoint pt = rc.origin ;
	pt.y = 0 ; pt.x = 0;
	[v setContentOffset:pt animated:YES];
	[textField resignFirstResponder];
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
	txt = textField;
	[txt retain];
	
	tblNewsletter.scrollEnabled = NO;
	//	NSLog(@"Selected TextField is %d", textField.tag);
	CGRect rc = [textField bounds];
	UITableView * v = tblNewsletter;
	rc = [textField convertRect:rc toView:v];
	CGPoint pt = rc.origin ;
	pt.y = pt.y - 10;
	pt.x = 0 ;
	[v setContentOffset:pt animated:YES];
}        

- (void) textFieldDidEndEditing:(UITextField *)textField{
	
	tblNewsletter.scrollEnabled = YES;
	if ( textField ){
		int tID = textField.tag;
		if ( textField.text )
			[arrLetterValue replaceObjectAtIndex:tID withObject:textField.text];		
	}
	if([textField isFirstResponder])
		[textField resignFirstResponder];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//	
//	if([[arrLetterValue objectAtIndex:0] length]>0 && [[arrLetterValue objectAtIndex:1]length]>0)
//		textField.returnKeyType = UIReturnKeyDone;
//
//	return YES;
//}

#pragma mark -
#pragma mark === Memory Management Function ===
#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {}


- (void)dealloc {
    [super dealloc];
}

@end