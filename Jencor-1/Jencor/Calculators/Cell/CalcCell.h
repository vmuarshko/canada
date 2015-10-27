//
//  CalcCell.h
//  Jencor
//
//  Created by Ved Prakash on 11/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalcCell : UITableViewCell {
    
    UILabel *lblTitle;
    UILabel *lblListValue;
    UIButton *listButton;

    UIButton *valBg;
    UITextField *textValue;
}
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblListValue;
@property (nonatomic, retain) IBOutlet UIButton *listButton;

@property (nonatomic, retain) IBOutlet UIButton *valBg;
@property (nonatomic, retain) IBOutlet UITextField *textValue;

-(void)showList;
-(void)showTextField;

@end
