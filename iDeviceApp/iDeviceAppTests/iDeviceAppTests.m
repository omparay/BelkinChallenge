//
//  iDeviceAppTests.m
//  iDeviceAppTests
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HttpClient.h"

@interface iDeviceAppTests : XCTestCase

@end

@implementation iDeviceAppTests

XCTestExpectation *expectation;

- (void)setUp {
}

- (void)tearDown {
}

- (void)testExample {
    XCTestExpectation *expectation = [self expectationWithDescription:@"OpenWeatherMap"];

    NSString *locale = @"Los Angeles,us";
    NSString *urlString = @"http://api.openweathermap.org/data/2.5/forecast?appid=5d5fb2abfc152ac8380b7c62c2b0e8cd&q=";
    urlString = [urlString stringByAppendingString:[locale stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];

    NSLog(@"Executing %@", urlString);


    NSURL *url = [[NSURL alloc] initWithString:urlString];

    if (url != nil) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"Get";
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

        NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                      dataTaskWithRequest:request
                                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                          if (error != nil){
                                              NSLog(@"%@", error.debugDescription);
                                              XCTFail(@"Error");
                                              [expectation fulfill];
                                          } else {
                                              if ([response isKindOfClass:[NSHTTPURLResponse class]]){
                                                  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                  XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP Status code was not 200...");

                                                  if (data != nil){
                                                      NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                      NSLog(@"Received: %@",jsonString);
                                                  } else {
                                                      XCTFail(@"No response data...");
                                                  }

                                              } else {
                                                  XCTFail(@"Unknown response type...");
                                              }
                                              [expectation fulfill];
                                          }
                                      }];
        [task resume];

        [self waitForExpectations:@[expectation] timeout:task.originalRequest.timeoutInterval];
    }

}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

@end
