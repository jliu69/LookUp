//
//  DateSelectionViewController.m
//  LookUp
//
//  Created by Johnson Liu on 10/6/16.
//  Copyright © 2016 Home Office. All rights reserved.
//

#import "DateSelectionViewController.h"

@interface DateSelectionViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end


@implementation DateSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datePicker.layer.borderColor = [UIColor blackColor].CGColor;
    _datePicker.layer.borderWidth = 0.5;
    
    _cancelButton.layer.cornerRadius = 5;
    _cancelButton.clipsToBounds = YES;
    
    _selectButton.layer.cornerRadius = 5;
    _selectButton.clipsToBounds = YES;
    
    [_datePicker setDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)dateTextFromPicker {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:_datePicker.date];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectAction:(id)sender {
    
    [self.delegate selectedDateText:[self dateTextFromPicker]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
