//
//  TodayViewController.m
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import "TodayViewController.h"
#import "ForecastViewController.h"

@interface TodayViewController ()

@end

@implementation TodayViewController

//MARK: Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.ForecastData != nil){
        [self.tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toForecast"]){
        ForecastViewController *controller = (ForecastViewController *)segue.destinationViewController;
        controller.ForecastData = self.ForecastData;
    }
}

//MARK: Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 5){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:1];
        UILabel *infoLabel = (UILabel *)[cell.contentView viewWithTag:2];
        switch (indexPath.row) {
            case 0:
                titleLabel.text = @"City Name";
                infoLabel.text = [self.ForecastData valueForKeyPath:@"city.name"];
                break;
            case 1:
                titleLabel.text = @"Weather";
                infoLabel.text = [self.ForecastData valueForKeyPath:@""];
                break;
            case 2:
                titleLabel.text = @"Temperature";
                infoLabel.text = [self.ForecastData valueForKeyPath:@""];
                break;
            case 3:
                titleLabel.text = @"Humidity";
                infoLabel.text = [self.ForecastData valueForKeyPath:@""];
                break;
            case 4:
                titleLabel.text = @"Wind";
                infoLabel.text = [self.ForecastData valueForKeyPath:@""];
                break;
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionCell" forIndexPath:indexPath];
        cell.textLabel.text = @"Forecast";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5){
        [self performSegueWithIdentifier:@"toForecast" sender:self];
    }
}

@end
