//
//  Values.m
//  AustinTree
//
//  Created by root1 on 11/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Values.h"

@implementation Values



- (void)viewDidLoad {
   
	[super viewDidLoad];
	
	
	lblTitle.text = [self getString:@"Insurance Type:"];
	
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateSelected];
		
		
	}else {
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateHighlighted];
		[btnBack setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateSelected];
		
		
		
	}
	NSArray *arr;
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
		arr  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Flex 95 Advantage",@"Low Doc Advantage (Self-Employed)",@"Rental Advantage",nil];
	else
		arr  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Flex 95",@"Avantage Autonome (Travailleurs autonomes)",@"Avantage Locatif",nil];

	
	arrTblVal = [[[NSMutableArray alloc] initWithArray:arr] retain];
	
}



- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {}

#pragma mark -
#pragma mark === Table View Methods ===
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arrTblVal count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	cell.textLabel.numberOfLines = 2;

	int idx = [[NSUserDefaults standardUserDefaults] integerForKey:@"insurancetype"];

	if(idx == indexPath.row)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
	
	cell.textLabel.text = [arrTblVal objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
	
	[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"insurancetype"];
	//[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"insurancerate"];

	[self.navigationController popViewControllerAnimated:YES];
}

- (void) deselect{   
	[tblValues deselectRowAtIndexPath:[tblValues indexPathForSelectedRow] animated:YES];
}


-(IBAction)settingAction{

	[self showSettings];
}

-(IBAction)backAction{

	[self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc {
	[tblValues release];
	[arrTblVal release];
    [super dealloc];
}


@end
