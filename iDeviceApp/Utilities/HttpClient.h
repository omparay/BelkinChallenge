//
//  HttpClient.h
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HttpClientProtocol

@required
- (void)requestSucceededWithResponse:(NSURLResponse *)response andData:(NSData *)data;
- (void)requestFailedWithResponse:(NSURLResponse *)response andError:(NSError *)error;

@end

@interface HttpClient : NSObject

@property (weak,nonatomic) id<HttpClientProtocol> delegate;

- (void)getForeCastFor:(NSString *)locale;

@end

NS_ASSUME_NONNULL_END
