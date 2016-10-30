//
//  AddNewManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/4/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "AddNewManager.h"
#import "DataManager.h"
#import "RecruiterModel.h"
#import "AppDelegate.h"


@implementation AddNewManager

- (void)addRecuiterWith:(RecruiterModel *)model {
    
    DataManager *manager = [DataManager new];
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [manager saveRecuiterWith:model uid:appDele.uid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self isSuccess:success];
    }];
}

- (void)isSuccess:(BOOL)success {
    [self.delegate addNewSuccess:success];
}

@end
