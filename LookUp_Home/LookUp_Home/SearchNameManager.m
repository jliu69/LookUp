//
//  SearchNameManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SearchNameManager.h"
#import "DataManager.h"
#import "RecruitersHelper.h"
#import "AppDelegate.h"


@implementation SearchNameManager

- (void)searchByName:(NSString *)name {
    
    DataManager *manager = [DataManager new];
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [manager searchRecuiterWithName:name uid:appDele.uid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self isProcessSuccess:success results:json];
    }];
}

- (void)isProcessSuccess:(BOOL)success results:(NSDictionary *)json {
    
    if (!success) {
        [self.delegate byNameSearchResults:nil];
        return;
    }
    
    NSArray *dataList = [json objectForKey:@"data"];
    RecruitersHelper *helper = [RecruitersHelper new];
    NSArray *recruitersList = [helper toRecruitersArrayFromResultsArray:dataList];
    
    [self.delegate byNameSearchResults:recruitersList];
}


@end

