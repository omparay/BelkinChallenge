//
//  SearchViewController.h
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController <UITextFieldDelegate,HttpClientProtocol>

@end

NS_ASSUME_NONNULL_END
