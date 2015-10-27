//
//  CanadaGuatanteeViewController.m
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CanadaGuatanteeViewController.h"
#import "CanadaGuatanteeAppDelegate.h"

#import "CustomUITabBarItem.h"

#import "NewsVC.h"
#import "ProductsVC.h"
#import "NewsLetterVC.h"
#import "CalculatorsVC.h"
#import "ContactVC.h"

@implementation CanadaGuatanteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializeTabs) name:TABRELOADTEXT object:nil];

	[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(initializeTabs) userInfo:nil repeats:NO];
}


-(void)initializeTabs{
	
	NSMutableArray *arrNavObj = [[[NSMutableArray alloc] init]retain];
	UINavigationController *navCont = [[UINavigationController alloc ]init];
	CustomUITabBarItem *tabItem;
	
	NewsVC *newsObj = [[NewsVC alloc] initWithNibName:@"NewsVC" bundle:nil];
	navCont = [[UINavigationController alloc ]initWithRootViewController:newsObj]; 
	navCont.navigationBar.hidden = YES;
	tabItem = [[CustomUITabBarItem alloc] init];
	tabItem.title = [self getString:@"News"];
	tabItem.image = [UIImage  imageNamed:@"news2.png"];
	tabItem.customHighlightedImage= [UIImage imageNamed:@"news2.png"];
	navCont.tabBarItem=tabItem;
	[tabItem release]; tabItem=nil;
	[arrNavObj addObject:navCont];
	navCont = nil;
	newsObj = nil;
	

	ProductsVC *productsObj = [[ProductsVC alloc] initWithNibName:@"ProductsVC" bundle:nil];
	navCont = [[UINavigationController alloc ]initWithRootViewController:productsObj]; 
	navCont.navigationBar.hidden = YES;
	tabItem = [[CustomUITabBarItem alloc] init];
	tabItem.title = [self getString:@"Products"];
	tabItem.image = [UIImage  imageNamed:@"product2.png"];
	tabItem.customHighlightedImage= [UIImage  imageNamed:@"product2.png"];
	navCont.tabBarItem=tabItem;
	[tabItem release]; tabItem=nil;
	[arrNavObj addObject:navCont];
	navCont = nil;
	newsObj = nil;
	
	CalculatorsVC *calculatorsObj = [[CalculatorsVC alloc] initWithNibName:@"CalculatorsVC" bundle:nil];
	navCont = [[UINavigationController alloc ]initWithRootViewController:calculatorsObj]; 
	navCont.navigationBar.hidden = YES;
	tabItem = [[CustomUITabBarItem alloc] init];
	tabItem.title = [self getString:@"Calculators"];
	tabItem.image = [UIImage  imageNamed:@"calc2.png"];
	tabItem.customHighlightedImage= [UIImage  imageNamed:@"calc2.png"];
	navCont.tabBarItem=tabItem;
	[tabItem release]; tabItem=nil;
	[arrNavObj addObject:navCont];
	navCont = nil;
	newsObj = nil;
	
	NewsLetterVC *newsletterObj = [[NewsLetterVC alloc] initWithNibName:@"NewsLetterVC" bundle:nil];
	navCont = [[UINavigationController alloc ]initWithRootViewController:newsletterObj]; 
	navCont.navigationBar.hidden = YES;
	tabItem = [[CustomUITabBarItem alloc] init];
	tabItem.title = [self getString:@"Newsletter"];
	tabItem.image = [UIImage  imageNamed:@"letter2.png"];
	tabItem.customHighlightedImage= [UIImage  imageNamed:@"letter2.png"];
	navCont.tabBarItem=tabItem;
	[tabItem release]; tabItem=nil;
	[arrNavObj addObject:navCont];
	navCont = nil;
	newsObj = nil;
	
	ContactVC *contactObj;
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0 ){
		contactObj = [[ContactVC alloc] initWithNibName:@"ContactVC" bundle:nil];
	}else {
		contactObj = [[ContactVC alloc] initWithNibName:@"ContactVCfr" bundle:nil];
	}

//	contactObj = [[ContactVC alloc] initWithNibName:@"ContactVC" bundle:nil];
	navCont = [[UINavigationController alloc ]initWithRootViewController:contactObj]; 
	navCont.navigationBar.hidden = YES;
	tabItem = [[CustomUITabBarItem alloc] init];
	tabItem.title = [self getString:@"Contact"];
	tabItem.image = [UIImage  imageNamed:@"contact2.png"];
	tabItem.customHighlightedImage= [UIImage  imageNamed:@"contact2.png"];
	navCont.tabBarItem=tabItem;
	[tabItem release]; tabItem=nil;
	[arrNavObj addObject:navCont];
	navCont = nil;
	newsObj = nil;
	
	UITabBarController *guaranteeTabs = [[UITabBarController alloc] init];
	guaranteeTabs.delegate = self;
	guaranteeTabs.viewControllers = arrNavObj;
	
	//	UIImageView *imgV=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backBG.png"]] autorelease];
	//	imgV.alpha = .8;
	//	imgV.frame = tabBarController.moreNavigationController.view.frame;
	//	[tabBarController.moreNavigationController.view addSubview:imgV];
	//	[tabBarController.moreNavigationController.view sendSubviewToBack:imgV];
	//	UITableView *view = (UITableView *)alrroyaTabs.moreNavigationController.topViewController.view;
	//	view.delegate = self;
	//	[view setFrame:CGRectMake(0, 0, 320, 200)];
	//	view.alpha = .3;
	//	view.separatorColor = tblSeparatorColor; 
	//	view.backgroundColor = [UIColor clearColor];
	
//	UITableView *moreTbl = (UITableView *)guaranteeTabs.moreNavigationController.topViewController.view;
//	UITableView *newTblView = [[UIView alloc] initWithFrame:moreTbl.frame];
//	moreTbl.frame = CGRectMake(0,0, 320, 408);
//	[newTblView addSubview:moreTbl];
//	guaranteeTabs.moreNavigationController.topViewController.view = newTblView;
//	guaranteeTabs.moreNavigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	CanadaGuatanteeAppDelegate *appDelgObj = [[UIApplication sharedApplication] delegate];
	[appDelgObj.window addSubview:guaranteeTabs.view];
	appDelgObj = nil;
	
	//[self.view removeFromSuperview];
	
	[arrNavObj release];
	arrNavObj = nil;
	guaranteeTabs = nil;
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {}

- (void)dealloc {
    [super dealloc];
}

@end
