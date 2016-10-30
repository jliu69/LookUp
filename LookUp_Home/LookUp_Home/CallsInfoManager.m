//
//  CallsInfoManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/9/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "CallsInfoManager.h"
#import "DataManager.h"
#import "SaveCalls2Model.h"
#import "RecruitersHelper.h"


@implementation CallsInfoManager

#pragma mark - version 1

- (void)allPreviousCommentsWithId:(NSString *)rid {
    
    DataManager *manager = [DataManager new];
    [manager commentsWithId:rid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self querySuccess:success data:json];
    }];
}

- (void)querySuccess:(BOOL)success data:(NSDictionary *)json {
    
    if (!success) {
        [self.delegate previousComments:@""];
        return;
    }
    
    NSArray *queryList = [json objectForKey:@"data"];
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@""];
    
    for (NSDictionary *eachItem in queryList) {
        NSString *dateText = [eachItem objectForKey:@"date"];
        NSString *comment = [eachItem objectForKey:@"comment"];
        
        if (comment == nil) {
            comment = @"";
        }
        if (dateText == nil) {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df dateFromString:@"yyyy/MM/dd HH:mm:ss"];
            dateText = [df stringFromDate:[NSDate date]];
        }
        
        [mutableString appendString:[NSString stringWithFormat:@"Date : %@\n", dateText]];
        [mutableString appendString:[NSString stringWithFormat:@"Comments : \n%@\n", comment]];
        [mutableString appendString:@"\n\n"];
    }
    
    [self.delegate previousComments:[NSString stringWithString:mutableString]];
}

#pragma mark - version 2

- (void)allPreviousComments2WithId:(NSString *)rid {
    
    DataManager *manager = [DataManager new];
    [manager commentsWithId:rid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self querySuccess2:success data:json];
    }];
}

- (void)querySuccess2:(BOOL)success data:(NSDictionary *)json {
    
    if (!success) {
        [self.delegate previousComments:nil];
        return;
    }
    
    NSArray *queryList = [json objectForKey:@"data"];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eachItem in queryList) {
        
        SaveCalls2Model *model = [[SaveCalls2Model alloc] init];
        model.rid = [eachItem objectForKey:@"id"];
        model.recruiterId = [eachItem objectForKey:@"rid"];
        
        NSString *commentValue = [eachItem objectForKey:@"comment"];
        if (commentValue == nil || [commentValue isEqual:[NSNull null]]) {
            commentValue = @"(n/a)";
        }
        model.comments = commentValue;
        
        NSString *dateTimeValue = [eachItem objectForKey:@"date"];
        if (dateTimeValue == nil || [dateTimeValue isEqual:[NSNull null]]) {
            dateTimeValue = [self dateTimeString];
        }
        model.dateText = dateTimeValue;
        
        [mutableArray addObject:model];
    }
    
    [self.delegate previousComments2:[NSArray arrayWithArray:mutableArray]];
}

- (NSString *)dateTimeString {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *now = [df stringFromDate:[NSDate date]];
    return now;
}

@end
