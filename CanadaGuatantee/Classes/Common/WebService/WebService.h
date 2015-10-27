//
//  WebService.h
//  Utilibill
//
//  Created by root1 on 14/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebService : NSObject <NSXMLParserDelegate> {

	NSMutableDictionary *tempDic;
	NSMutableString *strVal;
}

-(id)init;

-(NSDictionary*)sendSignupRequest:(NSArray*)arrItems;

@end
