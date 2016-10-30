//
//  LookupRecruitersManager.m
//  Test3
//
//  Created by Johnson Liu on 9/21/16.
//  Copyright © 2016 Johnson Liu. All rights reserved.
//

#import "LookupRecruitersManager.h"
#import "DataManager.h"
#import "RecruiterModel.h"


@interface LookupRecruitersManager()

@property (strong, nonatomic) NSMutableArray *mutableArray;

@end


@implementation LookupRecruitersManager

#pragma mark - 5th way

- (void)recruiters5WithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    
    if (firstName == nil) firstName = @"";
    NSString *searchCode = @"1";
    
//    if (firstName == nil) firstName = @"";
//    if (lastName == nil) lastName = @"";
//    
//    NSString *searchCode = @"";
//    
//    if (firstName.length > 0 && lastName.length > 0) {
//        //
//    }
//    else if (firstName.length > 0) {
//        searchCode = @"1";
//    }
//    else if (lastName.length > 0) {
//        searchCode = @"2";
//    }
    
    DataManager *manager = [DataManager new];
    [manager recruiters6With:searchCode firstName:firstName lastName:lastName callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self recruitesListFromData:json];
    }];
}

- (void)recruitesListFromData:(NSDictionary *)data {
    
    NSArray *itemsArray = [data objectForKey:@"data"];
    if (itemsArray == nil || itemsArray.count == 0) {
        return;
    }
    
    self.mutableArray = [[NSMutableArray alloc] init];
    NSMutableArray *mutableIdsArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eachItem in itemsArray) {
        RecruiterModel *model = [[RecruiterModel alloc] init];
        model.recruiterId = [[eachItem objectForKey:@"id"] intValue];
        model.lastName = [eachItem objectForKey:@"last_name"];
        model.firstName = [eachItem objectForKey:@"first_name"];
        model.middleInitial = [eachItem objectForKey:@"middle_initial"];
        model.agencyName = [eachItem objectForKey:@"agency_name"];
        model.address1 = [eachItem objectForKey:@"address_1"];
        model.address2 = [eachItem objectForKey:@"address_2"];
        model.city = [eachItem objectForKey:@"city"];
        model.state = [eachItem objectForKey:@"state"];
        model.zipcode = [eachItem objectForKey:@"zipcode"];
        model.workPhone = [eachItem objectForKey:@"phone_work"];
        model.workFax = [eachItem objectForKey:@"phone_fax"];
        model.homeMobile = [eachItem objectForKey:@"phone_mobile"];
        model.workEmail = [eachItem objectForKey:@"email_work"];
        model.homeEmail = [eachItem objectForKey:@"email_personal"];
        [self.mutableArray addObject:model];
        
        [mutableIdsArray addObject:[NSString stringWithFormat:@"%d", model.recruiterId]];
    }
    
    [self totalCountsWithIds:[NSArray arrayWithArray:mutableIdsArray]];
}

- (void)totalCountsWithIds:(NSArray *)idsList {
    
    NSString *idsText = [idsList componentsJoinedByString:@","];
    
    DataManager *manager = [DataManager new];
    [manager totalWithIds:idsText callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self totalsData:json];
    }];
}

- (void)totalsData:(NSDictionary *)data {
    
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];
    NSArray *recruiterslist = [data objectForKey:@"data"];
    
    if (recruiterslist == nil || recruiterslist.count == 0) {
        return;
    }
    
    for (NSDictionary *eachItem in recruiterslist) {
        NSString *key = [eachItem objectForKey:@"id"];
        NSString *value = [eachItem objectForKey:@"total"];
        [mutableDict setObject:value forKey:key];
    }
    NSDictionary *idsData = [NSDictionary dictionaryWithDictionary:mutableDict];
    NSLog(@"total Ids : %@", idsData);
    
    
    for (RecruiterModel *item in self.mutableArray) {
        
        NSString *key = [NSString stringWithFormat:@"%d", item.recruiterId];
        NSString *totalText = [idsData objectForKey:key];
        
        if (totalText == nil || totalText.length == 0)
            totalText = @"0";
        
        item.totalCalls = totalText;
    }
    
    NSArray *list = [NSArray arrayWithArray:self.mutableArray];
    [self.delegate recruitersList:list];
}


@end

