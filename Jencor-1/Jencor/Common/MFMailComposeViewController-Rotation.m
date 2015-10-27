//
//  MFMailComposeViewController-Rotation.m
//  Sky Financial Corp
//
//  Created by Teknowledge Software on 19/10/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "MFMailComposeViewController-Rotation.h"


@implementation MFMailComposeViewController(Rotation)
// stop auto rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // should support all interface orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
