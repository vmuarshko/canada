//
//  Utility.m
//  Sky Financial Corp
//
//  Created by Ved Prakash on 03/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "Utility.h"


@implementation Utility

+(void)fadeView:(UIView *)view{

    //Apply fade effect between view frame change or, view change
    view.alpha=0.3;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    view.alpha=1.0;
    [UIView commitAnimations];

}




@end
