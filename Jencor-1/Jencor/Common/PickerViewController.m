//
//  PickerViewController.m
//  Jencor
//
//  Created by Teknowledge Software on 11/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "PickerViewController.h"
#import "ApplyController.h"
#import "CalculatorUIController.h"

@implementation PickerData

@synthesize name,value;

- (void)dealloc {
    [name release];
    [value release];
    [super dealloc];
}

@end

@implementation PickerViewController
@synthesize btnDone;
@synthesize btnCancel;
@synthesize picker;
@synthesize parent,selectedValue;
@synthesize parentData,selfRef,type;
@synthesize selectedQuickForm,selectedForm,selectedInput;

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
    [picker release];
    [btnDone release];
    [btnCancel release];
    [selectedValue release];
    [selfRef release];
    [type release];
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
}


#pragma mark MODAL Methods

- (void) showModal{
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideModal) name:@"HIDE_MODAL" object:nil];
	
	UIView* modalView=self.view;
	
	modalView.frame=CGRectOffset(modalView.frame, 0, 220);
	
	UIWindow* mainWindow = (((JencorAppDelegate*) [UIApplication sharedApplication].delegate).window);
	CGPoint middleCenter = modalView.center;   
	CGSize offSize = [UIScreen mainScreen].bounds.size;   
	CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);   
	modalView.center = offScreenCenter;
    
	// we start off-screen   
	[mainWindow addSubview:modalView];    
	// Show it with a transition effect     
	[UIView beginAnimations:nil context:nil];   
	[UIView setAnimationDuration:0.4]; // animation duration in seconds   
	modalView.center = middleCenter;
	[UIView commitAnimations]; 
    self.picker.backgroundColor = [UIColor whiteColor];
    [self setupData];//Setup Data 
    
    
}

- (void)hideModal{   
    
    
	UIView* modalView=self.view; 
	CGSize offSize = [UIScreen mainScreen].bounds.size;
	CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
	[UIView beginAnimations:nil context:modalView];
	[UIView setAnimationDuration:0.7];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(hideModalEnded:finished:context:)];
	modalView.center = offScreenCenter;
	[UIView commitAnimations];
	
}

- (void)hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIView* modalView = (UIView *)context;
	[modalView removeFromSuperview];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"HIDE_MODAL" object:nil];
	
}


#pragma mark ---
#pragma mark SETUP DATA

-(void)setupData{
    
    [btnDone setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    
    [btnCancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    
    
    data=[NSMutableArray new];
    
    NSString *values=@"";
    
    
    
    if([type isEqualToString:@"annualIncrease"]){
        values=@"0%#0,1%#1,2%#2,3%#3,4%#4,5%#5,6%#6";
    
    }else if([type isEqualToString:@"years"]){
        for(int i=1;i<11;i++){
            values=[values stringByAppendingFormat:@"%d %@#%d,",i,i==1?@"year":@"years",i];
        }
        values=[values substringWithRange:NSMakeRange(0, [values length] - 1)];
    
    }else if([type isEqualToString:@"term"]){
        for(int i=1;i<36;i++){
            values=[values stringByAppendingFormat:@"%d %@#%d,",i,i==1?@"year":@"years",i];
        }
        values=[values substringWithRange:NSMakeRange(0, [values length] - 1)];
        
    }else if([type isEqualToString:@"amort"]){
        for(int i=5;i<40;i=i+5){
            values=[values stringByAppendingFormat:@"%d %@#%d,",i,i==1?@"year":@"years",i];
        }
        values=[values substringWithRange:NSMakeRange(0, [values length] - 1)];
        
    }else if([type isEqualToString:@"purpose"]){
        values=@"Purchase#Purchase,Refinance#Refinance,Renewal#Renewal,HELOC#HELOC";
    }else if([type isEqualToString:@"payfrequency"]){
        values=@"Monthly#Monthly,Semi-Monthly#Semi-Monthly,Bi-Weekly#Bi-Weekly,Accelerated Bi-Weekly#Accelerated Bi-Weekly,Weekly#Weekly,Accelerated Weekly#Accelerated Weekly";
    }
    
    
    
    
    
    
    if([values length]==0)return;
    
    
    
    for(NSString *str in [values componentsSeparatedByString:@","]){
        
        NSArray *arr=[str componentsSeparatedByString:@"#"];
        
        PickerData *obj=[[PickerData alloc] init];
        
        [obj setName:[arr objectAtIndex:0]];
        [obj setValue:[arr objectAtIndex:1]];
    
        
        [data addObject:obj];
    }
    
    
    
    if([selectedValue length]>0){
        for(int i=0;i<[data count];i++){
            
            PickerData *obj=[data objectAtIndex:i];
            
            NSArray *arr=[selectedValue componentsSeparatedByString:@"#"];
            NSString *val;
            if([arr count] == 1)
                val=[arr objectAtIndex:0];
            else
                val=[arr objectAtIndex:1];
            if([obj.value isEqualToString:val]){
                [picker selectRow:i inComponent:0 animated:YES];
                break;
            }
            
        }
    }
    [picker reloadComponent:0];

    

}


#pragma mark ===================




#pragma mark PickerView Delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    return [data count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    PickerData *obj=[data objectAtIndex:row];
    
    return obj.name;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self selectValueForIndex:row];
    
}

