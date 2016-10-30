//
//  SearchDateManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SearchDateManager.h"
#import "DataManager.h"
#import "RecruitersHelper.h"
#import "AppDelegate.h"


@implementation SearchDateManager

- (void)searchByDate:(NSString *)dateText {
    
    DataManager *manager = [DataManager new];
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [manager searchRecuiterWithDate:dateText uid:appDele.uid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self isProcessSuccess:success results:json];
    }];
}

- (void)isProcessSuccess:(BOOL)success results:(NSDictionary *)json {
    
    if (!success) {
        [self.delegate byDateSearchResults:nil];
        return;
    }
    
    NSArray *dataList = [json objectForKey:@"data"];
    RecruitersHelper *helper = [RecruitersHelper new];
    NSArray *recruitersList = [helper toRecruitersArrayFromResultsArray:dataList];
    
    [self.delegate byDateSearchResults:recruitersList];
}


@end

