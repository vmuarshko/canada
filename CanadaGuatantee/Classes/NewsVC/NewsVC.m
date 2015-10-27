//
//  NewsVC.m
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsVC.h"
#import "WebVC.h"

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	lblTitle.text = [self getString:@"NEWS CENTRE"];
	[self showHUD:[self getString:@"Fetching Data"]];
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getXMLData) userInfo:nil repeats:NO];
}

#pragma mark -
#pragma mark === xmlParser Methods ===
#pragma mark -

-(void)getXMLData{
	
	arrItem = [[[NSMutableArray alloc] init] retain]; 

	NSString *strUrl;
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
		strUrl = [NSString stringWithFormat:@"%@feed?cat=1", kBASEURL_EN ];
	else
		strUrl = [NSString stringWithFormat:@"%@feed?cat=1", kBASEURL_FR ];
	NSLog(@"%@", strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLResponse *response;
	NSError *error;
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
	NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	
	[self killHUD];
	//NSString *xmlString = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
    //NSLog(@"XML string: %@", xmlString);
    
    
	if(urlData && [urlData length]>1000){
		
		response = nil;
		error = nil;
		urlRequest = nil;
		
		[self showHUD:[self getString:@"Parsing Data"]];
		
		NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:urlData];
		[xmlParser setDelegate:self];
		[xmlParser setShouldResolveExternalEntities:YES];
		
		if([xmlParser parse]){
			
			[self killHUD];
			
			xmlParser = nil;
			urlData = nil;
			
			strValue = nil;
			dicItem = nil;
			
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
	
	[tblNews reloadData];	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString *)qName attributes: (NSDictionary *)attributeDict
{	
	strValue = [[[NSMutableString alloc] init]retain];
	if([elementName isEqualToString:@"item"]){
		isItem = TRUE;
		dicItem = [[[NSMutableDictionary alloc] init]retain];
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
		
		if([elementName isEqualToString:@"title"])
			[dicItem setObject:strValue forKey:@"title"];
		
		if([elementName isEqualToString:@"link"])
			[dicItem setObject:strValue forKey:@"link"];
		
		if([elementName isEqualToString:@"comments"])
			[dicItem setObject:strValue forKey:@"comments"];
		
		if([elementName isEqualToString:@"pubDate"])
			[dicItem setObject:strValue forKey:@"pubDate"];
		
		if([elementName isEqualToString:@"description"])
			[dicItem setObject:strValue forKey:@"description"];
		
		if([elementName isEqualToString:@"content:encoded"])
			[dicItem setObject:strValue forKey:@"content:encoded"];
		
		if([elementName isEqualToString:@"item"]){
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arrItem count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14];
		cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	}
	cell.textLabel.text = [[arrItem objectAtIndex:indexPath.row] objectForKey:@"title"];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
	WebVC *webObj = [[WebVC alloc] initWithNibName:@"WebVC" bundle:nil];
	
	webObj.dic = [arrItem objectAtIndex:indexPath.row];
	[webObj.dic retain];
	
	webObj.strImage = @"1b.png";
	[webObj.strImage retain];
	
	webObj.strTitle = @"NEWS RELEASES";
	[webObj.strTitle retain];
	
	[self.navigationController pushViewController:webObj animated:YES];
}

-(IBAction)settingAction{
	[self showSettings];
}

- (void) deselect{   
	[tblNews deselectRowAtIndexPath:[tblNews indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark === Memory Management Function ===
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {}


- (void)dealloc {
    [super dealloc];
	[tblNews release];
}

@end
