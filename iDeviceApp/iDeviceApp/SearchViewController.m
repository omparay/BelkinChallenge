//
//  SearchViewController.m
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) NSDictionary *results;
@property (strong, nonatomic) HttpClient *client;
@end

@implementation SearchViewController

//

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [[HttpClient alloc] init];
    self.alert = [UIAlertController alertControllerWithTitle:@"Ooops..." message:@"Somethig unexpected happened." preferredStyle:UIAlertControllerStyleAlert];
    [self.alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

}

- (IBAction)buttonPressed:(UIButton *)sender{
    if (sender == self.clearButton){
        self.results = nil;
        self.textField.text = nil;
    }

}

- (IBAction)unwindSegue:(UIStoryboardSegue *)segue {
    
}

- (void)requestFailedWithResponse:(nonnull NSURLResponse *)response andError:(nonnull NSError *)error {
    [self presentViewController:self.alert animated:YES completion:nil];
}

- (void)requestSucceededWithResponse:(nonnull NSURLResponse *)response andData:(nonnull NSData *)data {
    
}

@end
