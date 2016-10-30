//
//  SearchViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/6/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "SearchViewController.h"
#import "UserLoginViewController.h"
#import "Constants.h"
#import "DateSelectionViewController.h"
#import "SearchDateManager.h"
#import "SearchContentManager.h"
#import "SearchNameManager.h"
#import "RecruiterModel.h"
#import "RecruiterCell.h"
#import "AddEditRecruiter2ViewController.h"
#import "DeleteRecruiterManager.h"
//#import "SaveCallsViewController.h"
//#import "SaveCalls2ViewController.h"
#import "SaveCalls3ViewController.h"
#import "UserLoginViewController.h"


@interface SearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, DateSelectionViewControllerDelegate, SearchDateManagerDelegate, SearchContentManagerDelegate, SearchNameManagerDelegate, DeleteRecruiterManagerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *searchByDateButton;
@property (weak, nonatomic) IBOutlet UIButton *createNewButton;
@property (weak, nonatomic) IBOutlet UILabel *emptyNoteLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSArray *rowsArray;
@property (strong, nonatomic) RecruiterModel *selectedItem;

@property (strong, nonatomic) NSString *searchByCode;
@property (strong, nonatomic) NSString *selectedDateText;
@property (assign, nonatomic) BOOL isFirstTime;

@property (strong, nonatomic) UIAlertController *selectionAlert;
@property (strong, nonatomic) UIAlertController *deleteAlert;

@end


@implementation SearchViewController

NSString *searchCodeByName = @"searchCodeByName";
NSString *searchCodeByContent = @"searchCodeByContent";
NSString *searchCodeByDate = @"searchCodeByDate";

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.layer.borderColor = [UIColor blackColor].CGColor;
    _tableView.layer.borderWidth = 0.5;
    
    _searchByDateButton.layer.cornerRadius = 5;
    _searchByDateButton.clipsToBounds = YES;
    
    _createNewButton.layer.cornerRadius = 5;
    _createNewButton.clipsToBounds = YES;
    
    _rowsArray = [NSArray array];
    _emptyNoteLabel.hidden = NO;
    [_activityIndicator stopAnimating];
    
    _searchByCode = nil;
    _selectedDateText = nil;
    _isFirstTime = YES;
    
    //-- take off login
    //UserLoginViewController *loginVC = [[UserLoginViewController alloc] initWithNibName:@"UserLoginViewController" bundle:nil];
    //[self.navigationController pushViewController:loginVC animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _emptyNoteLabel.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_isFirstTime) {
        [self searchDataAction];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IB actions

- (IBAction)createNewAction:(id)sender {
    
    AddEditRecruiter2ViewController *info2 = [[AddEditRecruiter2ViewController alloc] initWithNibName:@"AddEditRecruiter2ViewController" bundle:nil];
    info2.selectedRecruiter = nil;
    [self.navigationController pushViewController:info2 animated:YES];
}

- (IBAction)searchByDate {
    
    _searchBar.text = nil;
    
    DateSelectionViewController *selectDate = [[DateSelectionViewController alloc] initWithNibName:@"DateSelectionViewController" bundle:nil];
    selectDate.delegate = self;
    [self presentViewController:selectDate animated:YES completion:nil];
}

- (IBAction)logoutAction:(id)sender {
    
    _searchBar.text = nil;
    
    _rowsArray = nil;
    _rowsArray = [NSArray array];
    [_tableView reloadData];
    
    UserLoginViewController *loginVC = [[UserLoginViewController alloc] initWithNibName:@"UserLoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:NO];
}

#pragma mark - search action

- (void)searchDataAction {
    
    if (_searchByCode.length > 0) {
        if ([_searchByCode isEqualToString:searchCodeByName] && _searchBar.text.length > 0) {
            [self startSearchingByName];
        }
        else if ([_searchByCode isEqualToString:searchCodeByContent] && _searchBar.text.length > 0) {
            [self startSearchingByContent];
        }
        else if ([_searchByCode isEqualToString:searchCodeByDate] && _selectedDateText.length > 0) {
            [self startSearchingByDate];
        }
    }
}


#pragma mark - search bar delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _searchBar.text = nil;
        _emptyNoteLabel.hidden = YES;
        
        _rowsArray = nil;
        _rowsArray = [NSArray array];
        [_tableView reloadData];
        
        [_activityIndicator stopAnimating];
    });
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"by Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self startSearchingByName];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"by Content" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self startSearchingByContent];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
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
    RecruiterCell *cell = (RecruiterCell *)[_tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"RecruiterCell" owner:self options:nil];
        if (nibs.count > 0) {
            cell = [nibs objectAtIndex:0];
        }
    }
    
    RecruiterModel *model = [_rowsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"Name : %@ %@", model.firstName, model.lastName];
    cell.agencyLabel.text = [NSString stringWithFormat:@"Agency : %@", model.agencyName];
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedItem = [_rowsArray objectAtIndex:indexPath.row];
    [self selectRecruiterAction];
}

