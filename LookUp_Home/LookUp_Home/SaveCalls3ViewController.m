//
//  SaveCalls3ViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/28/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SaveCalls3ViewController.h"
#import "SaveCalls2Cell.h"
#import "SaveCalls2Model.h"
#import "RecruiterModel.h"
#import "EnterCommentsViewController.h"
#import "CallsInfoManager.h"
#import "SaveCallsManager.h"
#import "EditCallsManager.h"
#import "DeleteCallsManager.h"


@interface SaveCalls3ViewController () <UITableViewDataSource, UITableViewDelegate, CallsInfoManagerDelegate, SaveCallsManagerDelegate, EditCallsManagerDelegate, DeleteCallsManagerDelegate, EnterCommentsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameAgencyLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *createNewButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSArray *rowsArray;
@property (strong, nonatomic) EnterCommentsViewController *commentsVC;
@property (strong, nonatomic) SaveCalls2Model *selectedCallsItem;

@end


@implementation SaveCalls3ViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_activityIndicator stopAnimating];
    
    _tableView.layer.borderColor = [UIColor blackColor].CGColor;
    _tableView.layer.borderWidth = 0.5;
    
    _createNewButton.layer.cornerRadius = 5;
    _createNewButton.clipsToBounds = YES;
    
    _rowsArray = [NSArray array];
    _commentsVC = nil;
    _selectedCallsItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _nameAgencyLabel.text = [NSString stringWithFormat:@"Name : %@ %@ (%@)", _selectedModel.firstName, _selectedModel.lastName, _selectedModel.agencyName];
    [self allPreviousComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IB action

- (IBAction)gobackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)createNewAction:(id)sender {
    
    //-- add new comments
    _commentsVC = [[EnterCommentsViewController alloc] initWithNibName:@"EnterCommentsViewController" bundle:nil];
    _commentsVC.delegate = self;
    _commentsVC.commentText = nil;
    
    [self addChildViewController:_commentsVC];
    [self.view addSubview:_commentsVC.view];
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
        NSArray *ribs = [[NSBundle mainBundle] loadNibNamed:@"SaveCalls2Cell" owner:self options:nil];
        if (ribs.count > 0) {
            cell = [ribs objectAtIndex:0];
        }
    }
    
    SaveCalls2Model *item = [_rowsArray objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = item.dateText;
    cell.commentLabel.text = item.comments;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedCallsItem = [_rowsArray objectAtIndex:indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Comments"
                                                                   message:_selectedCallsItem.comments
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Edit Calling Info" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editCallsInfo];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Delete Calling Info" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteCallsInfo];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - comment page delegate

- (void)userComments:(NSString *)text {
    
    [_commentsVC.view removeFromSuperview];
    [_commentsVC removeFromParentViewController];
    _commentsVC = nil;
    
    if (text != nil && text.length > 0) {
        
        if (_selectedCallsItem == nil) {
            //-- create
            SaveCallsManager *manager = [SaveCallsManager new];
            manager.delegate = self;
            [manager saveComments:text withId:[NSString stringWithFormat:@"%d", _selectedModel.recruiterId]];
        }
        else {
            //-- edit
            EditCallsManager *manager = [EditCallsManager new];
            manager.delegate = self;
            [manager editComments:text withId:_selectedCallsItem.rid recruiterId:_selectedCallsItem.recruiterId];
        }
    }
}

#pragma mark - call info actions

- (void)allPreviousComments {
    
    //-- query all comments
    [_activityIndicator startAnimating];
    
    CallsInfoManager *manager = [CallsInfoManager new];
    manager.delegate = self;
    [manager allPreviousComments2WithId:[NSString stringWithFormat:@"%d", _selectedModel.recruiterId]];
}

- (void)editCallsInfo {
    
    //-- edit existing comment
    _commentsVC = [[EnterCommentsViewController alloc] initWithNibName:@"EnterCommentsViewController" bundle:nil];
    _commentsVC.delegate = self;
    _commentsVC.commentText = _selectedCallsItem.comments;
    
    [self addChildViewController:_commentsVC];
    [self.view addSubview:_commentsVC.view];
}

- (void)deleteCallsInfo {
    
    //-- delete existing comment
    [_activityIndicator startAnimating];
    
    DeleteCallsManager *manager = [DeleteCallsManager new];
    manager.delegate = self;
    [manager deleteCommentsWithId:_selectedCallsItem.rid recruiterId:_selectedCallsItem.recruiterId];
}

#pragma mark - call info delegate

- (void)previousComments2:(NSArray *)list {
    
    _rowsArray = list;
    if (_rowsArray == nil || _rowsArray.count == 0) {
        _rowsArray = nil;
        _rowsArray = [NSArray array];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
        [_activityIndicator stopAnimating];
    });
}

- (void)delteCommentSuccess:(BOOL)success {
    [self allPreviousComments];
}

- (void)commentSaveSuccess:(BOOL)success {
    [self allPreviousComments];
}

- (void)editCommentSuccess:(BOOL)success {
    [self allPreviousComments];
}


@end

