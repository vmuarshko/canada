//
//  JGlobal.m
//  Jencor
//
//  Created by Teknowledge Software on 20/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JGlobal.h"

@implementation JGlobal
+ (NSString*) fullBundlePath:(NSString*)bundlePath{
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundlePath];
}

+(UIColor*) colorWithR:(int) r G:(int) g B:(int) b {
	return [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f];
}
@end
