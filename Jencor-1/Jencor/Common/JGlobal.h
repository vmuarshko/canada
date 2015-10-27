//
//  JGlobal.h
//  Jencor
//
//  Created by Teknowledge Software on 20/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define JBUNDLE(_URL) [JGlobal fullBundlePath:_URL]
#define JCOLOR(_R,_G,_B) [JGlobal colorWithR:_R G:_G B:_B]
@interface JGlobal : NSObject
+ (NSString*) fullBundlePath:(NSString*)bundlePath;
+(UIColor*) colorWithR:(int) r G:(int) g B:(int) b;
@end
