//
//  DateSelectionViewController.h
//  LookUp
//
//  Created by Johnson Liu on 10/6/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DateSelectionViewControllerDelegate <NSObject>

@optional
- (void)selectedDateText:(NSString *)dateText;

@end


@interface DateSelectionViewController : UIViewController

@property (weak, nonatomic) id<DateSelectionViewControllerDelegate> delegate;

@end
