//
//  DeleteCallsManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DeleteCallsManagerDelegate <NSObject>

@optional
- (void)delteCommentSuccess:(BOOL)success;

@end


@interface DeleteCallsManager : NSObject

@property (weak, nonatomic) id<DeleteCallsManagerDelegate> delegate;

- (void)deleteCommentsWithId:(NSString *)rid recruiterId:(NSString *)recruiterId;

@end
