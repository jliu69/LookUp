//
//  UpdateExistingManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/8/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "UpdateExistingManager.h"
#import "RecruiterModel.h"
#import "DataManager.h"
#import "AppDelegate.h"


@implementation UpdateExistingManager

- (void)updateRecuiterWith:(RecruiterModel *)model {
    
    DataManager *manager = [DataManager new];
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [manager updateRecuiterWith:model uid:appDele.uid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self isSuccess:success];
    }];
}

- (void)isSuccess:(BOOL)success {
    [self.delegate updateExistingSuccess:success];
}

@end