-(void)selectValueForIndex:(NSInteger)row{

    
    PickerData *obj=[data objectAtIndex:row];
    
    if([parent isKindOfClass:[ApplyController class]]){
        selectedQuickForm.fieldValue=[NSString stringWithFormat:@"%@#%@",obj.name,obj.value];
        ApplyController *controller=(ApplyController *)parent;
        [controller.tbl reloadData];
        [controller hideModal];
    
    }else if([parent isKindOfClass:[CalculatorUIController class]]){        
        
        CalculatorUIController *controller=(CalculatorUIController *)parent;
        
        if(controller.type == 2){ //Comparison
            NSString *val=selectedForm.fieldValue;
            NSArray *arr=[val componentsSeparatedByString:@"="];
            
            if(selectedInput == 1)
                val=[NSString stringWithFormat:@"%@=%@",obj.value,[arr objectAtIndex:1]];
            else if(selectedInput == 2)
                val=[NSString stringWithFormat:@"%@=%@",[arr objectAtIndex:0],obj.value];
            
            selectedForm.fieldValue=val;
        }else
            selectedForm.fieldValue=obj.value;
        
        [controller.tbl reloadData];
        [controller hideModal];
    
    }
    
    /*if([parent isKindOfClass:[MortgageController class]]){
        selectedForm.fieldValue=[NSString stringWithFormat:@"%@#%@",obj.name,obj.value];
        MortgageController *controller=(MortgageController *)parent;
        [controller.tbl reloadData];
        [controller hideModal];
    }else if([parent isKindOfClass:[QuickAppController class]]){
        selectedQuickForm.fieldValue=[NSString stringWithFormat:@"%@#%@",obj.name,obj.value];
        QuickAppController *controller=(QuickAppController *)parent;
        [controller.tbl reloadData];
        [controller hideModal];
    }*/
    
    //[self hideModal];
    
    
}

- (IBAction)doneAction:(id)sender {
    
    [self selectValueForIndex:[picker selectedRowInComponent:0]];
    
}

- (IBAction)cancelAction:(id)sender {
    if([parent isKindOfClass:[ApplyController class]]){
        
        ApplyController *controller=(ApplyController *)parent;
        [controller hideModal];
        
    }else if([parent isKindOfClass:[CalculatorUIController class]]){
        CalculatorUIController *controller=(CalculatorUIController *)parent;
        [controller hideModal];
    }
    
   /* if([parent isKindOfClass:[MortgageController class]]){
        MortgageController *controller=(MortgageController *)parent;
        [controller hideModal];
    }else if([parent isKindOfClass:[QuickAppController class]]){
        QuickAppController *controller=(QuickAppController *)parent;
        [controller hideModal];
    }*/
}


- (void)viewDidUnload
{
    [self setPicker:nil];
    [self setBtnDone:nil];
    [self setBtnCancel:nil];
    [self setBtnDone:nil];
    [self setBtnCancel:nil];
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
