//
//  LoginUserManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/25/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;


@protocol LoginUserManagerDelegate <NSObject>

@optional
- (void)loginUser:(UserModel *)anUser;

@end


@interface LoginUserManager : NSObject

@property (weak, nonatomic) id<LoginUserManagerDelegate> delegate;

- (void)loginUser:(NSString *)userName password:(NSString *)password;

@end
