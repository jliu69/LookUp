//
//  UserLoginViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/25/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UserRegisterViewController.h"
#import "UserModel.h"
#import "LoginUserManager.h"
#import "AppDelegate.h"
#import "RecruitersHelper.h"
#import "Constants.h"


@interface UserLoginViewController () <UITextFieldDelegate, LoginUserManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISwitch *saveNamePwdSwitch;

@end


@implementation UserLoginViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_activityIndicator stopAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _loginButton.layer.cornerRadius = 5;
    _loginButton.clipsToBounds = YES;
    
    _registerButton.layer.cornerRadius = 5;
    _registerButton.clipsToBounds = YES;
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:[Constants kUserDefaultSaveNameKey]];
    if (userName != nil && userName.length > 0) {
        _userNameTextField.text = userName;
    }
    
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:[Constants kUserDefaultSavePasswordKey]];
    if (password != nil && password.length > 0) {
        _passwordTextField.text = password;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IB actions

- (IBAction)loginAction:(id)sender {
    [self clearKeyboard];
    [self processLogin];
}

- (IBAction)registerAction:(id)sender {
    [self clearKeyboard];
    UserRegisterViewController *registerVC = [[UserRegisterViewController alloc] initWithNibName:@"UserRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)processLogin {
    
    if ([self validateData]) {
        LoginUserManager *manager = [LoginUserManager new];
        manager.delegate = self;
        [manager loginUser:_userNameTextField.text password:_passwordTextField.text];
        
        [_activityIndicator startAnimating];
    }
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self clearKeyboard];
    
    if (textField == _passwordTextField) {
        [self processLogin];
    }
    return YES;
}

#pragma mark - login delegate

- (void)loginUser:(UserModel *)anUser {
    
    if (anUser != nil) {
        AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDele.uid = [anUser uid];
        
        if (_saveNamePwdSwitch.on) {
            [[NSUserDefaults standardUserDefaults] setObject:[_userNameTextField text] forKey:[Constants kUserDefaultSaveNameKey]];
            [[NSUserDefaults standardUserDefaults] setObject:[_passwordTextField text] forKey:[Constants kUserDefaultSavePasswordKey]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        //-- close login page
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityIndicator stopAnimating];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityIndicator stopAnimating];
            
            RecruitersHelper *helper = [RecruitersHelper new];
            [helper alertMessage:@"Login failed." title:@"Error" controller:self];
            
            _userNameTextField.text = nil;
            _passwordTextField.text = nil;
        });
    }
}

#pragma mark - local methods

- (void)clearKeyboard {
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (BOOL)validateData {
    NSString *message = nil;
    
    if (_userNameTextField.text == nil || _userNameTextField.text.length == 0) {
        message = @"User name cannot be empty.";
    }
    
    if (_passwordTextField.text == nil || _passwordTextField.text.length == 0) {
        if (message == nil)
            message = @"Password cannot be empty";
        else
            message = @"User name and password cannot be empty.";
    }
    
    if (message != nil) {
        RecruitersHelper *helper = [RecruitersHelper new];
        [helper alertMessage:message title:@"Warning" controller:self];
        
        _userNameTextField.text = nil;
        _passwordTextField.text = nil;
        return NO;
    }
    
    _userNameTextField.text = [_userNameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    _passwordTextField.text = [_passwordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return YES;
}


@end

