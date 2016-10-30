//
//  SaveCallsManager.m
//  LookUp
//
//  Created by Johnson Liu on 10/3/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SaveCallsManager.h"
#import "DataManager.h"
#import "StringEscapeModel.h"

@implementation SaveCallsManager

- (void)saveComments:(NSString *)comments withId:(NSString *)rid {
    
    NSString *urlComments = [comments stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    //NSString *urlComments = [StringEscapeModel queryAndUrlEscapeText:comments];
    DataManager *manager = [DataManager new];
    
    [manager saveComments:urlComments recruiterId:rid callBack:^(BOOL success, NSDictionary *json, NSError *error) {
        [self afterSaveSuccessful:success];
    }];
}

- (void)afterSaveSuccessful:(BOOL)success {
    [self.delegate commentSaveSuccess:success];
}

@end
