//
//  NewsApi.m
//  Sky Financial Corp
//
//  Created by Ved Prakash on 25/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "NewsApi.h"
#import "NewsViewController.h"

@implementation NewsApi
@synthesize parent;

- (id)init {
    self = [super init];
    if (self) {
        appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}


-(void)requestForNews{

    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:NEWS_URL]];
    [request setDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request start];

    [appDelegate showHUDinView:parent.view andTitle:@"Please wait.."];

}

-(void)parseData:(NSData *)data{

    BOOL success;
	
	NSString  *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	NSData *xmlData=[aStr dataUsingEncoding:NSUTF8StringEncoding];
	
	xmlParser= [[NSXMLParser alloc] initWithData:xmlData];
	
    [xmlParser setDelegate:self];
	
    [xmlParser setShouldResolveExternalEntities:YES];
	
    success = [xmlParser parse]; 
    
    
    if(success){
        
        NSLog(@"Data Parsed");
        
        [appDelegate killHUD];
        
        if([parent isKindOfClass:[NewsViewController class]]){
        
            NewsViewController *controller=(NewsViewController *)parent;
            
            controller.tblData=[[NSMutableArray alloc] initWithArray:refArray];
            
            [refArray removeAllObjects];
            
            refArray=nil;
            
            [controller.tbl setHidden:NO];
            [controller.tbl reloadData];
            
            [Utility fadeView:controller.tbl];        
        
        }
        
    }


}

-(void)requestFinished:(ASIHTTPRequest *)request{

    if([[request responseData] length]>0){
        refArray=[[NSMutableArray alloc] init];
        [self parseData:[request responseData]];
    }

}


-(void)requestFailed:(ASIHTTPRequest *)request{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"There was an error in network, please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];

}




#pragma mark ---
#pragma mark XMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	strCurElement=elementName;
	[strCurElement retain];
	
	
        
    if([strCurElement isEqualToString:@"item"] && !isItem){
        news=[[News alloc] init];
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
		
        
        if(isItem && news){
            
            if([strCurElement isEqualToString:@"title"]){
                [news setTitle:currentElementValue];
            }else if([strCurElement isEqualToString:@"link"]){
                [news setLink:currentElementValue];
            }else if([strCurElement isEqualToString:@"pubDate"]){
                [news setDate:currentElementValue];
            }else if([strCurElement isEqualToString:@"description"]){
                [news setDesc:currentElementValue];
            }else if([strCurElement isEqualToString:@"content:encoded"]){
                [news setContent:currentElementValue];
            }else if([strCurElement isEqualToString:@"category"]){
                [news setCategory:currentElementValue];
            }            
            
        }
        
		
		
	}
	
	//NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
    
    // NSLog(@"Element Ended :%@",elementName);
    
	if([elementName isEqualToString:@"error"])
		return;
	
    if([elementName isEqualToString:@"item"] && news){
      
        [refArray addObject:news];
        news=nil;
        isItem=NO;
    }
    
	[currentElementValue release];
	currentElementValue = nil;
}


@end
