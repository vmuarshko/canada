//
//  ImageDownloader.h
//  Sky Financial Corp
//
//  Created by Teknowledge Software on 19/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"



@interface ImageDownloader : NSObject<ASIHTTPRequestDelegate> {
    UIImageView *image;
    id obj;
}
@property(nonatomic,retain)UIImageView *image;
@property(nonatomic,retain)id obj;

-(void)downloadImageWithUrl:(NSString *)url;
@end
