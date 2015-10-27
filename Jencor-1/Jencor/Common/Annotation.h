//
//  Annotation.h
//  jLife
//
//  Created by Teknowledge Software on 03/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//


#import <MapKit/MapKit.h>


@interface Annotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *mTitle;
	NSString *mSubTitle;
	NSUInteger mColor;
    id mObject;
	
}

@property(nonatomic,retain,readwrite)NSString *mTitle;
@property(nonatomic,retain,readwrite)NSString *mSubTitle;
@property(nonatomic,assign)NSUInteger mColor;
@property(nonatomic,retain,readwrite)id mObject;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@end
