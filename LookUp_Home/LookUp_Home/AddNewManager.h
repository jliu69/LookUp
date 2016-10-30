//
//  AddNewManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/4/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RecruiterModel;


@protocol AddNewManagerDelegate <NSObject>

@optional
- (void)addNewSuccess:(BOOL)success;

@end


@interface AddNewManager : NSObject

@property (weak, nonatomic) id<AddNewManagerDelegate> delegate;

- (void)addRecuiterWith:(RecruiterModel *)model;

@end
