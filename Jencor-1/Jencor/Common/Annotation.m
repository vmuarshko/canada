//
//  Annotation.m
//  jLife
//
//  Created by Teknowledge Software on 03/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

//Map view Annotation Class

#import "Annotation.h"


@implementation Annotation
@synthesize mTitle, mSubTitle, mColor, coordinate,mObject;

- (NSString *)subtitle{
	return mSubTitle;
}
- (NSString *)title{
	return mTitle;
}

- (NSUInteger)mColor{
	return mColor;
}

- (id)mObject{
	return mObject;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}

@end
