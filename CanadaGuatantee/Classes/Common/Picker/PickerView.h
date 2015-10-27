//
//  PickerView.h
//  ModalViewController
//
//  Created by root1 on 02/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PickerView : UIViewController{
	
	UIPickerView *picker;

	UIButton *btnCancel;
	UIButton *btnDone;
	
	NSMutableArray *arrItems;
	
	UITableView *tblmain;
	
	NSString *strKeyName;
	
	NSInteger selectedIdx;
}

@property(nonatomic,retain) IBOutlet UIPickerView *picker;
@property(nonatomic,retain) IBOutlet UIButton *btnCancel;
@property(nonatomic,retain) IBOutlet UIButton *btnDone;

-(void)showPicker:(NSArray*)arr :(NSString*)key :(UITableView*)tbl;

-(void)showModal;
-(void)hideModal;

-(IBAction)cancelAct;
-(IBAction)doneAct;

@end
