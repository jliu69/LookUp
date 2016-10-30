//
//  DeleteCallsManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "DeleteCallsManager.h"
#import "DataManager.h"


@implementation DeleteCallsManager

- (void)deleteCommentsWithId:(NSString *)rid recruiterId:(NSString *)recruiterId {
    
    DataManager *manager = [DataManager new];
    
    [manager deleteCommentsWithId:rid recruiterId:recruiterId callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self afterDeleteSuccessful:success];
    }];
}

- (void)afterDeleteSuccessful:(BOOL)success {
    [self.delegate delteCommentSuccess:success];
}

@end
