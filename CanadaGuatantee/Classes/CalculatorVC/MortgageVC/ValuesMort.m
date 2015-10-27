//
//  Values.m
//  AustinTree
//
//  Created by root1 on 11/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ValuesMort.h"

@implementation ValuesMort
{
    NSInteger currentRow;
}


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
	arrTblVal = [[[NSMutableArray alloc] initWithArray:[self selectedValueForProduct:_valueSection]] retain];
	
}



-(NSArray *)selectedValueForProduct:(NSInteger)rowId
{
    
    
    NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"down"];
    NSArray *arr  = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];
    
    NSString *val = arr[ii];
    
    NSInteger valInt = [val integerValue];
    NSArray *temp;
    
    if(valInt == 5)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Flex 95 Advantage", nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Flex 95",nil];
        currentRow = rowId;
        
    }
    if(valInt == 10 || valInt == 15)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        switch (rowId) {
            case 0:
                currentRow = 0;
                break;
            case 1:
                currentRow = 1;
                break;
            default:
                break;
        }
        
    }
    if(valInt >= 20 && valInt <= 85)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",@"Rental Advantage",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",@"Avantage Locatif",nil];
        switch (rowId) {
            case 0:
                currentRow = 0;
                break;
            case 1:
                currentRow = 1;
                break;
            case 2:
                currentRow = 2;
                break;
            default:
                break;
        }
        
    }
    if(valInt == 90 || valInt == 95)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        switch (rowId) {
            case 0:
                currentRow = 0;
                break;
            case 1:
                currentRow = 1;
                break;
            default:
                break;
        }
    }
    if(valInt == 100)
    {
        
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",nil];
        currentRow = 0;
    }
    
    return temp;
    
}


-(NSInteger)selectedIntegerProduct:(NSInteger)rowId
{
    
    
    NSInteger ii = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"down"];
    NSArray *arr  = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100",nil];
    
    NSString *val = arr[ii];
    
    NSInteger valInt = [val integerValue];
    NSArray *temp;
    
    if(valInt == 5)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Flex 95 Advantage", nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Flex 95",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        else
        {
            return 1;
        }
        
    }
    if(valInt == 10 || valInt == 15)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        else
        {
            return 2;
        }

        
    }
    if(valInt >= 20 && valInt <= 85)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",@"Rental Advantage",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",@"Avantage Locatif",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        if(rowId == 1)
        {
            return 2;
        }
        if(rowId == 2)
        {
            return 3;
        }

        
    }
    if(valInt == 90 || valInt == 95)
    {
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",@"Low Doc Advantage (Self-Employed)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",@"Avantage Autonome (Travailleurs autonomes)",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
        if(rowId == 1)
        {
            return 2;
        }
        
        
    }
    if(valInt == 100)
    {
        
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0)
            temp  = [NSArray arrayWithObjects:@"Standard (Down Payment Advantage)",nil];
        else
            temp  = [NSArray arrayWithObjects:@"Standard (Avantage Mise de fonds)",nil];
        
        if(rowId == 0)
        {
            return 0;
        }
       
    }
    
    return temp;
    
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
    
	//int idx = [[NSUserDefaults standardUserDefaults] integerForKey:@"products"];
    
	if(currentRow == indexPath.row)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
	
	cell.textLabel.text = [arrTblVal objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
	
	[[NSUserDefaults standardUserDefaults] setInteger:[self selectedIntegerProduct:indexPath.row] forKey:@"products"];
    
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
