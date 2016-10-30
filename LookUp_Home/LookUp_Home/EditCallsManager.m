//
//  EditCallsManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "EditCallsManager.h"
#import "DataManager.h"


@implementation EditCallsManager

- (void)editComments:(NSString *)comments withId:(NSString *)rid recruiterId:(NSString *)recruiterId {
    
    NSString *urlComments = [comments stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    DataManager *manager = [DataManager new];
    
    [manager editComments:urlComments rid:rid recruiterId:recruiterId callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self afterEditSuccessful:success];
    }];
}

- (void)afterEditSuccessful:(BOOL)success {
    [self.delegate editCommentSuccess:success];
}

@end
