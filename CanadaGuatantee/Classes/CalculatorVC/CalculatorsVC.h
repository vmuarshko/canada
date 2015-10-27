//
//  CalculatorsVC.h
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalculatorsVC : UIViewController {
	IBOutlet UILabel *lblTitle;
	IBOutlet UIButton *btnMPC;
	IBOutlet UIButton *btnIPC;
}

-(IBAction)mpcAction;
-(IBAction)ipcAction;

-(IBAction)settingAction;
@end