#pragma mark - date select delegate

- (void)selectedDateText:(NSString *)dateText {
    _selectedDateText = dateText;
    [self startSearchingByDate];
}

#pragma mark - search action

- (void)startSearchingByName {
    [self UIChangesForStartingSearch];
    
    SearchNameManager *manager = [SearchNameManager new];
    manager.delegate = self;
    [manager searchByName:_searchBar.text];
}

- (void)startSearchingByContent {
    [self UIChangesForStartingSearch];
    
    SearchContentManager *manager = [SearchContentManager new];
    manager.delegate = self;
    [manager searchByContent:_searchBar.text];
}

- (void)startSearchingByDate {
    [self UIChangesForStartingSearch];
    
    SearchDateManager *manager = [SearchDateManager new];
    manager.delegate = self;
    [manager searchByDate:_selectedDateText];
}

- (void)UIChangesForStartingSearch {
    
    _searchByCode = searchCodeByName;
    _emptyNoteLabel.hidden = YES;
    [_activityIndicator startAnimating];
}

#pragma mark - search results delegate

- (void)byDateSearchResults:(NSArray *)list {
    [self updateList:list searchBy:@"by Date"];
}

- (void)byContentSearchResults:(NSArray *)list {
    [self updateList:list searchBy:@"by Content"];
}

- (void)byNameSearchResults:(NSArray *)list {
    [self updateList:list searchBy:@"by Name"];
}

- (void)updateList:(NSArray *)list searchBy:(NSString *)code {
    
    //-- testing print
    NSLog(@"search result by %@:\n\n", code);
    for (RecruiterModel *each in list) {
        NSLog(@"Name : %@ %@, Agency : %@", each.firstName, each.lastName, each.agencyName);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _rowsArray = list;
        [_tableView reloadData];
        
        if (_rowsArray.count > 0)
            _emptyNoteLabel.hidden = YES;
        else
            _emptyNoteLabel.hidden = NO;
        
        [_activityIndicator stopAnimating];
    });
}

#pragma mark - recruiter selected

- (void)selectRecruiterAction {
    
    _selectionAlert = [UIAlertController alertControllerWithTitle:nil
                                                          message:nil
                                                   preferredStyle:UIAlertControllerStyleActionSheet];
    
    [_selectionAlert addAction:[UIAlertAction actionWithTitle:@"Calling Info" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveCallingInfo];
        [_selectionAlert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [_selectionAlert addAction:[UIAlertAction actionWithTitle:@"Edit Recruiter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editSelectedRecruiter];
        [_selectionAlert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [_selectionAlert addAction:[UIAlertAction actionWithTitle:@"Delete Recruiter" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteSeletedRecruiter];
        [_selectionAlert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [_selectionAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        _selectedItem = nil;
        [_selectionAlert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:_selectionAlert animated:YES completion:nil];
}

- (void)saveCallingInfo {
    _isFirstTime = NO;
    
//    SaveCalls2ViewController *calls = [[SaveCalls2ViewController alloc] initWithNibName:@"SaveCalls2ViewController" bundle:nil];
//    calls.selectedModel = _selectedItem;
//    [self.navigationController pushViewController:calls animated:YES];
    
    SaveCalls3ViewController *calls = [[SaveCalls3ViewController alloc] initWithNibName:@"SaveCalls3ViewController" bundle:nil];
    calls.selectedModel = _selectedItem;
    [self.navigationController pushViewController:calls animated:YES];
    
}

- (void)editSelectedRecruiter {
    _isFirstTime = NO;
    
    AddEditRecruiter2ViewController *info2 = [[AddEditRecruiter2ViewController alloc] initWithNibName:@"AddEditRecruiter2ViewController" bundle:nil];
    info2.selectedRecruiter = _selectedItem;
    [self.navigationController pushViewController:info2 animated:YES];
}

- (void)deleteSeletedRecruiter {
    _isFirstTime = NO;
    
    _deleteAlert = [UIAlertController alertControllerWithTitle:nil message:@"The recruiter and all of its comments will be deleted." preferredStyle:UIAlertControllerStyleAlert];
    
    [_deleteAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteRecruiterAndCommets];
        [_deleteAlert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [_deleteAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [_deleteAlert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:_deleteAlert animated:YES completion:nil];
}

- (void)deleteRecruiterAndCommets {
    
    [_activityIndicator startAnimating];
    DeleteRecruiterManager *manager = [DeleteRecruiterManager new];
    manager.delegate = self;
    [manager deleteRecruiterWithId:[NSString stringWithFormat:@"%d", _selectedItem.recruiterId]];
}

#pragma mark - delete recruiter delegate

- (void)deleteRecruiterSuccess:(BOOL)success {
    [self searchDataAction];
}


@end

