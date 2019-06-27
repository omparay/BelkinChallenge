//
//  SearchViewController.m
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import "SearchViewController.h"
#import "ForecastViewController.h"

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

//MARK: Methonds

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [[HttpClient alloc] init];
    self.client.delegate = self;
    self.alert = [UIAlertController alertControllerWithTitle:@"Ooops..." message:@"Something unexpected happened." preferredStyle:UIAlertControllerStyleAlert];
    [self.alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.activityIndicator.hidden = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toToday"]){
        ForecastViewController *controller = (ForecastViewController *)segue.destinationViewController;
        controller.ForecastData = self.results;
    }
}

- (void)processData:(NSData *)data {
    NSError *parsingError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&parsingError];
    if (parsingError != nil){
        [self showAlert];
    } else {
        self.results = json;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Received Data:\n %@",json);
            [self performSegueWithIdentifier:@"toToday" sender:self];
        });
    }
}

- (void)startForecastFor:(NSString *)city{
    if (city != nil) {
        [self searchAnimation:YES];
        [self.client getForeCastFor:city];
    }
}

- (void)searchAnimation:(BOOL)start{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (start){
            [self.activityIndicator startAnimating];
        } else {
            [self.activityIndicator stopAnimating];
        }
        self.activityIndicator.hidden = !start;
        self.searchButton.enabled = !start;
    });
}

- (void)showAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:self.alert animated:YES completion:nil];
    });
}

//MARK: Delegates

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self startForecastFor:textField.text];
}

- (void)requestFailedWithResponse:(nonnull NSURLResponse *)response andError:(nonnull NSError *)error {
    [self searchAnimation:NO];
    [self showAlert];
}

- (void)requestSucceededWithResponse:(nonnull NSURLResponse *)response andData:(nonnull NSData *)data {
    [self searchAnimation:NO];
    [self processData:data];
}

//AMRK: Actions

- (IBAction)buttonPressed:(UIButton *)sender{
    if (sender == self.clearButton){
        self.results = nil;
        self.textField.text = nil;
    }
    if (sender == self.searchButton){
        if (self.textField.text != nil) {

        }
    }
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)segue {
    
}

@end
