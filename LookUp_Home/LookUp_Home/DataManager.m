//
//  DataManager.m
//  Test3
//
//  Created by Johnson Liu on 9/21/16.
//  Copyright © 2016 Johnson Liu. All rights reserved.
//

#import "DataManager.h"
#import "RecruiterModel.h"
#import "StringEscapeModel.h"
#import "RecruitersHelper.h"


@interface DataManager()

@end


@implementation DataManager

#pragma mark - others

- (void)recruiters6With:(NSString *)searchCode firstName:(NSString *)firstName lastName:(NSString *)lastName callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup/lookup_recruiters_by_name.php?searchcode=%@&lastname=%@&firstname=%@", searchCode, lastName, firstName];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

- (void)totalWithIds:(NSString *)idsList callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup/lookup_total_recruiter_calls.php?idslist=%@", idsList];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

#pragma mark - add recruite

- (void)saveRecuiterWith:(RecruiterModel *)model uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *lastName = [StringEscapeModel queryAndUrlEscapeText:[model lastName]];
    NSString *firstName = [StringEscapeModel queryAndUrlEscapeText:[model firstName]];
    NSString *mi = [StringEscapeModel queryAndUrlEscapeText:[model middleInitial]];
    NSString *agencyName = [StringEscapeModel queryAndUrlEscapeText:[model agencyName]];
    NSString *address1 = [StringEscapeModel queryAndUrlEscapeText:[model address1]];
    NSString *address2 = [StringEscapeModel queryAndUrlEscapeText:[model address2]];
    NSString *city = [StringEscapeModel queryAndUrlEscapeText:[model city]];
    NSString *state = [StringEscapeModel queryAndUrlEscapeText:[model state]];
    NSString *zipcode = [StringEscapeModel queryAndUrlEscapeText:[model zipcode]];
    NSString *workPhone = [StringEscapeModel queryAndUrlEscapeText:[model workPhone]];
    NSString *workFax = [StringEscapeModel queryAndUrlEscapeText:[model workFax]];
    NSString *homeMobile = [StringEscapeModel queryAndUrlEscapeText:[model homeMobile]];
    NSString *workEmail = [StringEscapeModel queryAndUrlEscapeText:[model workEmail]];
    NSString *homeEmail = [StringEscapeModel queryAndUrlEscapeText:[model homeEmail]];
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup/lookup_save_recruiters.php?userid=%@&lastname=%@&firstname=%@&middleinitial=%@&agencyname=%@&address1=%@&address2=%@&city=%@&state=%@&zipcode=%@&phonework=%@&phonefax=%@&phonemobile=%@&emailwork=%@&emailpersonal=%@", uid, lastName, firstName, mi, agencyName, address1, address2, city, state, zipcode, workPhone, workFax, homeMobile, workEmail, homeEmail];
    
    NSLog(@"insert SQL : '%@' ", urlLink);
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

#pragma mark - search recruiter

- (void)searchRecuiterWithDate:(NSString *)date uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *startDate = [NSString stringWithFormat:@"%@+00:00:00", date];
    NSString *endDate = [NSString stringWithFormat:@"%@+23:59:59", date];
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_search_recruiter_by_date.php?startdate=%@&enddate=%@", startDate, endDate];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

- (void)searchRecuiterWithContent:(NSString *)content uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *searchContent = [StringEscapeModel queryAndUrlEscapeText:content];
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_search_recruiter_by_content.php?uid=&content=%@", searchContent];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

- (void)searchRecuiterWithName:(NSString *)name uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *searchName = [StringEscapeModel queryAndUrlEscapeText:name];
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_search_recruiter_by_name.php?uid=&name=%@", searchName];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

#pragma mark - change recruiter

