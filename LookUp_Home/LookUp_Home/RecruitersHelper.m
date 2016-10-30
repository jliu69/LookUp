//
//  RecruitersHelper.m
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "RecruitersHelper.h"
#import "RecruiterModel.h"
#import <UIKit/UIKit.h>


@implementation RecruitersHelper

- (NSArray *)toRecruitersArrayFromResultsArray:(NSArray *)dataList {
    
    if (dataList == nil || dataList.count == 0) {
        return nil;
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eachItem in dataList) {
        RecruiterModel *model = [[RecruiterModel alloc] init];
        model.recruiterId = [eachItem objectForKey:@"id"] ? [[eachItem objectForKey:@"id"] intValue] : 0;
        model.lastName = [eachItem objectForKey:@"last_name"] ? [eachItem objectForKey:@"last_name"] : @"n/a";
        model.firstName = [eachItem objectForKey:@"first_name"] ? [eachItem objectForKey:@"first_name"] : @"n/a";
        model.middleInitial = [eachItem objectForKey:@"middle_initial"] ? [eachItem objectForKey:@"middle_initial"] : @"";
        model.agencyName = [eachItem objectForKey:@"agency_name"] ? [eachItem objectForKey:@"agency_name"] : @"";
        model.address1 = [eachItem objectForKey:@"address_1"] ? [eachItem objectForKey:@"address_1"] : @"";
        model.address2 = [eachItem objectForKey:@"address_2"] ? [eachItem objectForKey:@"address_2"] : @"";
        model.city = [eachItem objectForKey:@"city"] ? [eachItem objectForKey:@"city"] : @"";
        model.state = [eachItem objectForKey:@"state"] ? [eachItem objectForKey:@"state"] : @"";
        model.zipcode = [eachItem objectForKey:@"zipcode"] ? [eachItem objectForKey:@"zipcode"] : @"";
        model.workPhone = [eachItem objectForKey:@"phone_work"] ? [eachItem objectForKey:@"phone_work"] : @"";
        model.workFax = [eachItem objectForKey:@"phone_fax"] ? [eachItem objectForKey:@"phone_fax"] : @"";
        model.homeMobile = [eachItem objectForKey:@"phone_mobile"] ? [eachItem objectForKey:@"phone_mobile"] : @"";
        model.workEmail = [eachItem objectForKey:@"email_work"] ? [eachItem objectForKey:@"email_work"] : @"";
        model.homeEmail = [eachItem objectForKey:@"email_personal"] ? [eachItem objectForKey:@"email_personal"] : @"";
        [mutableArray addObject:model];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

- (void)alertMessage:(NSString *)message title:(NSString *)title controller:(UIViewController *)viewController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

- (NSString *)currentDateText {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df dateFromString:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateText = [df stringFromDate:[NSDate date]];
    df = nil;
    
    return dateText;
}


@end


