//
//  RatesApi.m
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "RatesApi.h"
#import "HomeViewController.h"
#import "CalculatorUIController.h"

@implementation RatesApi
@synthesize parent,toGetRate;

- (void)dealloc {
    [parent release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(void)makeRequest{

    NSString *url=RATES_WS_URL;
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setDelegate:self];
    
    NSMutableDictionary *headers=[[NSMutableDictionary alloc] init];
    
    [headers setValue:@"www.itoolpro.com" forKey:@"Host"];
    [headers setValue:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    
    [request setRequestHeaders:headers];
    
    [request setPostValue:AGENT_ID forKey:@"agentID"];
    
    [request start];
    
    isRequesting=TRUE;
    
    //[appDelegate showHUDinView:parent.view andTitle:NSLocalizedString(@"Please wait..", nil)];
    
}


-(void)requestFinished:(ASIHTTPRequest *)request{
    
    [appDelegate killHUD];

    if([[request responseData] length]>0 && isRequesting){
        refArray=[[NSMutableArray alloc] init];
        [self parseData:[request responseData]];
    
    }
    
}


-(void)requestFailed:(ASIHTTPRequest *)request{
    
    
    [appDelegate killHUD];
    
    if(toGetRate){
        Rate *falseRate=[[Rate alloc] init];
        [falseRate setOurRate:@"4.25"];
        CalculatorUIController *controller=(CalculatorUIController *)parent;
        [controller setupViewWithRate:falseRate];
        
    
    }else{
    
        NSLog(@"Error %@",[[request error] localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"There was a network error, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        //[[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was a network error, please try again!"];
        
    }
}


-(void)parseData:(NSData *)data{
    
    BOOL success;
	
	NSString  *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	NSData *xmlData=[aStr dataUsingEncoding:NSUTF8StringEncoding];
	
	xmlParser= [[NSXMLParser alloc] initWithData:xmlData];
	
    [xmlParser setDelegate:self];
	
    [xmlParser setShouldResolveExternalEntities:YES];
	
    success = [xmlParser parse]; 
    
    
    //if(success){
        
        NSLog(@"Data Parsed");
        
        [appDelegate killHUD];
        
        if([parent isKindOfClass:[HomeViewController class]] && !toGetRate){
            
            HomeViewController *controller=(HomeViewController *)parent;
            
            if(!controller.tblData)
                controller.tblData=[[NSMutableArray alloc] initWithArray:refArray];
            else{
                [controller.tblData removeAllObjects];
                
                for(Rate *obj in refArray)
                    [controller.tblData addObject:obj];                
            }
            
            [refArray removeAllObjects];
            
            refArray=nil;
            
//            [controller.tbl setHidden:NO];
//            [controller.tbl reloadData];
//            
//            [Utility fadeView:controller.tbl];        
            
        }else if(toGetRate){
            
            Rate *rateFor5Year=nil;
            
            for(Rate *obj in refArray){
                NSArray *comps=[obj.mortType componentsSeparatedByString:@" "];
                int year=[[comps objectAtIndex:0] intValue];
                
                if(year == 5){
                    rateFor5Year=obj;
                    break;
                }
            }
        
            CalculatorUIController *controller=(CalculatorUIController *)parent;
            [controller setupViewWithRate:rateFor5Year];
            
        
        }
        
    /*}else{
        NSLog(@"XML Error :%@",[[xmlParser parserError]  localizedDescription]);
        [appDelegate killHUD];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was some error, please try again!"];
    }*/
    
    
}


#pragma mark ---
#pragma mark XMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	strCurElement=elementName;
	[strCurElement retain];
	
	
    
    if([strCurElement isEqualToString:@"Rate"] && !isItem){
        rate=[[Rate alloc] init];
        isItem=YES;
    }
    
    
    
	
	//NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
	string=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	//string=[string stringByConvertingHTMLToPlainText];
	
	if(!currentElementValue) {
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	}else{
		[currentElementValue appendString:string];
		
        
        if(isItem && rate){
            
            if([strCurElement isEqualToString:@"mortType"]){
                [rate setMortType:currentElementValue];
            }else if([strCurElement isEqualToString:@"ourRate"]){
                [rate setOurRate:currentElementValue];
            }else if([strCurElement isEqualToString:@"date_changed"]){
                [rate setDate_changed:currentElementValue];
            }else if([strCurElement isEqualToString:@"mort_type"]){     
                [rate setMort_type:currentElementValue];
            }
            
            
            
        }
        
		
		
	}
	
	//NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
    
    // NSLog(@"Element Ended :%@",elementName);
    
	if([elementName isEqualToString:@"error"])
		return;
	
    if([elementName isEqualToString:@"Rate"] && rate){
        
        [refArray addObject:rate];
        rate=nil;
        isItem=NO;
    }
    
	[currentElementValue release];
	currentElementValue = nil;
}
@end
