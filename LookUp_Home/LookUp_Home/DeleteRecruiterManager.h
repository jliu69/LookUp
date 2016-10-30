//
//  DeleteRecruiterManager.h
//  LookUp
//
//  Created by Johnson Liu on 10/21/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DeleteRecruiterManagerDelegate <NSObject>

@optional
- (void)deleteRecruiterSuccess:(BOOL)success;

@end


@interface DeleteRecruiterManager : NSObject

@property (weak, nonatomic) id<DeleteRecruiterManagerDelegate> delegate;

- (void)deleteRecruiterWithId:(NSString *)rid;

@end
