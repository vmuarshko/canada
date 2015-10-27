//
//  GlossaryCell.m
//  Jencor
//
//  Created by Kaberi on 13/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "GlossaryCell.h"

@implementation GlossaryCell
@synthesize lblTitle;
@synthesize lblDesc;

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
    [lblDesc release];
    [super dealloc];
}
@end
