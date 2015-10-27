//
//  ImageDownloader.m
//  Sky Financial Corp
//
//  Created by Teknowledge Software on 19/08/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import "ImageDownloader.h"


@implementation ImageDownloader

@synthesize image,obj;

-(void)downloadImageWithUrl:(NSString *)url{
    image.image=nil;
    //NSLog(@"Image Url:%@",url);
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request start];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    UIImage *img=[UIImage imageWithData:[request responseData]];
    image.image=img;
    
   
}

-(void)requestFailed:(ASIHTTPRequest *)request{

    NSLog(@"Error downloading image");
    
}



@end
