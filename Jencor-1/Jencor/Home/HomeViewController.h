//
//  HomeViewController.h
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeader.h"

@interface HomeViewController : UIViewController {
    JencorAppDelegate *appDelegate;
    
    CommonHeader *header;
    
    NSMutableArray *tblData;
}
@property (retain, nonatomic) NSMutableArray *tblData;
@property (retain, nonatomic) IBOutlet UIView *viewRates;
@property (retain, nonatomic) IBOutlet UIView *viewHome;
@property (retain, nonatomic) IBOutlet UITableView *tbl;

- (IBAction)menuAction:(id)sender;

-(void)setupView;
-(void)selectRespectedTab:(int)index;
@end
