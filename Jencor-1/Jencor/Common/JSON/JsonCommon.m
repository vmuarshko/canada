//
//  JsonCommon.m
//  Sky Financial Corp
//
//  Created by Teknowledge Software on 03/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "JsonCommon.h"
#import "NSString+HTML.h"

@implementation JsonCommon
@synthesize responseData;
-(NSArray*)initJsonWithURLArray:(NSURL *)URL {
	//[super viewDidLoad];
	NSURL *jsonURL = URL; 
	//[NSURL URLWithString:JSON_URL_1];
	responseData = [[NSMutableString alloc] initWithContentsOfURL:jsonURL];
	SBJSON *json = [[SBJSON new] autorelease];
	NSArray *statuses = [json objectWithString:responseData error:nil];
	return statuses;
}

-(NSDictionary*)initJsonWithURLDict:(NSString *)URL {
	NSURL *jsonURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@", URL]];
	SBJSON *json = [[SBJSON new] autorelease];
	NSString *jsonString = [self stringWithUrl:jsonURL];
	id statuses = [json objectWithString:jsonString error:nil];
	NSDictionary *feed=(NSDictionary *)statuses;
	return feed;
}

-(id)initJsonWithJsonData:(NSData *)JSON{
	NSString *jsonString = [self stringFromData:JSON];	
	SBJSON *json = [[SBJSON new] autorelease];
	id statuses = [json objectWithString:jsonString error:nil];
	return statuses;
}

-(NSString *)stringFromData:(NSData *)data{

	if ( [data bytes] )
	{
		NSString *jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		
		if(jsonResponse == nil)
			jsonResponse=[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
		
		if(jsonResponse == nil)
			jsonResponse=[[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
		
		//jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
		//jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
		/*jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"<br>" withString:@" "];*/
		
		jsonResponse = [jsonResponse stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		return jsonResponse;
	}
	
	return @"";

}



-(id)initJsonWithURL:(NSString *)URL {
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	NSURL *jsonURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@", URL]];
	SBJSON *json = [[SBJSON new] autorelease];
	NSString *jsonString = [self stringWithUrl:jsonURL];
	id statuses = [json objectWithString:jsonString error:nil];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	return statuses;
}

-(id)initWithString:(NSString *)data{

	SBJSON *json = [[SBJSON new] autorelease];
	id statuses = [json objectWithString:data error:nil];
	return statuses;

}

-(NSDictionary*)initJsonWithString:(NSString *)data { // Depricated
	
	SBJSON *json = [[SBJSON new] autorelease];
	NSString *jsonString = [self stringWithData:data];
	id statuses = [json objectWithString:jsonString error:nil];
	NSDictionary *feed=(NSDictionary *)statuses;
	return feed;
}

- (NSString *)stringWithData:(NSString *)str { // Depricated
	
	NSString *jsonResponse = str;
	jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"\t" withString:@""];
		
	return jsonResponse;
	
}

- (NSString *)stringWithUrl:(NSURL *)url {
	
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
												cachePolicy:NSURLRequestReturnCacheDataElseLoad
											timeoutInterval:30];
	// Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest
									returningResponse:&response
												error:&error];
	
 	// Construct a String around the Data from the response
	if ( [urlData bytes] )
	{
		NSString *jsonResponse = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
		
		if(jsonResponse == nil)
			jsonResponse=[[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
		
		if(jsonResponse == nil)
			jsonResponse=[[NSString alloc] initWithData:urlData encoding:NSISOLatin1StringEncoding];
		
		jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
		jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
		jsonResponse = [jsonResponse stringByReplacingOccurrencesOfString:@"<br>" withString:@" "];
		
		return jsonResponse;
	}
	else
	{
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Network Error!!", nil) message:@"There was a network error." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil,nil];
		[alert show];
		NSLog(@"Error is \n %@", error);
		return @"NO Network";
	}
}




@end
