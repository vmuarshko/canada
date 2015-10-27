//
//  RatesCell.m
//  Jencor
//
//  Created by Teknowledge Software on 21/02/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "RatesCell.h"

@implementation RatesCell
@synthesize lblRate;
@synthesize lblDetails;
@synthesize lblType;

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
    [lblRate release];
    [lblDetails release];
    [lblType release];
    [super dealloc];
}
@end
