//
//  LoginUserManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/25/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "LoginUserManager.h"
#import "DataManager.h"
#import "UserModel.h"


@implementation LoginUserManager

- (void)loginUser:(NSString *)userName password:(NSString *)password {
    
    NSLog(@"-> user name = '%@' ", userName);
    NSLog(@"-> password  = '%@' ", password);
    
    DataManager *manager = [DataManager new];
    [manager loginUser:userName password:password callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self loginSuccess:success user:json];
    }];
}

- (void)loginSuccess:(BOOL)success user:(NSDictionary *)json {
    
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
    
    [self.delegate loginUser:user];
}

@end
