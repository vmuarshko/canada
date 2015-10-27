//
//  ContactController.h
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactController : UIViewController {
    JencorAppDelegate *appDelegate;
}
- (IBAction)mapAction:(id)sender;
- (IBAction)contactAction:(id)sender;
- (IBAction)socialAction:(id)sender;

@end
