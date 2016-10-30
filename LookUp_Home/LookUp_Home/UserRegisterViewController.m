//
//  UserRegisterViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/25/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UserModel.h"
#import "RegisterUserManager.h"
#import "AppDelegate.h"
#import "SearchViewController.h"
#import "RecruitersHelper.h"


@interface UserRegisterViewController () <UITextFieldDelegate, RegisterUserManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTwoTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation UserRegisterViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_activityIndicator stopAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _cancelButton.layer.cornerRadius = 5;
    _cancelButton.clipsToBounds = YES;
    
    _registerButton.layer.cornerRadius = 5;
    _registerButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IB actions

- (IBAction)cancelAction:(id)sender {
    [self clearKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(id)sender {
    [self clearKeyboard];
    [self processRegister];
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self clearKeyboard];
    
    if (textField == _passwordTwoTextField) {
        [self processRegister];
    }
    return YES;
}

- (void)clearKeyboard {
    [_userNameTextField resignFirstResponder];
    [_passwordOneTextField resignFirstResponder];
    [_passwordTwoTextField resignFirstResponder];
}

#pragma mark - register delegate

- (void)registerUser:(UserModel *)anUser {
    
    if (anUser != nil) {
        AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDele.uid = [anUser uid];
        
        //-- close login & register page
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityIndicator stopAnimating];
            
            UIViewController *targetVC = nil;
            NSArray *controllers = [self.navigationController viewControllers];
            for (UIViewController *eachVC in controllers) {
                if ([eachVC isKindOfClass:[SearchViewController class]]) {
                    targetVC = eachVC;
                }
            }
            [self.navigationController popToViewController:targetVC animated:NO];
        });
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityIndicator stopAnimating];
            
            RecruitersHelper *helper = [RecruitersHelper new];
            [helper alertMessage:@"This user is already exist." title:@"Error" controller:self];
            
            _userNameTextField.text = nil;
            _passwordOneTextField.text = nil;
            _passwordTwoTextField.text = nil;
        });
    }
    
}

#pragma mark - local methods

- (BOOL)validateData {
    NSString *message = nil;
    
    if (_userNameTextField.text == nil || _userNameTextField.text.length == 0 || _passwordOneTextField.text == nil || _passwordOneTextField.text.length == 0 || _passwordTwoTextField.text == nil || _passwordTwoTextField.text.length == 0) {
        message = @"User name and password cannot be empty";
    }
    
    if (![_passwordOneTextField.text isEqualToString:_passwordTwoTextField.text]) {
        message = @"The passwords are not match";
    }
    
    if (message != nil) {
        
        RecruitersHelper *helper = [RecruitersHelper new];
        [helper alertMessage:message title:@"Warning" controller:self];
        
        _userNameTextField.text = nil;
        _passwordOneTextField.text = nil;
        _passwordTwoTextField.text = nil;
        return NO;
    }
    
    _userNameTextField.text = [_userNameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    _passwordOneTextField.text = [_passwordOneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    _passwordTwoTextField.text = [_passwordTwoTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return YES;
}

- (void)processRegister {
    
    if ([self validateData]) {
        RegisterUserManager *manager = [RegisterUserManager new];
        manager.delegate = self;
        [manager registerUser:_userNameTextField.text password:_passwordTwoTextField.text pin:@""];
        
        [_activityIndicator startAnimating];
    }
}


@end
