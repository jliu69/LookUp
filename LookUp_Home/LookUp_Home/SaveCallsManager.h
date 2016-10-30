//
//  SaveCallsManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/3/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SaveCallsManagerDelegate <NSObject>

@optional
- (void)commentSaveSuccess:(BOOL)success;

@end


@interface SaveCallsManager : NSObject

@property (weak, nonatomic) id<SaveCallsManagerDelegate> delegate;

- (void)saveComments:(NSString *)comments withId:(NSString *)rid;

@end
