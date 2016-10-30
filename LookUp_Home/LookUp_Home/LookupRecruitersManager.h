//
//  LookupRecruitersManager.h
//  Test3
//
//  Created by Johnson Liu on 9/21/16.
//  Copyright © 2016 Johnson Liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LookupRecruitersManagerDelegate <NSObject>

@optional
- (void)recruitersList:(NSArray *)list;

@end


@interface LookupRecruitersManager : NSObject

@property (weak, nonatomic) id <LookupRecruitersManagerDelegate> delegate;

- (void)recruiters5WithFirstName:(NSString *)firstName lastName:(NSString *)lastName;


@end
