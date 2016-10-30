//
//  EnterCommentsViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/28/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "EnterCommentsViewController.h"


@interface EnterCommentsViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end


@implementation EnterCommentsViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cancelButton.layer.cornerRadius = 5;
    _cancelButton.clipsToBounds = YES;
    
    _saveButton.layer.cornerRadius = 5;
    _saveButton.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _textField.text = _commentText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IB action

- (IBAction)cancelAction:(id)sender {
    [self.delegate userComments:nil];
}

- (IBAction)saveAction:(id)sender {
    [self.delegate userComments:_textField.text];
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_textField resignFirstResponder];
    return YES;
}

@end
