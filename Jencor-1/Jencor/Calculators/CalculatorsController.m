//
//  CalculatorsController.m
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorsController.h"
#import "CalculatorUIController.h"


@implementation CalculatorsController

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
    [self addCommonHeaderForView:@"Calculators" modal:NO showBackButton:NO showEmailButton:NO];
         //[header.emailButton addTarget:self action:@selector(emailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (IBAction)menuAction:(id)sender {
    CalculatorUIController *uiController=[[CalculatorUIController alloc] initWithNibName:@"CalculatorUIController" bundle:nil];
    uiController.type=((UIButton *)sender).tag;
    [self.navigationController pushViewController:uiController animated:YES];
}
@end
