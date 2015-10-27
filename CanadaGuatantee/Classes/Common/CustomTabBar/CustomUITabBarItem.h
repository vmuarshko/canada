//
//  CustomUITabBarItem.h
//  Peexblog
//
//  Created by Rajesh Tamada on 30/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomUITabBarItem : UITabBarItem 
{
	UIImage  *customHighlightedImage;
}

@property (nonatomic, retain) UIImage *customHighlightedImage;

@end

