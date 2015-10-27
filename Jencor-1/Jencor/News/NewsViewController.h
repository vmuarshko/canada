//
//  NewsViewController.h
//  Jencor
//
//  Created by Ved Prakash on 20/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsViewController : UIViewController {
    
    NSMutableArray *tblData;
    BOOL wasInDetails;
    
}
@property (retain, nonatomic)NSMutableArray *tblData;
@property (retain, nonatomic) IBOutlet UITableView *tbl;

@end
