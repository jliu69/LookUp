//
//  DeleteRecruiterManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/21/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "DeleteRecruiterManager.h"
#import "DataManager.h"
#import "AppDelegate.h"

@implementation DeleteRecruiterManager

- (void)deleteRecruiterWithId:(NSString *)rid {
    
    DataManager *manager = [DataManager new];
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [manager deleteRecuiterWithId:rid uid:appDele.uid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self afterDeleteSuccessful:success];
    }];
}

- (void)afterDeleteSuccessful:(BOOL)success {
    [self.delegate deleteRecruiterSuccess:success];
}

@end
