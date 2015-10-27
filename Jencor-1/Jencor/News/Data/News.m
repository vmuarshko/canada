//
//  News.m
//  Sky Financial Corp
//
//  Created by Ved Prakash on 25/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "News.h"


@implementation News
@synthesize category,date,desc,link,title,content;

- (void)dealloc {
    [category release];
    [date release];
    [desc release];
    [link release];
    [title release];
    [content release];
    [super dealloc];
}

@end
