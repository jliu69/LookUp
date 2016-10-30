//
//  CallsInfoManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/9/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CallsInfoManagerDelegate <NSObject>

@optional
- (void)previousComments:(NSString *)text;
- (void)previousComments2:(NSArray *)list;

@end


@interface CallsInfoManager : NSObject

@property (weak, nonatomic) id<CallsInfoManagerDelegate> delegate;

- (void)allPreviousCommentsWithId:(NSString *)rid;
- (void)allPreviousComments2WithId:(NSString *)rid;

@end

