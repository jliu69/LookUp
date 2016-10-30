//
//  RecruiterModel.m
//  LookUp
//
//  Created by Johnson Liu on 9/16/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "RecruiterModel.h"

@implementation RecruiterModel

- (id)init {
    self = [super init];
    
    if (self) {
        _recruiterId = 0;
        _lastName = @"";
        _firstName = @"";
        _middleInitial = @"";
        _agencyName = @"";
        _address1 = @"";
        _address2 = @"";
        _city = @"";
        _state = @"";
        _zipcode = @"";
        _workPhone = @"";
        _workFax = @"";
        _homeMobile = @"";
        _workEmail = @"";
        _homeEmail = @"";
    }
    return self;
}

@end
