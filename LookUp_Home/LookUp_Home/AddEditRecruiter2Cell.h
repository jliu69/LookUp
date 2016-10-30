//
//  AddEditRecruiter2Cell.h
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AddEditRecruiter2ViewController, RecruiterModel;


@interface AddEditRecruiter2Cell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *middleInitialTextField;
@property (weak, nonatomic) IBOutlet UITextField *agencyNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *addressOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeTextField;

@property (weak, nonatomic) IBOutlet UITextField *workPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *workFaxTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeMobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *workEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeEmailTextField;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) AddEditRecruiter2ViewController *parentVC;

- (IBAction)saveAction:(id)sender;
- (void)selectedRecruiter:(RecruiterModel *)aRecruiter;

@end
