//
//  JencorAppDelegate.m
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "JencorAppDelegate.h"
#import "HomeViewController.h"
#import "MRProgress.h"
#import <HockeySDK/HockeySDK.h>

@implementation JencorAppDelegate
@synthesize progressView = _progressView;

@synthesize viewButtons = _viewButtons;
@synthesize viewSlider = _viewSlider;

@synthesize viewSplash = _viewSplash;
@synthesize activity = _activity;
//@synthesize loading;

@synthesize window=_window;

@synthesize tabBarController=_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //[[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"b1d467fe3f4c82d3ca9d939f5d29b23f"];
    //[[BITHockeyManager sharedHockeyManager] startManager];
    //[[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];


    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //Set Frame of Tab Buttons
    tempView = [NSMutableArray new];

    
    [_viewButtons setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 82, [[UIScreen mainScreen] bounds].size.width, 82)];
    
	[_viewButtons setBackgroundColor:[UIColor clearColor]];
    self.window.rootViewController  =self.tabBarController;
    [self.window addSubview:_viewSplash];
    
    [self addIndicator]; 
    
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}


-(BOOL)isIphone5
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 960) {
                NSLog(@"iPhone 4 Resolution");
                return NO;
            }
            if(result.height == 1136) {
                NSLog(@"iPhone 5 Resolution");
                //[[UIScreen mainScreen] bounds].size =result;
                return YES;
            }
        }
        else{
            NSLog(@"Standard Resolution");
            return NO;
        }
    }
    return NO;
}



#pragma mark ---
#pragma mark HUD

-(void)showHUDinView:(UIView *)view andTitle:(NSString *)title{
    
    
    [tempView addObject:view];
    [MRProgressOverlayView showOverlayAddedTo:view title:title mode:MRProgressOverlayViewModeIndeterminate animated:YES];
    
    /*if(loading==nil){
		loading  = [[TKLoadingView alloc] initWithTitle:title];
		
        [view addSubview:loading];
      
        
        loading.center=view.center;
        
        CGRect frame=loading.frame;
        
        frame.origin.y=frame.origin.y + (frame.origin.y / 2) + 10.0;
        
        [loading setFrame:frame];
        
        [loading startAnimating];
        
	}*/
    
    
}

-(void)killHUD{
    
    [MRProgressOverlayView dismissAllOverlaysForView:self.window animated:YES completion:^{
    }];
    for(UIView *view in tempView)
    {
        [MRProgressOverlayView dismissAllOverlaysForView:view animated:YES completion:^{
        }];
    }
    [tempView removeAllObjects];


    /*if(loading){
        
        [loading removeFromSuperview];
        loading=nil;
        
    }*/
    
}




-(void)addIndicator{
	//Create custom animating indicator
    progress=[[CustomProgress alloc] init];
    CGRect pFrame=_progressView.frame;
    pFrame.size.height=20;
    [progress setFrame:pFrame];
    [progress setProgress:0];
    [progress setNeedsDisplay];
    [_viewSplash addSubview:progress];
	
    
    //This works above ios 5.0
	/*[_progressView setTrackImage:[UIImage imageWithContentsOfFile:JBUNDLE(@"progress_track.png")]];
    
    CGRect pFrame=_progressView.frame;
    pFrame.size.height=20;
    
    [_progressView setFrame:pFrame];
    
    UIImage *progress = [[UIImage imageNamed:@"progress.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
    [_progressView setProgressImage:progress];    
    [_progressView setProgress:0];
    [progress release];*/
    

    
    [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    
}




-(void)updateTimer:(NSTimer *)timer{
    
    //[_progressView setProgress:_progressView.progress+.02 animated:YES];
    
    progress.progress=progress.progress+.02;
    [progress setNeedsDisplay];
    
    if(progress.progress == 1.0){
    
        [timer invalidate];
    
        [self performSelector:@selector(hideSplash) withObject:nil afterDelay:.5];
    
    }

}

-(void)hideSplash{	
	
	
    //hides the splash screen after 3 seconds		
    [_viewSplash removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromTab"];
    [[NSUserDefaults standardUserDefaults] synchronize];
	
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [self.window addSubview:_viewButtons];
    [self.window bringSubviewToFront:_viewButtons];
    
    [Utility fadeView:self.tabBarController.view];
	
	
    
}


-(void)popToRootForViewIndex:(int)index{
    
	UINavigationController *nav=[[self.tabBarController viewControllers] objectAtIndex:index];
	[nav popToRootViewControllerAnimated:NO];
    
    if(index == 0){
        HomeViewController *home=nil;
        for(UIViewController *controller in [nav viewControllers]){
            
            if([controller isKindOfClass:[HomeViewController class]]){
                home=(HomeViewController *)controller;
                break;
            }
            
        }    
        
        if(home){
            [home setupView];
        }
    }
}

-(void)selectFirstTab{
    
    for (UIButton* button in _viewButtons.subviews){
        if([button isKindOfClass:[UIButton class]]){
            
            if( button.tag == 0){
                button.selected=YES;
                _viewSlider.hidden=FALSE;
                //Put a sliding effect
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                CGRect frame = CGRectMake(0, _viewSlider.frame.origin.y, button.frame.size.width, _viewSlider.frame.size.height);
                
                frame.origin.x = button.frame.origin.x;
                
                _viewSlider.frame = frame;
                [UIView commitAnimations];
            }else
                button.selected=NO;
            
        }
        
    }
    
   
    
}

-(void)toggleButtonImages:(UIButton *)currentBtn{
    
    for (UIButton* button in _viewButtons.subviews)
    {
        if([button isKindOfClass:[UIButton class]]){
            if (button == currentBtn)
            {                
                
                if(button.tag != 99){
                    button.selected = YES;
                    button.highlighted = button.selected ? NO : YES;
                    _viewSlider.hidden=FALSE;
                }else{
                    _viewSlider.hidden=TRUE;
                    button.selected=NO;
                }
                
                //Put a sliding effect
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                CGRect frame = CGRectMake(0, _viewSlider.frame.origin.y, button.frame.size.width, _viewSlider.frame.size.height);
                
                frame.origin.x = button.frame.origin.x;
                
                _viewSlider.frame = frame;
                [UIView commitAnimations];
                
                
                
                // break;
                
                
            }
            else
            {
                button.selected = NO;
                button.highlighted = NO;
                
            }
            
        }
    }    
}

- (IBAction)tabButtonAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    
    if(!btn.selected && btn.tag != 99){
        [btn setSelected:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"fromTab"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }
    
    
	[self toggleButtonImages:btn];
    
    if(btn.tag == 99)
        btn.tag=0;
	
	[self.tabBarController setSelectedIndex:btn.tag];
    
    //add fade effect for every view when it loads
    [Utility fadeView:self.tabBarController.view];
	
	[self popToRootForViewIndex:btn.tag];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_viewSplash release];
    [_activity release];
    [_viewButtons release];
    [_viewSlider release];
    [_progressView release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
