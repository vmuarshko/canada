//
//  ContactWV.m
//  CanadaGuatantee
//
//  Created by root1 on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContactWV.h"


@implementation ContactWV
@synthesize strTitle;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(IBAction)settingAction{
	[self showSettings];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    sections = [NSMutableArray new];
	[contactWVC setBackgroundColor:[UIColor whiteColor]];
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateSelected];
	}else {
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateSelected];
	}
	
	NSString *path;
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
	
	{	
		if([strTitle isEqualToString:@"mc"])
			path = [[NSBundle mainBundle] pathForResource:@"mc" ofType:@"html"];
		
		else if([strTitle isEqualToString:@"nuc"])
			path = [[NSBundle mainBundle] pathForResource:@"nuc" ofType:@"html"];
		
		else if([strTitle isEqualToString:@"nst"])
        {
            
            [self getXMLData];
            
            
            /*path = @"http://www.canadaguaranty.ca/contact-us/national-sales-team/?xml=feed2";
            
            //path = [[NSBundle mainBundle] pathForResource:@"nst" ofType:@"html"];

            
            //NSError *error;
            //NSString *filebuf = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error ];
            
            [contactWVC loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]];
            contactWVC.delegate = self;
            contactWVC.scalesPageToFit = TRUE;*/
            return;
        }
		
		else if([strTitle isEqualToString:@"lmc"])
			path = [[NSBundle mainBundle] pathForResource:@"lmc" ofType:@"html"];
		
		else if([strTitle isEqualToString:@"fr"])
			path = [[NSBundle mainBundle] pathForResource:@"fr" ofType:@"html"];

	}else {
		
		if([strTitle isEqualToString:@"mc"])
			path = [[NSBundle mainBundle] pathForResource:@"mc2" ofType:@"html"];
		
		else if([strTitle isEqualToString:@"nuc"])
			path = [[NSBundle mainBundle] pathForResource:@"nuc2" ofType:@"html"];
		
		else if([strTitle isEqualToString:@"nst"])
        {
            [self getXMLData];
            return;
        }
			//path = [[NSBundle mainBundle] pathForResource:@"nst2" ofType:@"html"];
		
		else if([strTitle isEqualToString:@"lmc"])
			path = [[NSBundle mainBundle] pathForResource:@"lmc2" ofType:@"html"];
		
		else if([strTitle isEqualToString:@"fr"])
			path = [[NSBundle mainBundle] pathForResource:@"fr2" ofType:@"html"];
		
	}


	NSError *error;
	NSString *filebuf = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error ]; 
	
	[contactWVC loadHTMLString:filebuf baseURL:nil];
	contactWVC.delegate = self;
	contactWVC.scalesPageToFit = TRUE;
	
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



#pragma mark -
#pragma mark === xmlParser Methods ===
#pragma mark -

-(BOOL)isIphone5
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 960) {
                //NSLog(@"iPhone 4 Resolution");
                return NO;
            }
            if(result.height == 1136) {
                //NSLog(@"iPhone 5 Resolution");
                //[[UIScreen mainScreen] bounds].size =result;
                return YES;
            }
        }
        else{
            // NSLog(@"Standard Resolution");
            return NO;
        }
    }
    return NO;
}



