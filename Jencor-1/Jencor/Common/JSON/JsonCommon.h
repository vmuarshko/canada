//
//  RosterApi.m
//  Eskimos
//
//  Created by Teknowledge Software on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface JsonCommon : NSObject {
	NSMutableString *responseData;
}

@property (nonatomic, retain ) NSMutableString *responseData;
-(NSArray*)initJsonWithURLArray:(NSURL *)URL;
-(NSDictionary*)initJsonWithURLDict:(NSString *)URL;
- (NSString *)stringWithUrl:(NSURL *)url;
-(NSDictionary*)initJsonWithString:(NSString *)data;
- (NSString *)stringWithData:(NSString *)str;
-(id)initJsonWithURL:(NSString *)URL;
-(id)initWithString:(NSString *)data;
-(id)initJsonWithJsonData:(NSData *)JSON;
-(NSString *)stringFromData:(NSData *)data;
@end
