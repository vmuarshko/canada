//
//  Rate.h
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Rate : NSObject {
    NSString *mortType;
    NSString *ourRate;
    NSString *date_changed;
    NSString *mort_type;
}
@property(nonatomic,retain) NSString *mortType;
@property(nonatomic,retain) NSString *ourRate;
@property(nonatomic,retain) NSString *date_changed;
@property(nonatomic,retain) NSString *mort_type;

@end
