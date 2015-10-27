//
//  News.h
//  Sky Financial Corp
//
//  Created by Ved Prakash on 25/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface News : NSObject {
    NSString *title;
    NSString *link;
    NSString *category;
    NSString *desc;
    NSString *content;
    NSString *date;
}

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *link;
@property(nonatomic,retain) NSString *category;
@property(nonatomic,retain) NSString *desc;
@property(nonatomic,retain) NSString *content;
@property(nonatomic,retain) NSString *date;

@end
