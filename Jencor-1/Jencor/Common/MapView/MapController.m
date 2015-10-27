//
//  MapController.m
//  Jencor
//
//  Created by Ved Prakash on 02/12/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "MapController.h"
#import "Annotation.h"

@implementation MapController
@synthesize map;
@synthesize  address;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [map release];
    [address release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addCommonHeaderForView:@"Contact" modal:NO showBackButton:YES showEmailButton:NO];
    
     appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
        

    [appDelegate showHUDinView:self.view andTitle:@"Please wait"];
    
    [self performSelector:@selector(getCoordinates) withObject:nil afterDelay:.5];
}

-(void)getCoordinates{
    
    NSString *url=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",address];    
    
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];  
    [request setDelegate:self];
    
    [request start];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request{

    jsonParser=[[JsonCommon alloc] initJsonWithJsonData:[request responseData]];
    if(jsonParser){
        
        NSMutableArray *results=[(NSDictionary *)jsonParser objectForKey:@"results"];
        if([results count]>0){
            NSDictionary *jsonData=[results objectAtIndex:0];
            
            NSDictionary *location=[[jsonData objectForKey:@"geometry"] objectForKey:@"location"];
            
            curLat=[[location objectForKey:@"lat"] floatValue];
            curLng=[[location objectForKey:@"lng"] floatValue];
            
            
        }
        
    }
    
    CLLocationCoordinate2D coord;
    coord.latitude=curLat;
    coord.longitude=curLng;
    
    Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
    anno.mTitle=address;
    [map addAnnotation:anno];
    
    [map setCenterCoordinate:anno.coordinate zoomLevel:12 animated:YES];
    
    [Utility fadeView:map];
    
    [appDelegate killHUD];

}

-(void)requestFailed:(ASIHTTPRequest *)request{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"There was an error showing map, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    //[[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was an error showing map, please try again!"];

}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    static NSString *AnnotationIdentifier=@"Contact";
    
    
    MKPinAnnotationView *annotationView=(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if(annotationView == nil){
        annotationView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        annotationView.enabled = YES;
        annotationView.centerOffset = CGPointMake(7,-15);
        annotationView.calloutOffset = CGPointMake(-5, 5);
        [annotationView setCanShowCallout:YES];
        annotationView.animatesDrop=YES;            
        
    }
    
    return annotationView;



}

- (void)viewDidUnload
{
    [self setMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
