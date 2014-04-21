//
//  JNBaseViewController.m
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import "JNBaseViewController.h"

#import "JNAppManager.h"
#import "JNAppDelegate.h"

@interface JNBaseViewController ()
@property (weak, nonatomic) JNAppManager *appManager;
@end

@implementation JNBaseViewController
@synthesize appManager = _appManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _appManager = [(JNAppDelegate *)[[UIApplication sharedApplication] delegate] appManager];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        // Custom initialization
        _appManager = [(JNAppDelegate *)[[UIApplication sharedApplication] delegate] appManager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
