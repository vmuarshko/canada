//
//  ContactVC.m
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContactVC.h"
#import "ContactWV.h"

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
	lblTitle.text = [self getString:@"Corporate Head Office"];

	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 )
		arrContacts = [NSArray arrayWithObjects:@"Media Centre",@"National Underwriting Centre",@"National Sales Team",@"Loss Management & Claims",@"Fraud Reporting",nil];
	else 
		arrContacts = [NSArray arrayWithObjects:@"Média/Relations publiques",@"Centre national de souscription",@"Équipe nationale des ventes",@"Gestion des pertes et réclamations",@"Signalisation des cas de fraude",nil];

	[arrContacts retain];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
}

#pragma mark -
#pragma mark - Table view methods
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:13];
		cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	}
	cell.textLabel.text = [arrContacts objectAtIndex:indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
	
	ContactWV *webObj = [[ContactWV alloc] initWithNibName:@"ContactWV" bundle:nil];
	switch (indexPath.row) {
		case 0:
			webObj.strTitle = @"mc";
			break;
		case 1:
			webObj.strTitle = @"nuc";
			break;
		case 2:
			webObj.strTitle = @"nst";
			break;
		case 3:
			webObj.strTitle = @"lmc";
			break;
		case 4:
			webObj.strTitle = @"fr";
			break;
	}
	[webObj.strTitle retain];
	[self.navigationController pushViewController:webObj animated:YES];
	
}

- (void)deselect{   
	[tblContact deselectRowAtIndexPath:[tblContact indexPathForSelectedRow] animated:YES];
}

-(IBAction)settingAction{
	[self showSettings];
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
}

@end
