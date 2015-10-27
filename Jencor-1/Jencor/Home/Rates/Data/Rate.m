//
//  Rate.m
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "Rate.h"


@implementation Rate
@synthesize mortType,ourRate,date_changed,mort_type;

- (void)dealloc {
    [mortType release];
    [ourRate release];
    [date_changed release];
    [mort_type release];
    [super dealloc];
}

@end
