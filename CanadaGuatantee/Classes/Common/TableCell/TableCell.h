//
//  TableCell.h
//  Alrroya
//
//  Created by root1 on 18/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableCell : UITableViewCell {
	
//	IBOutlet UISwitch *cellSwitch;

	IBOutlet UITextField *textField;
	IBOutlet UITextView *textView;
	
	IBOutlet UILabel *lblTitle;
	IBOutlet UILabel *lblDesc;

	IBOutlet UIImageView *imgThumb;
	IBOutlet UIImageView *imgTag;

	IBOutlet UIActivityIndicatorView *indImg;
}

//@property(nonatomic,retain) UISwitch *cellSwitch;

@property(nonatomic,retain) UITextField *textField;
@property(nonatomic,retain) UITextView *textView;

@property(nonatomic,retain) UILabel *lblTitle;
@property(nonatomic,retain) UILabel *lblDesc;

@property(nonatomic,retain)UIImageView *imgThumb;
@property(nonatomic,retain)UIImageView *imgTag;

@property(nonatomic,retain)UIActivityIndicatorView *indImg;

@end
