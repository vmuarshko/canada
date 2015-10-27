//
//  UIViewController-Json.m
//  
//
//  Created by Rajesh Tamada on 23/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIViewController-Custom.h"
#import "MBProgressHUD.h"
#import "CanadaGuatanteeAppDelegate.h"
#import "PickerView.h"

@implementation UIViewController (Json_MBProgressHUD)

-(void)showAlert:(NSString*)title :(NSString*)msg{
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
	[alert show]; 
}

#pragma mark ProgressHUD Functions
-(void)showHUD:(NSString*)text{
	
	//NSLog(@"Show HUD Enter");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	CanadaGuatanteeAppDelegate *appDelgObj = [[UIApplication sharedApplication] delegate];
	if (! appDelgObj.HUD ){
		appDelgObj.HUD = [[MBProgressHUD alloc] initWithWindow:appDelgObj.window] ;
		[appDelgObj.window addSubview:appDelgObj.HUD];	
		appDelgObj.HUD.labelText = [self getString:@"Please Wait..."];//NSLocalizedString(@"Loading...",@"");
		appDelgObj.HUD.detailsLabelText = text;//NSLocalizedString(@"Please Wait",@"");
		[appDelgObj.HUD show:YES];
	}
	else
		NSLog(@"HUD already exists");
	//NSLog(@"Show HUD Finish");
}

- (void) killHUD{
	//NSLog(@"Kill HUD Enter");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	CanadaGuatanteeAppDelegate *appDelgObj = [[UIApplication sharedApplication] delegate];
	if ( appDelgObj.HUD ){
		[appDelgObj.HUD hide:YES];
		[appDelgObj.HUD release];
		appDelgObj.HUD = nil;
	}
	//NSLog(@"Kill HUD Finish");
}

-(void)showSettings{
	
	PickerView *picker=[[PickerView alloc] initWithNibName:@"PickerView" bundle:nil];
	[picker showPicker:[NSArray arrayWithObjects:@"English",@"Français",nil] :@"language" :nil];

}

-(NSString*)getString:(NSString*)str{
	
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"language"] == 0){
		return str;
	}else {
		NSDictionary *myLangDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"langDic"];
		return [myLangDic objectForKey:str];
	}
}


- (BOOL)validateNo:(NSString *)no{
	
	NSString *emailRegex = @"[0-9.]*"; 
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	return [emailTest evaluateWithObject:no];
	
}


@end