- (void)updateRecuiterWith:(RecruiterModel *)model uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *rid = [NSString stringWithFormat:@"%d", [model recruiterId]];
    NSString *lastName = [StringEscapeModel queryAndUrlEscapeText:[model lastName]];
    NSString *firstName = [StringEscapeModel queryAndUrlEscapeText:[model firstName]];
    NSString *mi = [StringEscapeModel queryAndUrlEscapeText:[model middleInitial]];
    NSString *agencyName = [StringEscapeModel queryAndUrlEscapeText:[model agencyName]];
    NSString *address1 = [StringEscapeModel queryAndUrlEscapeText:[model address1]];
    NSString *address2 = [StringEscapeModel queryAndUrlEscapeText:[model address2]];
    NSString *city = [StringEscapeModel queryAndUrlEscapeText:[model city]];
    NSString *state = [StringEscapeModel queryAndUrlEscapeText:[model state]];
    NSString *zipcode = [StringEscapeModel queryAndUrlEscapeText:[model zipcode]];
    NSString *workPhone = [StringEscapeModel queryAndUrlEscapeText:[model workPhone]];
    NSString *workFax = [StringEscapeModel queryAndUrlEscapeText:[model workFax]];
    NSString *homeMobile = [StringEscapeModel queryAndUrlEscapeText:[model homeMobile]];
    NSString *workEmail = [StringEscapeModel queryAndUrlEscapeText:[model workEmail]];
    NSString *homeEmail = [StringEscapeModel queryAndUrlEscapeText:[model homeEmail]];
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_edit_recruiter.php?uid=%@&lastname=%@&firstname=%@&middleinitial=%@&agencyname=%@&address1=%@&address2=%@&city=%@&state=%@&zipcode=%@&phonework=%@&phonefax=%@&phonemobile=%@&emailwork=%@&emailpersonal=%@&rid=%@", uid, lastName, firstName, mi, agencyName, address1, address2, city, state, zipcode, workPhone, workFax, homeMobile, workEmail, homeEmail, rid];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

- (void)deleteRecuiterWithId:(NSString *)rid uid:(NSString *)uid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_delete_recruiter.php?rid=%@&uid=%@", rid, uid];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

#pragma mark - get previous comments

- (void)commentsWithId:(NSString *)rid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_recruiter_comments.php?recruiterid=%@", rid];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

#pragma mark - save call info

- (void)saveComments:(NSString *)comments recruiterId:(NSString *)rid callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    RecruitersHelper *helper = [RecruitersHelper new];
    NSString *currentDate = [helper currentDateText];
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup/lookup_save_calls.php?recruiterid=%@&comments=%@&calldate=%@&editdate=%@", rid, comments, currentDate, currentDate];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

#pragma mark - change call info

- (void)editComments:(NSString *)comments rid:(NSString *)rid recruiterId:(NSString *)recruiterId callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    RecruitersHelper *helper = [RecruitersHelper new];
    NSString *currentDate = [helper currentDateText];
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_edit_calling_info.php?rid=%@&recruiterid=%@&comments=%@&editdate=%@", rid, recruiterId, comments, currentDate];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

- (void)deleteCommentsWithId:(NSString *)rid recruiterId:(NSString *)recruiterId callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_delete_calling_info.php?rid=%@&recruiterid=%@", rid, recruiterId];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

#pragma mark - login register

- (void)loginUser:(NSString *)userName password:(NSString *)password callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_login_user.php?name=%@&pwd=%@&pin=", userName, password];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *json = [NSDictionary new];
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        BOOL success = (error == nil) ? YES : NO;
        callback(success, json, error);
    }];
    [task resume];
}

- (void)registerUser:(NSString *)userName password:(NSString *)password callBack:(void(^)(BOOL success, NSDictionary *json, NSError *error))callback {
    
    NSString *urlLink = [NSString stringWithFormat:@"http://www.mysohoplace.com/php_hdb/php_lookup_2/lookup_add_user.php?name=%@&pwd=%@&pin=", userName, password];
    
    NSURL *url = [NSURL URLWithString:urlLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *dataText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"register data text : %@", dataText);
        
        if ([dataText isEqualToString:@"0"]) {
            callback(NO, nil, error);
        }
        else {
            NSError *err;
            NSDictionary *json = [NSDictionary new];
            json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            
            BOOL success = (error == nil) ? YES : NO;
            callback(success, json, error);
        }
    }];
    [task resume];
}


@end

