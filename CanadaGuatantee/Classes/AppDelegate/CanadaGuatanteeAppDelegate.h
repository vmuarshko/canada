//
//  CanadaGuatanteeAppDelegate.h
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CanadaGuatanteeViewController,MBProgressHUD;

@interface CanadaGuatanteeAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	CanadaGuatanteeViewController *viewController;
	MBProgressHUD *HUD;
}
@property(nonatomic,retain)MBProgressHUD *HUD;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CanadaGuatanteeViewController *viewController;

-(void)setLangDic;

@end

