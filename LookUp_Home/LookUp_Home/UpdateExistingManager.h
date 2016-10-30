//
//  UpdateExistingManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/8/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RecruiterModel;


@protocol UpdateExistingManagerDelegate <NSObject>

@optional
- (void)updateExistingSuccess:(BOOL)success;

@end


@interface UpdateExistingManager : NSObject

@property (weak, nonatomic) id<UpdateExistingManagerDelegate> delegate;

- (void)updateRecuiterWith:(RecruiterModel *)model;

@end
