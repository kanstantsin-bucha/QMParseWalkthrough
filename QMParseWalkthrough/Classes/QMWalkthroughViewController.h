//
//  QMWalkthroughViewController.h
//  truebucha
//
//  Created by Bucha Kanstantsin on 8/9/18.
//  Copyright © 2018 truebucha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CDBKit/CDBKit.h>

#define ascendingIndexKey @"Slide"
#define imageFileKey @"imageFile"

@interface QMWalkthroughViewController : UIViewController

+ (instancetype _Nonnull) controllerWithSourceParseClass: (NSString * _Nonnull) parseClass
                                              completion: (CDBErrorCompletion) completion;

@end
