//
//  DataManager.h
//  Test3
//
//  Created by Johnson Liu on 9/21/16.
//  Copyright © 2016 Johnson Liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RecruiterModel;


@interface DataManager : NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate>

- (void)recruiters6With:(NSString *)searchCode firstName:(NSString *)firstName lastName:(NSString *)lastName callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;
- (void)totalWithIds:(NSString *)idsList callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;

//-- new methods

- (void)saveRecuiterWith:(RecruiterModel *)model uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;

- (void)searchRecuiterWithDate:(NSString *)date uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;
- (void)searchRecuiterWithContent:(NSString *)content uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;
- (void)searchRecuiterWithName:(NSString *)name uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;

- (void)updateRecuiterWith:(RecruiterModel *)model uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;
- (void)deleteRecuiterWithId:(NSString *)rid uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;

- (void)commentsWithId:(NSString *)rid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;
- (void)saveComments:(NSString *)comments recruiterId:(NSString *)rid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;

- (void)editComments:(NSString *)comments rid:(NSString *)rid recruiterId:(NSString *)recruiterId callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;
- (void)deleteCommentsWithId:(NSString *)rid recruiterId:(NSString *)recruiterId callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;

- (void)loginUser:(NSString *)userName password:(NSString *)password callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;
- (void)registerUser:(NSString *)userName password:(NSString *)password callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback;

@end
