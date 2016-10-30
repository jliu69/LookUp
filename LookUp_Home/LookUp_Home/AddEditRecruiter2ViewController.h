//
//  AddEditRecruiter2ViewController.h
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RecruiterModel;

@interface AddEditRecruiter2ViewController : UIViewController

@property (strong, nonatomic) RecruiterModel *selectedRecruiter;

- (void)cellEditRecruiter:(RecruiterModel *)aRecruiter isNew:(BOOL)isNew;

@end