-(void)getXMLData{
	
	arrItem = [[[NSMutableArray alloc] init] retain];
    
	NSString *strUrl;
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
		strUrl = @"http://www.canadaguaranty.ca/contact-us/national-sales-team/?xml=feed2";
	else
		strUrl = @"http://www.canadaguaranty.ca/fr/contactez-nous/equipe-nationale-des-ventes?xml=feed2";
	
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLResponse *response;
	NSError *error;
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
	NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	
	[self killHUD];
	
	if(urlData && [urlData length]>1000){
		
		response = nil;
		error = nil;
		urlRequest = nil;
		
		[self showHUD:[self getString:@"Parsing Data"]];
		
		NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:urlData];
		[xmlParser setDelegate:self];
		[xmlParser setShouldResolveExternalEntities:NO];
		
		if([xmlParser parse]){
			
			[self killHUD];
			
			xmlParser = nil;
			urlData = nil;
			
			strValue = nil;
			dicItem = nil;
            
            NSLog(@"result: %i", arrItem.count);
            NSLog(@"result: %@", arrItem);
            [self splitArray];
            
            if(arrItem.count > 0)
            {
                table = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, [self isIphone5] ? 390 : 310) style:UITableViewStylePlain];
                table.delegate = self;
                table.dataSource = self;
                [self.view addSubview:table];
                [table reloadData];
            }
            
			
		}else{
			[self killHUD];
			
			NSString *xmlString = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
			NSLog(@"XML string: %@", xmlString);
			NSLog(@"Error while parsing");
		}
		
	}else{
		
		//NSLog(@"Error: %@", [error description]);
		NSString *strMsg = [[error userInfo] valueForKey:@"NSLocalizedDescription"];
		NSLog(@"Error: %@", strMsg);
		
		if([strMsg isEqualToString:@"no Internet connection"])
			[self showAlert:[self getString:@"Error!"] :[self getString:@"Sorry! No internet connection available. Please try again."]];
		
		else if([strMsg isEqualToString:@"timed out"])
			[self showAlert:[self getString:@"Error!"] :[self getString:@"A server error has occurred. Please try again."]];
		
		else if([strMsg isEqualToString:@"unsupported URL"])
			[self showAlert:[self getString:@"Error!"] :[self getString:@"A server error has occurred. Please try again."]];
		
	}
	
	//[table reloadData];
}

-(void)splitArray
{
    for(NSDictionary *item in arrItem)
    {
        NSString *type = [item objectForKey:@"type"];
        if(![sections containsObject:type])
        {
            [sections addObject:type];
            
        }
    }
}


-(NSMutableArray *)getItemsByRegion:(NSString *)region
{
    NSMutableArray *temp = [NSMutableArray new];
    for(NSDictionary *item in arrItem)
    {
        NSString *type = [item objectForKey:@"type"];
        if([type isEqualToString:region])
        {
            [temp addObject:item];
            
        }
    }
    
    return temp;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString *)qName attributes: (NSDictionary *)attributeDict
{
	strValue = [[[NSMutableString alloc] init]retain];
	if([elementName isEqualToString:@"member"]){
		isItem = TRUE;
		dicItem = [[[NSMutableDictionary alloc] init]retain];
        
        NSString *type = [attributeDict objectForKey:@"type"];
        
        
        [dicItem setObject:[type uppercaseString] forKey:@"type"];
	}
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\'" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@" "];
	[strValue appendString: string];
	[strValue retain];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if(isItem){
		
		if([elementName isEqualToString:@"name"])
			[dicItem setObject:strValue forKey:@"name"];
        
		if([elementName isEqualToString:@"thetitle"])
			[dicItem setObject:strValue forKey:@"thetitle"];
		
		if([elementName isEqualToString:@"region"])
			[dicItem setObject:strValue forKey:@"region"];
		
		if([elementName isEqualToString:@"telephone"])
			[dicItem setObject:strValue forKey:@"telephone"];
		
		if([elementName isEqualToString:@"tollfree"])
			[dicItem setObject:strValue forKey:@"tollfree"];
		
		if([elementName isEqualToString:@"tollfreeext"])
			[dicItem setObject:strValue forKey:@"tollfreeext"];
		
        if([elementName isEqualToString:@"email"])
			[dicItem setObject:strValue forKey:@"email"];
        
		if([elementName isEqualToString:@"member"]){
			isItem = FALSE;
			[arrItem addObject:dicItem];
			dicItem = nil;
		}
	}
	
	[strValue release];
	strValue = nil;
}



