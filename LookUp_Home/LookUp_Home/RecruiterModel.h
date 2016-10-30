//
//  RecruiterModel.h
//  LookUp
//
//  Created by Johnson Liu on 9/16/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecruiterModel : NSObject

@property (assign, nonatomic) int recruiterId;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *middleInitial;
@property (strong, nonatomic) NSString *agencyName;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zipcode;
@property (strong, nonatomic) NSString *workPhone;
@property (strong, nonatomic) NSString *workFax;
@property (strong, nonatomic) NSString *homeMobile;
@property (strong, nonatomic) NSString *workEmail;
@property (strong, nonatomic) NSString *homeEmail;
@property (strong, nonatomic) NSString *totalCalls;

@end
