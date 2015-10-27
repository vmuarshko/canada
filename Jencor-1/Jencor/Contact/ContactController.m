//
//  ContactController.m
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ContactController.h"
#import "MapController.h"
#import "WebController.h"

@implementation ContactController

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
    [self addCommonHeaderForView:@"Contact" modal:NO showBackButton:NO showEmailButton:NO];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    appDelegate.viewButtons.hidden=FALSE;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)mapAction:(id)sender {
    MapController *controller=[[MapController alloc] initWithNibName:@"MapController" bundle:nil];
    controller.address=@"305, 1822-10th Avenue SW Calgary, Alberta - T3C 0J8, Canada";
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

- (IBAction)contactAction:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    
    NSURL *contactURL=nil;
    
    if(btn.tag == 0){//Email
        contactURL=[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",EMAIL_ID]];
    
    }else if(btn.tag == 1){//Phone
    
        contactURL=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4032453636"]];
    
    }else if(btn.tag == 2){//Mobile
    
        contactURL=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4032453636"]];
    }
    
    
    [[UIApplication sharedApplication] openURL:contactURL];
}

- (IBAction)socialAction:(id)sender {
    
    NSString *title=@"";
    NSString *url=@"";
    
    UIButton *btn=(UIButton *)sender;
    
    if(btn.tag == 0){//Linkedin
        title=@"Linkedin";
        url=LINKEDIN_URL;
    }else if(btn.tag == 1){//Facebook
        title=@"Facebook";
        url=FACEBOOK_URL;
    }else if(btn.tag == 2){//Twitter
        title=@"Twitter";
        url=TWITTER_URL;
    }else if(btn.tag == 3){//Rss
        title=@"Rss";
        url=RSS_URL;
    }
    
        
    WebController *controller=[[WebController alloc] initWithNibName:@"WebController" bundle:nil];
    controller.strLink=url;
    controller.strTitle=title;
    controller.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:controller animated:YES];
    
    appDelegate.viewButtons.hidden=TRUE;
    
}
@end
