//
//  AddEditRecruiter2ViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/20/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "AddEditRecruiter2ViewController.h"
#import "RecruiterModel.h"
#import "AddEditRecruiter2Cell.h"
#import "AddNewManager.h"
#import "UpdateExistingManager.h"
#import "DeleteRecruiterManager.h"
#import "RecruitersHelper.h"
#import "AppDelegate.h"


@interface AddEditRecruiter2ViewController () <UITableViewDataSource, UITableViewDelegate, AddNewManagerDelegate, UpdateExistingManagerDelegate, DeleteRecruiterManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *titleItem;

@end


@implementation AddEditRecruiter2ViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_activityIndicator stopAnimating];
    
    if (_selectedRecruiter == nil) {
        _titleItem.title = @"Add";
    }
    else {
        _titleItem.title = @"Edit";
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *uid = [appDele uid];
    NSLog(@"uid = '%@' ", uid);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_activityIndicator stopAnimating];
}

#pragma mark - IB actions

- (IBAction)gobackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - table view source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"CellId";
    AddEditRecruiter2Cell *cell = (AddEditRecruiter2Cell *)[_tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AddEditRecruiter2Cell" owner:self options:nil];
        if (nibs.count > 0) {
            cell = [nibs objectAtIndex:0];
        }
    }
    
    cell.parentVC = self;
    [cell selectedRecruiter:_selectedRecruiter];
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - data from cell

- (void)cellEditRecruiter:(RecruiterModel *)aRecruiter isNew:(BOOL)isNew {
    [_activityIndicator startAnimating];
    
    if (aRecruiter == nil) {
        [self alertMessage:@"Recruiter data cannot be null." withTitle:@"Warning"];
        [_activityIndicator stopAnimating];
        return;
    }
    if (aRecruiter.firstName.length == 0 || aRecruiter.lastName.length == 0) {
        [self alertMessage:@"Recruiter's first name or last name cannot be empty." withTitle:@"Warning"];
        [_activityIndicator stopAnimating];
        return;
    }
    
    if (isNew) {
        AddNewManager *manager = [AddNewManager new];
        manager.delegate = self;
        [manager addRecuiterWith:aRecruiter];
    }
    else {
        UpdateExistingManager *manager = [UpdateExistingManager new];
        manager.delegate = self;
        [manager updateRecuiterWith:aRecruiter];
    }
}

- (void)closePage {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - add delegate

- (void)addNewSuccess:(BOOL)success {
    [self closePage];
}

#pragma mark - edit delegate

- (void)updateExistingSuccess:(BOOL)success {
    [self closePage];
}

#pragma mark - show message

- (void)alertMessage:(NSString *)message withTitle:(NSString *)title {
    
    if (message == nil) message = @"";
    if (title == nil) title = @"";
    
    RecruitersHelper *helper = [RecruitersHelper new];
    [helper alertMessage:message title:title controller:self];
}


@end

