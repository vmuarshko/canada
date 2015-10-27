//
//  CalcUICell.h
//  Jencor
//
//  Created by Teknowledge Software on 24/02/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalcUICell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblValue;

@property (retain, nonatomic) IBOutlet UIImageView *bgImage;

@property (retain, nonatomic) IBOutlet UITextField *txtInput;


@property (retain, nonatomic) IBOutlet UITextField *txtInput1;

@property (retain, nonatomic) IBOutlet UITextField *txtInput2;

@property (retain, nonatomic) IBOutlet UILabel *lblResult1;

@property (retain, nonatomic) IBOutlet UILabel *lblResult2;
@property (retain, nonatomic) IBOutlet UISegmentedControl *toggler;

@end
