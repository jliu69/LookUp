//
//  RegisterUserManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/25/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "RegisterUserManager.h"
#import "DataManager.h"
#import "UserModel.h"


@implementation RegisterUserManager

- (void)registerUser:(NSString *)name password:(NSString *)pwd pin:(NSString *)pin {
    
    DataManager *manager = [DataManager new];
    [manager registerUser:name password:pwd callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self registerSuccess:success user:json];
    }];
    
}

- (void)registerSuccess:(BOOL)success user:(NSDictionary *)json {
    
    if (json == nil) {
        [self.delegate registerUser:nil];
    }
    else {
        UserModel *user = nil;
        if (json != nil && json.count > 0) {
            NSLog(@"... login results, is success? %d, user: %@", success, json);
            
            NSArray *userList = [json objectForKey:@"data"];
            
            if (userList.count > 0) {
                NSDictionary *userData = [userList objectAtIndex:0];
                
                user = [[UserModel alloc] init];
                user.uid = [userData objectForKey:@"uid"];
                user.userName = [userData objectForKey:@"name"];
                user.pin = [userData objectForKey:@"pin"] ? [userData objectForKey:@"pin"] : @"";
            }
        }
        
        [self.delegate registerUser:user];
    }
}

@end
