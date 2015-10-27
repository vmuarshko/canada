//
//  GlossaryController.h
//  Jencor
//
//  Created by Teknowledge Software on 02/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlossaryController : UIViewController{
    JencorAppDelegate *appDelegate;
    BOOL isFetchingData;
    NSMutableArray *arr;
}
@property (retain, nonatomic) IBOutlet UIWebView *web;
@property (retain, nonatomic) IBOutlet UITableView *tbl;
//- (IBAction)btnIndexAction:(id)sender;
-(NSMutableArray *)prepareData;
//-(void)loadIndex:(NSString *)index;
@end
