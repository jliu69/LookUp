//
//  UserModel.m
//  LookUp
//
//  Created by Johnson Liu on 10/25/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)init {
    self = [super init];
    
    if (self) {
        _uid = @"";
        _userName = @"";
        _pin = @"";
    }
    return self;
}

@end
