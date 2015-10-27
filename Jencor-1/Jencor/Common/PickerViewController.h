//
//  PickerViewController.h
//  Jencor
//
//  Created by Teknowledge Software on 11/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickForm.h"
#import "CalcForm.h"

@interface PickerData : NSObject{
    NSString *name;
    NSString *value;
}

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *value;
@end

@interface PickerViewController : UIViewController {
    
    UIPickerView *picker;
    UIButton *btnDone;
    UIButton *btnCancel;
    
    
    NSString *column;
    NSString *selectedValue;
    
    UIViewController *parent;
    
    NSMutableArray *data;
    
   
    NSMutableArray *parentData;
 
    
    PickerViewController *selfRef;
  
    NSString *type;
    
    QuickForm *selectedQuickForm;
    
    
    CalcForm *selectedForm;
    
    int selectedInput; //For comparison
  

}

@property (nonatomic,retain)  NSString *type;
@property (nonatomic, retain) PickerViewController *selfRef;
@property (nonatomic, retain) NSMutableArray *parentData;
@property (nonatomic, retain) UIViewController *parent;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIButton *btnDone;
@property (nonatomic, retain) IBOutlet UIButton *btnCancel;
@property (nonatomic, retain) NSString *selectedValue;
@property (nonatomic, retain) QuickForm *selectedQuickForm;
@property (nonatomic, retain) CalcForm *selectedForm;
@property (nonatomic) int selectedInput;

- (void) showModal;
- (void) hideModal;
- (void) hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
-(void)selectValueForIndex:(NSInteger)row;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
-(void)setupData;


@end
