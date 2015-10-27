//
//  NewsCell.m
//  Jencor
//
//  Created by Teknowledge Software on 21/02/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize lblTitle;
@synthesize arrow;

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
    [arrow release];
    [super dealloc];
}
@end