#pragma mark -
#pragma mark === Table View Methods ===
#pragma mark -

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *temp = [self getItemsByRegion:[sections objectAtIndex:indexPath.section]];

    
    UILabel *lblTitleRegion = [[UILabel alloc] initWithFrame:CGRectMake(5, 27, 290, 25)];
    lblTitleRegion.font = [UIFont boldSystemFontOfSize:15];
    lblTitleRegion.text = [NSString stringWithFormat:@"%@, %@", [[temp objectAtIndex:indexPath.row] objectForKey:@"thetitle"],[[temp objectAtIndex:indexPath.row] objectForKey:@"region"]];
    lblTitleRegion.numberOfLines = 0;
    lblTitleRegion.lineBreakMode = NSLineBreakByWordWrapping;

    return [self getLabelSize:lblTitleRegion.text fontSize:15] + 25 + 20 + 20 + 25;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sections objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *temp = [self getItemsByRegion:[sections objectAtIndex:section]];
	return [temp count];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.count;
}


-(CGFloat)getLabelSize:(NSString *)text fontSize:(NSInteger)fontSize
{
    UIFont *cellFont = [UIFont systemFontOfSize:fontSize];
	CGSize constraintSize = CGSizeMake(290, MAXFLOAT);
	CGSize labelSize = [text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		//cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14];
		//cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        //cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:12];
        //cell.detailTextLabel.font = [UIFont systemFontOfSize:12];

	}
    
    NSMutableArray *temp = [self getItemsByRegion:[sections objectAtIndex:indexPath.section]];

    
    BOOL eng = [[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0;
    
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, 290, 25)];
    lblName.font = [UIFont boldSystemFontOfSize:15];
    lblName.text = [NSString stringWithFormat:@"%@", [[temp objectAtIndex:indexPath.row] objectForKey:@"name"]] ;
    
    [cell.contentView addSubview:lblName];
    
    UILabel *lblTitleRegion = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 290, 25)];
    lblTitleRegion.font = [UIFont boldSystemFontOfSize:15];
    lblTitleRegion.text = [NSString stringWithFormat:@"%@, %@", [[temp objectAtIndex:indexPath.row] objectForKey:@"thetitle"],[[temp objectAtIndex:indexPath.row] objectForKey:@"region"]];
    lblTitleRegion.numberOfLines = 0;
    lblTitleRegion.lineBreakMode = NSLineBreakByWordWrapping;
    lblTitleRegion.frame = CGRectMake(5, 25, 300, [self getLabelSize:lblTitleRegion.text fontSize:15]);
    [cell.contentView addSubview:lblTitleRegion];
    
    UILabel *lblTelephone = [[UILabel alloc] initWithFrame:CGRectMake(5, [self getLabelSize:lblTitleRegion.text fontSize:15] + 25, 290, 20)];
    lblTelephone.font = [UIFont systemFontOfSize:12];
    lblTelephone.text = [NSString stringWithFormat:eng ? @"Telephone: %@" : @"Téléphone: %@", [[temp objectAtIndex:indexPath.row] objectForKey:@"telephone"]] ;
    
    [cell.contentView addSubview:lblTelephone];
    
    UILabel *lblTollFree = [[UILabel alloc] initWithFrame:CGRectMake(5, [self getLabelSize:lblTitleRegion.text fontSize:15] + 25 + 20, 290, 20)];
    lblTollFree.font = [UIFont systemFontOfSize:12];
    lblTollFree.text = [NSString stringWithFormat:eng ? @"Toll Free: %@ ext. %@" : @"Sans-frais: %@ ext. %@", [[temp objectAtIndex:indexPath.row] objectForKey:@"tollfree"], [[temp objectAtIndex:indexPath.row] objectForKey:@"tollfreeext"]] ;
    
    [cell.contentView addSubview:lblTollFree];
    
    UILabel *lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(5, [self getLabelSize:lblTitleRegion.text fontSize:15] + 25 + 20 + 20, 290, 20)];
    lblEmail.font = [UIFont systemFontOfSize:12];
    lblEmail.text = [NSString stringWithFormat:eng ? @"Email: %@" : @"Courriel: %@", [[temp objectAtIndex:indexPath.row] objectForKey:@"email"]] ;
    
    [cell.contentView addSubview:lblEmail];
    
    
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(IBAction)backBtn{

    [table removeFromSuperview];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
