//
//  ApplyController.h
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"


@interface ApplyController : UIViewController <UIWebViewDelegate>{
    NSMutableArray *tblData;
    
    NSString *type;
    
    PickerViewController *picker;
    
    IBOutlet UIWebView *webView;
    
}




@property (retain, nonatomic) IBOutlet UITableView *tbl;
@property(nonatomic,retain) NSString *type;
-(void)getAllValues;
-(void)hideModal;
-(BOOL)validate;
- (IBAction)submitAction:(id)sender;

@end
