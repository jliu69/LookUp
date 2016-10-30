//
//  RegisterUserManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/25/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;


@protocol RegisterUserManagerDelegate <NSObject>

@optional
- (void)registerUser:(UserModel *)anUser;

@end


@interface RegisterUserManager : NSObject

@property (weak, nonatomic) id<RegisterUserManagerDelegate> delegate;

- (void)registerUser:(NSString *)name password:(NSString *)pwd pin:(NSString *)pin;

@end
