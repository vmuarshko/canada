//
//  JencorAppDelegate.h
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <TapkuLibrary/TapkuLibrary.h>
#import "CustomProgress.h"
@interface JencorAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIView *_viewSplash;
    UIActivityIndicatorView *_activity;
    UIView *_viewButtons;
    UIView *_viewSlider;
    
    //TKLoadingView *loading;
    
    CustomProgress *progress;
    
    NSMutableArray *tempView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) TKLoadingView *loading;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UIView *viewSplash;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

-(void)addIndicator;
-(void)toggleButtonImages:(UIButton *)currentBtn;
-(void)popToRootForViewIndex:(int)index;
@property (nonatomic, retain) IBOutlet UIView *viewButtons;
@property (nonatomic, retain) IBOutlet UIView *viewSlider;
- (IBAction)tabButtonAction:(id)sender;
-(void)selectFirstTab;
-(void)showHUDinView:(UIView *)view andTitle:(NSString *)title;
-(void)killHUD;
@property (retain, nonatomic) IBOutlet UIProgressView *progressView;
-(BOOL)isIphone5;
@end
