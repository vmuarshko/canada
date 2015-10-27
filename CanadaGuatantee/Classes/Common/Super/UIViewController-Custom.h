//
//  UIViewController-Json.h
//  
//
//  Created by Rajesh Tamada on 23/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIViewController (Json_MBProgressHUD)

-(void)showHUD:(NSString*)text;
-(void)killHUD;


-(void)showAlert:(NSString*)title :(NSString*)msg;

-(void)showSettings;

-(NSString*)getString:(NSString*)str;

- (BOOL)validateNo:(NSString *)no;
@end
