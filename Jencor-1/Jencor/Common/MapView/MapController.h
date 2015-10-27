//
//  MapController.h
//  Jencor
//
//  Created by Ved Prakash on 02/12/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>

#import "MKMapView+ZoomLevel.h"

#import "ASIHTTPRequest.h"
#import "JsonCommon.h"

@interface MapController : UIViewController<MKMapViewDelegate,ASIHTTPRequestDelegate> {
    NSString *address;
    MKMapView *map;
    
    JsonCommon *jsonParser;
    
    JencorAppDelegate *appDelegate;
    
    float curLat;
    float curLng;

}

@property (nonatomic, retain) IBOutlet MKMapView *map;

@property(nonatomic,retain)NSString *address;
@end
