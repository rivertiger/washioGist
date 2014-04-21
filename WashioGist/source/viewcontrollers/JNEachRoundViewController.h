//
//  JNEachRoundViewController.h
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JNBaseViewController.h"

@interface JNEachRoundViewController : JNBaseViewController <UITextFieldDelegate>
@property (nonatomic, strong) NSDictionary *userBeingTested;
@property (nonatomic, strong) UIImage *imageFromUser;
@property (nonatomic, weak) IBOutlet UIImageView *faceImageView;
@end
