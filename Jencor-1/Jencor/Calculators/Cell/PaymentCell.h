//
//  PaymentCell.h
//  Jencor
//
//  Created by Teknowledge Software on 03/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lblIndex;
@property (retain, nonatomic) IBOutlet UILabel *lblBalance;
@property (retain, nonatomic) IBOutlet UILabel *lblPrinciple;
@property (retain, nonatomic) IBOutlet UILabel *lblInterest;

@end
