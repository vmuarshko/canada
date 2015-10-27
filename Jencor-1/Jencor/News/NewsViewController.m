//
//  NewsViewController.m
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailsController.h"
#import "NewsApi.h"
#import "News.h"
#import "NewsCell.h"

@implementation NewsViewController
@synthesize tbl,tblData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tbl release];
    [tblData release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JencorAppDelegate *appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];

    
    CGRect frame = self.view.frame;
    frame.size.height += 75;
    self.view.frame = frame;
    frame = tbl.frame;
    frame.size.height += 75;
    if(!appDelegate.isIphone5)
    {
        frame.origin.y += 80;
        tbl.frame = frame;

    }
    else
    {
        tbl.frame = frame;

    }
    
    
    // Do any additional setup after loading the view from its nib.
    [self addCommonHeaderForView:@"News" modal:NO showBackButton:NO showEmailButton:NO];
    
    
}

- (void)viewDidUnload
{
    [self setTbl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(!wasInDetails){
        NewsApi *api=[[NewsApi alloc] init];
        api.parent=self;
        [api requestForNews];
    }else
        wasInDetails=FALSE;
    
}


#pragma mark ---
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self adjustCellHeightForText:[[tblData objectAtIndex:indexPath.row] title]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tblData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"NewsCell";
    
    NewsCell *cell=(NewsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        UIViewController *controller=[[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
        cell=(NewsCell *)controller.view;
        
    }
    cell.lblTitle.text=[[tblData objectAtIndex:indexPath.row] title];
    
    
    //Adjust Label Size to accomodate bigger text
    [self adjustLabelSizeForLabel:cell.lblTitle andText:cell.lblTitle.text];
    
    
    //Adjust the arrow position according to Label New Position
    CGRect arrowFrame=cell.arrow.frame;
    
    arrowFrame.origin.y=cell.lblTitle.frame.origin.y + cell.lblTitle.frame.size.height/4;
    
    cell.arrow.frame=arrowFrame;
    
    UIImageView *cellImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 53)];
    
    if(indexPath.row == 0)
        cellImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"news_tableview_top.png")];
    else if(indexPath.row == [tblData count] - 1)
        cellImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"news_tableview_bottom.png")];
    else
        cellImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"news_tableview_middle.png")];
    
    cell.backgroundView=cellImage;
    
    [cellImage release];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSelector:@selector(deselect:) withObject:indexPath afterDelay:.1];
    
}

-(void)deselect:(NSIndexPath *)indexPath{
    
    [self.tbl deselectRowAtIndexPath:indexPath animated:YES];
    wasInDetails=TRUE;
    NewsDetailsController *controller=[[NewsDetailsController alloc] initWithNibName:@"NewsDetailsController" bundle:nil];
    controller.news=[tblData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
