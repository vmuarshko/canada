//
//  QuickForm.h
//  Jencor
//
//  Created by Ved Prakash on 30/11/11.
//  Copyright 2011 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QuickForm : NSObject {
    NSString *fieldValue;
    NSString *fieldName;
    BOOL mandatory;
    NSString *fieldType;
    NSString *fieldLabel;
}

@property(nonatomic,retain) NSString *fieldValue;
@property(nonatomic,retain) NSString *fieldName;
@property(nonatomic) BOOL mandatory;
@property(nonatomic,retain) NSString *fieldType;
@property(nonatomic,retain) NSString *fieldLabel;

-(id)getForm;

@end
