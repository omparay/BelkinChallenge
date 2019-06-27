//
//  ForecastViewController.m
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import "ForecastViewController.h"
#import "NSDictionary+OpenWeatherData.h"

@interface ForecastViewController ()
{
    NSDictionary *fiveDayForecast;
    NSArray *sortedKeys;
}
@end

@implementation ForecastViewController

//MARK: Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.ForecastData != nil){
        fiveDayForecast = [self.ForecastData fiveDayForecast];
        sortedKeys = [[fiveDayForecast allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *string1 = (NSString *)obj1;
            NSString *string2 = (NSString *)obj2;
            return [string1 caseInsensitiveCompare:string2];
        }];
        NSLog(@"Sorted Keys:\n%@",sortedKeys);
        [self.tableView reloadData];
    }
}

//MARK: Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell" forIndexPath:indexPath];

    UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *weatherLabel = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel *tempLabel = (UILabel *)[cell.contentView viewWithTag:5];

    NSString *dateToDisplay = sortedKeys[indexPath.row];

    NSDictionary *dataToDisplay = fiveDayForecast[dateToDisplay];
    NSArray *weather = (NSArray *)[dataToDisplay valueForKeyPath:@"weather"];
    NSDictionary *first = weather[0];

    NSString *weatherDesc = [NSString stringWithFormat:@"%@",[first valueForKeyPath:@"main"]];
    NSString *temp = [NSString stringWithFormat:@"%@",[dataToDisplay valueForKeyPath:@"main.temp"]];

    dateLabel.text = dateToDisplay;
    weatherLabel.text = weatherDesc;
    tempLabel.text = temp;

    return cell;
}

@end
