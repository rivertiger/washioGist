//
//  JNSummaryViewController.m
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import "JNSummaryViewController.h"

#import "JNMainMenuViewController.h"

// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface JNSummaryViewController ()
@property (nonatomic, weak) IBOutlet UILabel *totalScoreLabel;
@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implmentation


@implementation JNSummaryViewController
@synthesize totalScoreLabel = _totalScoreLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.hidesBackButton = YES;

    _totalScoreLabel.text = [NSString stringWithFormat:@"%i", self.appManager.currentScore];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)startOverButtonPressed:(id)sender {
    JNMainMenuViewController *mainMenuVC = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:mainMenuVC animated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
