//
//  EnterCommentsViewController.h
//  LookUp
//
//  Created by Johnson Liu on 10/28/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EnterCommentsViewControllerDelegate <NSObject>

- (void)userComments:(NSString *)text;

@end

@interface EnterCommentsViewController : UIViewController

@property (weak, nonatomic) id<EnterCommentsViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *commentText;

@end
