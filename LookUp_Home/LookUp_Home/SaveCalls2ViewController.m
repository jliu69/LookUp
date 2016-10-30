//
//  SaveCalls2ViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/19/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SaveCalls2ViewController.h"
#import "RecruiterModel.h"
#import "SaveCalls2Cell.h"
#import "SaveCalls2Model.h"
#import "CallsInfoManager.h"
#import "SaveCallsManager.h"
#import "EditCallsManager.h"
#import "DeleteCallsManager.h"


@interface SaveCalls2ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CallsInfoManagerDelegate, SaveCallsManagerDelegate, EditCallsManagerDelegate, DeleteCallsManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameAgencyLabel;
@property (weak, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@property (strong, nonatomic) NSArray *rowsArray;
@property (strong, nonatomic) NSString *selectedCallsId;
@property (strong, nonatomic) NSString *callsInfoComment;
@property (assign, nonatomic) int selectedIndex;
@property (assign, nonatomic) BOOL isTextEditing;

@end


@implementation SaveCalls2ViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedCallsId = nil;
    _selectedIndex = -1;
    
    _saveButton.layer.cornerRadius = 5;
    _saveButton.clipsToBounds = YES;
    
    [_saveButton setTitle:@"Save New" forState:UIControlStateNormal];
    [_saveButton setTitle:@"Save New" forState:UIControlStateHighlighted];
    
    _tableView.layer.borderColor = [UIColor blackColor].CGColor;
    _tableView.layer.borderWidth = 0.5;
    
    _rowsArray = [NSArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _nameAgencyLabel.text = [NSString stringWithFormat:@"Name : %@ %@ (%@)", _selectedModel.firstName, _selectedModel.lastName, _selectedModel.agencyName];
    [self allPreviousComments];
    
    _backButton.title = @"Back";
    _isTextEditing = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IB actions

- (IBAction)gobackAction:(id)sender {
    
    if (_isTextEditing) {
        [self clearTextField];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveAction:(id)sender {
    
    if (_addCommentTextField.text == nil || _addCommentTextField.text.length == 0) {
        return;
    }
    
    [_activityIndicator startAnimating];
    _callsInfoComment = _addCommentTextField.text;
    [self clearTextField];
    
    if (_selectedCallsId == nil || _selectedCallsId.length == 0) {
        SaveCallsManager *manager = [SaveCallsManager new];
        manager.delegate = self;
        [manager saveComments:_callsInfoComment withId:[NSString stringWithFormat:@"%d", _selectedModel.recruiterId]];
    }
    else {
        EditCallsManager *manager = [EditCallsManager new];
        manager.delegate = self;
        [manager editComments:_callsInfoComment withId:_selectedCallsId];
    }
}

#pragma mark - call info actions

- (void)allPreviousComments {
    [_activityIndicator startAnimating];
    
    CallsInfoManager *manager = [CallsInfoManager new];
    manager.delegate = self;
    [manager allPreviousComments2WithId:[NSString stringWithFormat:@"%d", _selectedModel.recruiterId]];
}

- (void)clearTextField {
    _addCommentTextField.text = nil;
    [_addCommentTextField resignFirstResponder];
    _backButton.title = @"Back";
    _isTextEditing = NO;
    
    _selectedIndex = -1;
    [_tableView reloadData];
}

- (void)editCallsInfoWithId:(NSString *)callsInfoId comments:(NSString *)comments {
    
    _addCommentTextField.text = comments;
    
    _selectedCallsId = callsInfoId;
    [_saveButton setTitle:@"Save Edit" forState:UIControlStateNormal];
    [_saveButton setTitle:@"Save Edit" forState:UIControlStateHighlighted];
    [_addCommentTextField becomeFirstResponder];
}

- (void)deleteCallsInfoWithId:(NSString *)callsInfoId {
    [_activityIndicator startAnimating];
    
    DeleteCallsManager *manager = [DeleteCallsManager new];
    manager.delegate = self;
    [manager deleteCommentsWithId:callsInfoId];
}

#pragma mark - table view source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"CellId";
    SaveCalls2Cell *cell = (SaveCalls2Cell *)[_tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"SaveCalls2Cell" owner:self options:nil];
        if ([nibs count] > 0) {
            cell = [nibs objectAtIndex:0];
        }
    }
    
    SaveCalls2Model *item = [_rowsArray objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = item.dateText;
    cell.commentLabel.text = item.comments;
    
    if (_selectedIndex == (int)indexPath.row)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    SaveCalls2Model *item = [_rowsArray objectAtIndex:indexPath.row];
    
    _selectedIndex = (int)indexPath.row;
    [_tableView reloadData];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Comments"
                                                                   message:item.comments
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Edit Calling Info" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editCallsInfoWithId:item.rid comments:item.comments];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Delete Calling Info" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteCallsInfoWithId:item.rid];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self clearTextField];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_addCommentTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _isTextEditing = YES;
    _backButton.title = @"Clear";
}

#pragma mark - call info delegate

- (void)previousComments2:(NSArray *)list {
    
    if (list == nil || list.count == 0)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_addCommentTextField setText:nil];
        _rowsArray = list;
        _selectedIndex = -1;
        [_tableView reloadData];
        [_activityIndicator stopAnimating];
    });
}

- (void)commentSaveSuccess:(BOOL)success {
    _callsInfoComment = nil;
    [self allPreviousComments];
}

- (void)editCommentSuccess:(BOOL)success {
    _selectedCallsId = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_saveButton setTitle:@"Save New" forState:UIControlStateNormal];
        [_saveButton setTitle:@"Save New" forState:UIControlStateHighlighted];
    });
    [self allPreviousComments];
}

- (void)delteCommentSuccess:(BOOL)success {
    [self allPreviousComments];
}


@end

