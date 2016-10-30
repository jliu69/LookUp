//
//  SearchContentManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SearchContentManager.h"
#import "DataManager.h"
#import "RecruitersHelper.h"
#import "AppDelegate.h"


@implementation SearchContentManager

- (void)searchByContent:(NSString *)content {
    
    DataManager *manager = [DataManager new];
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [manager searchRecuiterWithContent:content uid:appDele.uid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self isProcessSuccess:success results:json];
    }];
}

- (void)isProcessSuccess:(BOOL)success results:(NSDictionary *)json {
    
    if (!success) {
        [self.delegate byContentSearchResults:nil];
        return;
    }
    
    NSArray *dataList = [json objectForKey:@"data"];
    RecruitersHelper *helper = [RecruitersHelper new];
    NSArray *recruitersList = [helper toRecruitersArrayFromResultsArray:dataList];
    
    [self.delegate byContentSearchResults:recruitersList];
}


@end

