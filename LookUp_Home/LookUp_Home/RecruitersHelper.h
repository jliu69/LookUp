//
//  RecruitersHelper.h
//  LookUp
//
//  Created by Johnson Liu on 10/7/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface RecruitersHelper : NSObject

- (NSArray *)toRecruitersArrayFromResultsArray:(NSArray *)dataList;
- (void)alertMessage:(NSString *)message title:(NSString *)title controller:(UIViewController *)viewController;
- (NSString *)currentDateText;

@end
