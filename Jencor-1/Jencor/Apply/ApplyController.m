//
//  ApplyController.m
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplyController.h"
#import "QuickAppApi.h"
#import "QuickForm.h"
#import "CalcCell.h"
#import "CalcForm.h"

@implementation ApplyController
@synthesize tbl,type;

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
    
    [self addCommonHeaderForView:@"Apply" modal:NO showBackButton:NO showEmailButton:NO];
    
    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *strURL = @"http://www.jencormortgage.com/jencor-contact-form/";
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    webView.delegate = self;
    
    CGRect frame = webView.frame;
    
    frame.size.height = [UIScreen mainScreen].bounds.size.height - 70;
    
    [appDelegate showHUDinView:self.view andTitle:@"Please wait"];
    //webView.scalesPageToFit = TRUE;
    
    
    // Do any additional setup after loading the view from its nib.
    //[self addCommonHeaderForView:@"Apply" modal:NO showBackButton:NO showEmailButton:NO];
    //tblData=[[[QuickForm alloc] init] getForm];
}

-(void)zoomToFit
{
    
    if ([webView respondsToSelector:@selector(scrollView)])
    {
        UIScrollView *scroll=[webView scrollView];
        
        float zoom=0.99*webView.bounds.size.width/scroll.contentSize.width;
        [scroll setZoomScale:zoom animated:YES];
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
   [self zoomToFit];
    [appDelegate killHUD];
}

#pragma mark ---
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tblData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"CalcCell";    
    
    CalcCell *cell=(CalcCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        UIViewController *controller=[[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
        cell=(CalcCell *)controller.view;
        
        cell.backgroundView=nil;        
        
        [cell.listButton addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    cell.listButton.tag=indexPath.row;
    
    CalcForm *form=[tblData objectAtIndex:indexPath.row];
    
    cell.backgroundColor=[UIColor clearColor];
    
    if([form.fieldType isEqualToString:@"Text"]){
        [cell showTextField];
        cell.textValue.text=form.fieldValue;
        cell.textValue.delegate=self;
        cell.textValue.tag=indexPath.row;
        cell.textValue.keyboardType=UIKeyboardTypeDefault;
    }else if([form.fieldType isEqualToString:@"List"]){
        [cell showList];
        
        if([form.fieldValue length]>0){
            NSArray *arr=[form.fieldValue componentsSeparatedByString:@"#"];
            
            cell.lblListValue.text=[arr objectAtIndex:0];
        }
        
        
    }else if([form.fieldType isEqualToString:@"Phone"]){
        [cell showTextField];
        cell.textValue.text=form.fieldValue;
        cell.textValue.delegate=self;
        cell.textValue.tag=indexPath.row;
        cell.textValue.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    }else if([form.fieldType isEqualToString:@"Email"]){
        [cell showTextField];
        cell.textValue.text=form.fieldValue;
        cell.textValue.delegate=self;
        cell.textValue.tag=indexPath.row;
        cell.textValue.keyboardType=UIKeyboardTypeEmailAddress;
    }
    
    
    
    cell.lblTitle.text=form.fieldLabel;
    
    return cell;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self hideModal];
    
    [self getAllValues];
        
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:tbl];
    CGPoint pt = rc.origin;
    pt.x = 0;
    pt.y = pt.y;
    [tbl setContentOffset:pt animated:YES];
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [self getAllValues];
    
    CGPoint pt;
    pt.x = 0;
    pt.y = 0;
    [tbl setContentOffset:pt animated:YES];
    
    return YES;
}

-(IBAction)openList:(id)sender{
    
    [self getAllValues];
    
    for(CalcCell *cell in [tbl visibleCells]){
        
        if([cell isKindOfClass:[CalcCell class]]){
            [cell.textValue resignFirstResponder];
        }
        
    }
    
    QuickForm *form=[tblData objectAtIndex:((UIButton *)sender).tag];
    
    if(!picker){
        
        picker=[[PickerViewController alloc] init];
        picker.parent=self;
        picker.selectedValue=form.fieldValue;
        picker.type=form.fieldName;
        picker.selectedQuickForm=form;
        [picker showModal];
        
    }else
        [picker hideModal];
    
    
}

-(void)hideModal{
    
    if(picker){
        [picker hideModal];
        picker=nil;
    }
    
}

-(BOOL)validate{
    
    BOOL validated=TRUE;
    
    int i = 0;
    for(QuickForm *form in tblData){
        NSLog(@"%@", form.fieldValue);
        if([form.fieldValue length] == 0 && i < 4){
            validated=FALSE;
            break;
        }
        i++;
        
    }
    
    if(validated){
        
        NSString *email=@"";
        
        for(QuickForm *form in tblData){
            
            if([form.fieldName isEqualToString:@"email"]){
                email=form.fieldValue;
                break;
            }
        }
        
        
        validated=[self validateEmail:email];
        
        if(!validated){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter correct email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            //[[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"Please enter correct email", nil)];
        }
        
    }
    
    
    return validated;
    
}

- (IBAction)submitAction:(id)sender {
    
    if([self validate]){
        
        NSString *dataToPost=@"";
        
        for(QuickForm *form in tblData){
            
            if([form.fieldType  isEqualToString:@"List"]){
                NSArray *arr=[form.fieldValue componentsSeparatedByString:@"#"];
                
                dataToPost=[dataToPost stringByAppendingFormat:@"%@ %@#",form.fieldLabel,[arr objectAtIndex:1]];
            }else
                dataToPost=[dataToPost stringByAppendingFormat:@"%@ %@#",form.fieldLabel,form.fieldValue];
            
        }
        
        if([dataToPost length]>0)
            dataToPost=[dataToPost substringWithRange:NSMakeRange(0, [dataToPost length] - 1)];
        
        NSLog(@"Data to post %@",dataToPost);
        
        QuickAppApi *api=[[QuickAppApi alloc] init];
        api.data=dataToPost;
        api.parent=self;
        [api makeRequest];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please fill all the values" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        //[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Please fill all the values"];
        
    }
}

-(void)getAllValues{
    
    for(CalcCell *cell in [tbl visibleCells]){
        
        if([cell isKindOfClass:[CalcCell class]]){
            if([cell.textValue.text length] > 0 ){
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:cell.textValue.tag inSection:0];
                CalcForm *form=[tblData objectAtIndex:indexPath.row];
                [form setFieldValue:cell.textValue.text];
            }
        }
        
        
    }
    
    //[tbl reloadData];
    
}


- (void)viewDidUnload
{
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
