//
//  AddEditRecruiter2Cell.m
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "AddEditRecruiter2Cell.h"
#import "RecruiterModel.h"
#import "AddEditRecruiter2ViewController.h"


@interface AddEditRecruiter2Cell()

@property (assign, nonatomic) BOOL isNew;
@property (strong, nonatomic) RecruiterModel *selectedRecriter;

@end


@implementation AddEditRecruiter2Cell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    _saveButton.layer.cornerRadius = 5;
    _saveButton.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)selectedRecruiter:(RecruiterModel *)aRecruiter {
    _selectedRecriter = aRecruiter;
    
    if (_selectedRecriter == nil) {
        _isNew = YES;
        _selectedRecriter = [RecruiterModel new];
        
        [_saveButton setTitle:@"Save New" forState:UIControlStateNormal];
        [_saveButton setTitle:@"Save New" forState:UIControlStateHighlighted];
    }
    else {
        _isNew = NO;
        [self populateData];
        
        [_saveButton setTitle:@"Save Update" forState:UIControlStateNormal];
        [_saveButton setTitle:@"Save Update" forState:UIControlStateHighlighted];
    }
}

- (void)populateData {
    
    [_firstNameTextField setText:_selectedRecriter.firstName];
    [_lastNameTextField setText:_selectedRecriter.lastName];
    [_middleInitialTextField setText:_selectedRecriter.middleInitial];
    [_agencyNameTextField setText:_selectedRecriter.agencyName];
    
    [_addressOneTextField setText:_selectedRecriter.address1];
    [_addressTwoTextField setText:_selectedRecriter.address2];
    [_cityTextField setText:_selectedRecriter.city];
    [_stateTextField setText:_selectedRecriter.state];
    [_zipcodeTextField setText:_selectedRecriter.zipcode];
    
    [_workPhoneTextField setText:_selectedRecriter.workPhone];
    [_workFaxTextField setText:_selectedRecriter.workFax];
    [_homeMobileTextField setText:_selectedRecriter.homeMobile];
    [_workEmailTextField setText:_selectedRecriter.workEmail];
    [_homeEmailTextField setText:_selectedRecriter.homeEmail];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_firstNameTextField resignFirstResponder];
    [_lastNameTextField resignFirstResponder];
    [_middleInitialTextField resignFirstResponder];
    [_agencyNameTextField resignFirstResponder];
    
    [_addressOneTextField resignFirstResponder];
    [_addressTwoTextField resignFirstResponder];
    [_cityTextField resignFirstResponder];
    [_stateTextField resignFirstResponder];
    [_zipcodeTextField resignFirstResponder];
    
    [_workPhoneTextField resignFirstResponder];
    [_workFaxTextField resignFirstResponder];
    [_homeMobileTextField resignFirstResponder];
    [_workEmailTextField resignFirstResponder];
    [_homeEmailTextField resignFirstResponder];
    
    return YES;
}

- (IBAction)saveAction:(id)sender {
    
    _selectedRecriter.firstName = _firstNameTextField.text;
    _selectedRecriter.lastName = _lastNameTextField.text;
    _selectedRecriter.middleInitial = _middleInitialTextField.text;
    _selectedRecriter.agencyName = _agencyNameTextField.text;
    
    _selectedRecriter.address1 = _addressOneTextField.text;
    _selectedRecriter.address2 = _addressTwoTextField.text;
    _selectedRecriter.city = _cityTextField.text;
    _selectedRecriter.state = _stateTextField.text;
    _selectedRecriter.zipcode = _zipcodeTextField.text;
    
    _selectedRecriter.workPhone = _workPhoneTextField.text;
    _selectedRecriter.workFax = _workFaxTextField.text;
    _selectedRecriter.homeMobile = _homeMobileTextField.text;
    _selectedRecriter.workEmail = _workEmailTextField.text;
    _selectedRecriter.homeEmail = _homeEmailTextField.text;
    
    [_parentVC cellEditRecruiter:_selectedRecriter isNew:_isNew];
}

@end

