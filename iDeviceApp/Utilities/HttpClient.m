//
//  HttpClient.m
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient ()

@end

@implementation HttpClient

- (void)getForeCastFor:(NSString *)locale{
    NSString *urlString = @"http://api.openweathermap.org/data/2.5/forecast?appid=5d5fb2abfc152ac8380b7c62c2b0e8cd&units=imperial&q=";
    urlString = [urlString stringByAppendingString:[locale stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    if (url != nil) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"Get";
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

        dispatch_queue_t utiltityQueue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);

        dispatch_sync(utiltityQueue, ^{
            NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                          dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              if ((error != nil) && (response != nil)){
                                                  [self.delegate requestFailedWithResponse:response andError:error];
                                              } else {
                                                  if ((response != nil) && (data != nil)){
                                                      [self.delegate requestSucceededWithResponse:response andData:data];
                                                  }
                                              }
                                          }];
            [task resume];
        });
    }
}

@end
