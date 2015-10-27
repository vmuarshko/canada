//
//  HomeViewController.m
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "Rate.h"
#import "RatesApi.h"
#import "RatesCell.h"
#import "PartnerConroller.h"
#import "GlossaryController.h"

@implementation HomeViewController
@synthesize viewRates;
@synthesize viewHome;
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
    [viewRates release];
    [viewHome release];
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
    // Do any additional setup after loading the view from its nib.
   
    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    header=(CommonHeader *)[self addCommonHeaderForView:@"Rates" modal:NO showBackButton:NO showEmailButton:NO];
    
    [viewRates addSubview:header];
    [header.btnHome addTarget:self action:@selector(homeFromRatesAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (IBAction)homeFromRatesAction:(id)sender {
    
    UIButton *firstTabButton=nil;
    
    for(UIButton *btn in [appDelegate.viewButtons subviews]){
        
        if([btn isKindOfClass:[UIButton class]]){
            
            if(btn.tag == 0){
                firstTabButton=btn;
                break;
            }
            
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromTab"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    firstTabButton.tag = 99;
    [appDelegate tabButtonAction:firstTabButton];
    
    
    //[self setupView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
    
    [self setupView];
}

- (IBAction)menuAction:(id)sender {
    //Common Menu Button Action
    UIButton *btn=(UIButton *)sender;
    int curTag=btn.tag;
    
    if(curTag == 2)
        curTag=3;//News
    else if(curTag == 6)
        curTag=4;//Contact
    else if(curTag == 3)
        curTag=2;//Apply
    else if(curTag == 4){
        GlossaryController *controller=[[GlossaryController alloc] initWithNibName:@"GlossaryController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        curTag=6;//Don't select from Tab
    }else if(curTag == 5){
        PartnerConroller *controller=[[PartnerConroller alloc] initWithNibName:@"PartnerConroller" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        
        curTag=6;//Don't select from Tab
    }
    
    if(curTag<5)
        [self selectRespectedTab:curTag];    
    
}

-(void)selectRespectedTab:(int)index{
    //Open Tab from Menu
    
    UIButton *tabButton=nil;
    
    for(UIButton *btn in [appDelegate.viewButtons subviews]){
        
        if([btn isKindOfClass:[UIButton class]]){
            
            if(btn.tag == index){
                tabButton=btn;
                break;
            }
            
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"fromTab"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [appDelegate tabButtonAction:tabButton];
}

-(void)setupView{
    
    BOOL fromTab=[[NSUserDefaults standardUserDefaults] boolForKey:@"fromTab"];
    
    if(fromTab){
        [viewHome removeFromSuperview];
        [self.view addSubview:viewRates];
        if(appDelegate.isIphone5)
        {
            CGRect frame = viewRates.frame;
            frame.size.height = 487;
            viewRates.frame = frame;
            frame = tbl.frame;
            frame.size.height = 324;
            frame.origin.y = 122;
            tbl.frame = frame;
        }
        
        RatesApi *api=[[RatesApi alloc] init];
        api.parent=self;
        [api makeRequest];
    }else{
        [viewRates removeFromSuperview];
        [self.view addSubview:viewHome];
    }
    
    //[Utility fadeView:self.view];
    
}




#pragma mark ---
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tblData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"RatesCell";
    
    RatesCell *cell=(RatesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        UIViewController *controller=[[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
        cell=(RatesCell *)controller.view;
        
              
    }
    
    
    Rate *rate=[tblData objectAtIndex:indexPath.row];
    cell.lblDetails.text=[rate.mortType uppercaseString];
    cell.lblRate.text=[NSString stringWithFormat:@"%@%%",rate.ourRate];
    cell.lblType.text=rate.mort_type;
    
    UIImageView *cellImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    
    if(indexPath.row == 0)
        cellImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"rates_tableview_top.png")];
    else if(indexPath.row == [tblData count] - 1)
        cellImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"rates_tableview_bottom.png")];
    else
        cellImage.image=[UIImage imageWithContentsOfFile:JBUNDLE(@"rates_tableview_middle.png")];
    
    cell.backgroundView=cellImage;
    
    [cellImage release];
    
    return cell;
    
}
  

- (void)viewDidUnload
{
    [self setViewRates:nil];
    [self setViewHome:nil];
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

@end
