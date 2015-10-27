//
//  CalcUICell.m
//  Jencor
//
//  Created by Teknowledge Software on 24/02/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "CalcUICell.h"

@implementation CalcUICell
@synthesize lblTitle;
@synthesize lblValue;

@synthesize bgImage;
@synthesize txtInput;
@synthesize txtInput1;
@synthesize txtInput2;
@synthesize lblResult1;
@synthesize lblResult2;
@synthesize toggler;


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
    [lblTitle release];
    [lblValue release];
    [bgImage release];
    [txtInput release];
    [txtInput1 release];
    [txtInput2 release];
    [lblResult1 release];
    [lblResult2 release];
    [toggler release];
    [super dealloc];
}
@end
