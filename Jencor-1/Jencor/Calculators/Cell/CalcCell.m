//
//  CalcCell.m
//  Jencor
//
//  Created by Ved Prakash on 11/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "CalcCell.h"


@implementation CalcCell
@synthesize lblTitle;
@synthesize lblListValue;
@synthesize listButton;
@synthesize valBg;
@synthesize textValue;

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

-(void)showList{
    valBg.hidden=TRUE;
    textValue.hidden=TRUE;

    listButton.hidden=FALSE;
    lblListValue.hidden=FALSE;
    

}

-(void)showTextField{

    valBg.hidden=FALSE;
    textValue.hidden=FALSE;
    

    listButton.hidden=TRUE;
    lblListValue.hidden=TRUE;

}


- (void)dealloc
{
    [lblTitle release];
    [lblListValue release];
    [listButton release];
    [valBg release];
    [textValue release];
    [super dealloc];
}

@end
