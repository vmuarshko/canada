//
//  WebService.m
//  Utilibill
//
//  Created by root1 on 14/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebService.h"

@implementation WebService

-(id)init{
	self = [super init];
	if (self != nil) {}
	return self;
}

#pragma mark -
#pragma mark - Service List delegate
#pragma mark -

-(NSDictionary*)sendSignupRequest:(NSArray*)arrItems{
	
	NSLog(@"Send signup details");
	NSString *strBody = @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://weblead.ws.nexa.openface.com/\">";
	strBody = [strBody stringByAppendingString:@"<soapenv:Header/><soapenv:Body>"];
	
	strBody = [strBody stringByAppendingString:@"<web:submitLead>"];
	strBody = [strBody stringByAppendingString:@"<requestSource>CanGiPhoneLead</requestSource>"];
	strBody = [strBody stringByAppendingString:@"<webLeadInformation>"];
	strBody = [strBody stringByAppendingString:@"<![CDATA["];
	
	strBody = [strBody stringByAppendingString:@"<WebLeadContact>"];
	
	
	strBody = [strBody stringByAppendingString:@"<webLeadIdentifier>16202</webLeadIdentifier>"];

	strBody = [strBody stringByAppendingFormat:@"<firstName>%@</firstName>",[arrItems objectAtIndex:0]];			//First Name
	strBody = [strBody stringByAppendingFormat:@"<lastName>%@</lastName>",[arrItems objectAtIndex:1]];		//Last Name

	strBody = [strBody stringByAppendingFormat:@"<province>%@</province>",[arrItems objectAtIndex:3]];		// Province/Territory
	
	strBody = [strBody stringByAppendingString:@"<city>N/A</city>"];
	
	strBody = [strBody stringByAppendingFormat:@"<emailAddress>%@</emailAddress>",[arrItems objectAtIndex:2]];		//Email Address
	
	strBody = [strBody stringByAppendingString:@"<phoneNumber>N/A</phoneNumber>"];
	strBody = [strBody stringByAppendingString:@"<creditProfile></creditProfile>"];
	strBody = [strBody stringByAppendingString:@"<purposeOfLoan></purposeOfLoan>"];
	strBody = [strBody stringByAppendingString:@"<purchasePrice></purchasePrice>"];
	strBody = [strBody stringByAppendingString:@"<fundRequired></fundRequired>"];
	strBody = [strBody stringByAppendingString:@"<likelyTimeToFinance></likelyTimeToFinance>"];
	strBody = [strBody stringByAppendingString:@"<bestTimeToCall></bestTimeToCall>"];
	strBody = [strBody stringByAppendingString:@"<agentFirstName>Brian</agentFirstName>"];
	strBody = [strBody stringByAppendingString:@"<agentLastName>Bell</agentLastName>"];

	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];

	strBody = [strBody stringByAppendingFormat:@"<websiteEntryDate>%@</websiteEntryDate>",dateString];		//Today's Date 		

	strBody = [strBody stringByAppendingFormat:@"<company>%@</company>",[arrItems objectAtIndex:4]];		//Company (AIG Canada Guaranty) 		

	NSString *strlang = [arrItems objectAtIndex:5];
	if([strlang isEqualToString:@"English"])
		strBody = [strBody stringByAppendingString:@"<preferredLanguage>0</preferredLanguage>"];		//Preferred Language
	else
		strBody = [strBody stringByAppendingString:@"<preferredLanguage>1</preferredLanguage>"];		//Preferred Language
	
	strBody = [strBody stringByAppendingString:@"<websiteNote1></websiteNote1>"];
	strBody = [strBody stringByAppendingString:@"<websiteNote2></websiteNote2>"];
	strBody = [strBody stringByAppendingString:@"<websiteNote3></websiteNote3>"];
	strBody = [strBody stringByAppendingString:@"<websiteNote4></websiteNote4>"];
	
	NSString *deviceType = [UIDevice currentDevice].model;
	//NSLog(@"Device Type: %@", deviceType);
	if ( [deviceType rangeOfString:@"iPod"].length >0 )
		strBody = [strBody stringByAppendingString:@"<sourceWebsite>CanGiPadLead</sourceWebsite>"];
	else if ( [deviceType rangeOfString:@"iPhone"].length >0 )
		strBody = [strBody stringByAppendingString:@"<sourceWebsite>CanGiPhoneLead</sourceWebsite>"];
	
	
	strBody = [strBody stringByAppendingString:@"</WebLeadContact>"];
	
	strBody = [strBody stringByAppendingString:@"]]>"];
	strBody = [strBody stringByAppendingString:@"</webLeadInformation>"];
	strBody = [strBody stringByAppendingString:@"</web:submitLead>"];
	strBody = [strBody stringByAppendingString:@"</soapenv:Body></soapenv:Envelope>"];
	
	//NSLog(@"Request: %@", strBody);
	
	NSString *strUrl = @"https://nexa.incontact.ca/Nexa/services/WebLeadService";
	NSLog(@"Sign up URL: %@   body:%@", strUrl, strBody);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[strBody dataUsingEncoding:NSUTF8StringEncoding]];
	[request setValue:@"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-type"];
	
	NSURLResponse* response = nil;
	NSError* error = nil;
	NSData* urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if(urlData && [urlData length]>0){

		tempDic = [[[NSMutableDictionary alloc] init] retain];
		
		NSLog(@"Response data: \n\n%@ ",  [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]);

		NSString *strResponse = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];

//		return nil;
		
		if([strResponse rangeOfString:@"10001" options:NSBackwardsSearch].location < 1000)	{	
			[tempDic setObject:@"10001" forKey:@"eventId"];
			return tempDic;
		}else {
			NSLog(@"Error");
			return nil;
		}

	/*	
		NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithData:urlData];
		[xmlParser setDelegate:self];
		[xmlParser setShouldResolveExternalEntities:YES];
		
		
		BOOL success = [xmlParser parse];
		if(success){
			NSLog(@"Customer Login Response successfully parsed");
			return tempDic;
		}
	*/ 
	}else{
		//NSLog(@"getServices Error: %@", [error description]);
		NSString *strMsg = [[error userInfo] valueForKey:@"NSLocalizedDescription"];
		NSLog(@"Network Error: %@", strMsg);
		if([strMsg isEqualToString:@"no Internet connection"])
			//[self showAlert:@"Error!" :@"Sorry! No internet connection available. Please try again."];
			if([strMsg isEqualToString:@"timed out"])
				//[self showAlert:@"Error!" :@"A server error has occurred. Please try again."];
				
				return nil;
	}
	
	return nil;
}

#pragma mark -
#pragma mark - XML Parser delegate
#pragma mark -

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString *)qName attributes: (NSDictionary *)attributeDict{
	strVal = [[[NSMutableString alloc] init]retain];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	[strVal appendString:string];
	[strVal retain];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	if([elementName isEqualToString:@"eventDescription"])
		[tempDic setObject:strVal forKey:@"eventDescription"];
	
	if([elementName isEqualToString:@"eventId"]){
		
		NSLog(@"Event Id: %@", strVal);
		
		[tempDic setObject:strVal forKey:@"eventId"];
	}
}

@end
