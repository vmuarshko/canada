//
//  CustomUITabBarItem.m
//  Peexblog
//
//  Created by Rajesh Tamada on 30/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomUITabBarItem.h"


@implementation CustomUITabBarItem

@synthesize customHighlightedImage;

- (void) dealloc{
	
	if ( customHighlightedImage )
		[customHighlightedImage release]; 
	customHighlightedImage=nil;
	[super dealloc];
}

-(UIImage *) selectedImage
{
	return self.customHighlightedImage;
}

//-(UIImage *) unselectedImage
//{
//	return self.customHighlightedImage;
//}

@end

/*
Then in the init of each one of the viewControllers that corresponds to a tab, you setup the tabBarItem

// Customized Tab Bar Item

CustomUITabBarItem *tabItem = [[CustomUITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"home.png"] tag:0];
tabItem.customHighlightedImage=[UIImage imageNamed:@"Home-sel.png"];
self.tabBarItem=tabItem;
[tabItem release]; tabItem=nil;
*/