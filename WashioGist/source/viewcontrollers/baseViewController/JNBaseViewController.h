//
//  JNBaseViewController.h
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNAppManager.h"

// *************************************************************************************************
#pragma mark -
#pragma mark Public Interface


@interface JNBaseViewController : UIViewController
@property (weak, nonatomic, readonly)  JNAppManager *appManager;


@end
