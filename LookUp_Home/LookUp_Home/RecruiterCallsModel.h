//
//  RecruiterCallsModel.h
//  LookUp
//
//  Created by Johnson Liu on 9/16/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecruiterCallsModel : NSObject

@property (assign, nonatomic) int recruiterId;
@property (strong, nonatomic) NSDate *callDate;
@property (strong, nonatomic) NSString *callComment;

@end
