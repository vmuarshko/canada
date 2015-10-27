//
//  PaymentCell.m
//  Jencor
//
//  Created by Teknowledge Software on 03/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "PaymentCell.h"

@implementation PaymentCell
@synthesize lblIndex;
@synthesize lblBalance;
@synthesize lblPrinciple;
@synthesize lblInterest;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [lblIndex release];
    [lblBalance release];
    [lblPrinciple release];
    [lblInterest release];
    [super dealloc];
}
@end
