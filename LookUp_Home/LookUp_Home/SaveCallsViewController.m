//
//  SaveCallsViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/9/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SaveCallsViewController.h"
#import "RecruiterModel.h"
#import "CallsInfoManager.h"
#import "SaveCallsManager.h"


@interface SaveCallsViewController () <UITextFieldDelegate, CallsInfoManagerDelegate, SaveCallsManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameAgencyLabel;
@property (weak, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (weak, nonatomic) IBOutlet UITextView *previousCommentsTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation SaveCallsViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _saveButton.layer.cornerRadius = 5;
    _saveButton.clipsToBounds = YES;
    
    _previousCommentsTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _previousCommentsTextView.layer.borderWidth = 0.5;
    
    _previousCommentsTextView.text = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _nameAgencyLabel.text = [NSString stringWithFormat:@"Name : %@ %@ (%@)", _selectedModel.firstName, _selectedModel.lastName, _selectedModel.agencyName];
    [self allPreviousComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IB actions

- (IBAction)gobackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveAction:(id)sender {
    
    SaveCallsManager *manager = [SaveCallsManager new];
    manager.delegate = self;
    [manager saveComments:_addCommentTextField.text withId:[NSString stringWithFormat:@"%d", _selectedModel.recruiterId]];
}

#pragma mark - get previous comments

- (void)allPreviousComments {
    [_activityIndicator startAnimating];
    
    CallsInfoManager *manager = [CallsInfoManager new];
    manager.delegate = self;
    [manager allPreviousCommentsWithId:[NSString stringWithFormat:@"%d", _selectedModel.recruiterId]];
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_addCommentTextField resignFirstResponder];
    return YES;
}

#pragma mark - call info delegate

- (void)previousComments:(NSString *)text {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _previousCommentsTextView.text = text;
        [_activityIndicator stopAnimating];
    });
}

#pragma mark - save calls delegate

- (void)commentSaveSuccess:(BOOL)success {
    [self allPreviousComments];
}


@end

