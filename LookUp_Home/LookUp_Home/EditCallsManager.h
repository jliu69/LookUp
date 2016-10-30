//
//  EditCallsManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol EditCallsManagerDelegate <NSObject>

@optional
- (void)editCommentSuccess:(BOOL)success;

@end


@interface EditCallsManager : NSObject

@property (weak, nonatomic) id<EditCallsManagerDelegate> delegate;

- (void)editComments:(NSString *)comments withId:(NSString *)rid recruiterId:(NSString *)recruiterId;

@end
