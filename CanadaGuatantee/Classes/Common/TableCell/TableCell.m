//
//  TableCell.m
//  Alrroya
//
//  Created by root1 on 18/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableCell.h"


@implementation TableCell

@synthesize textField, textView;
@synthesize lblTitle, lblDesc;
@synthesize imgThumb, imgTag;
@synthesize indImg;
//@synthesize cellSwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
	
	NSLog(@"TableCell Customecell dealloc called");
	if(textField){
//		[textField release];
		textField = nil;
	}
		
	if(textView){
//		[textView release];
		textView = nil;
	}
	
	if(lblTitle){
//		[lblTitle release];
		lblTitle = nil;
	}
	if(lblDesc){
//		[lblDesc release];
		lblDesc = nil;
	}
	
	if(imgThumb){
//		[imgThumb release];
		imgThumb = nil;
	}
	if(imgTag){
//		[imgTag release];
		imgTag = nil;
	}
	if(indImg){
//		[indImg release];
		indImg = nil;
	}
	
}


@end
