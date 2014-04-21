//
//  JNEachRoundViewController.m
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import "JNEachRoundViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "JNSummaryViewController.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface JNEachRoundViewController ()
@property (nonatomic, weak) IBOutlet UILabel *fnameLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;
@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implmentation


@implementation JNEachRoundViewController
@synthesize faceImageView = _faceImageView;
@synthesize userBeingTested = _userBeingTested;
@synthesize imageFromUser = _imageFromUser;
@synthesize fnameLabel = _fnameLabel;
@synthesize textField = _textField;
@synthesize scoreLabel = _scoreLabel;
@synthesize resultLabel = _resultLabel;

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
    _textField.delegate = self;
    NSString *roundTitle = [NSString stringWithFormat:@"Round #%i", [self.appManager getCurrentRound]];
    self.title = roundTitle;
    _fnameLabel.text = [_userBeingTested objectForKey:@"first_name"];
    _fnameLabel.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.appManager.currentScore];
    self.scoreLabel.hidden = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 1
    NSString *string = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", (NSString *)[self.userBeingTested objectForKey:@"id"]];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        __weak __typeof(self)weakSelf = self;
    
    
    [self.faceImageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"placeholder-image"]
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                   weakSelf.faceImageView.alpha = 0.0;
                                   weakSelf.faceImageView.image = image;
                                   [UIView animateWithDuration:0.25
                                                    animations:^{
                                                        weakSelf.faceImageView.alpha = 1.0;
                                                    }];
                               }
                               failure:NULL];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    
    if ([textField.text isEqualToString:[self.userBeingTested objectForKey:@"first_name"]]) {
        //right answer
        [self.appManager incrementScore];
        _scoreLabel.text = [NSString stringWithFormat:@"%i", self.appManager.currentScore];
        _resultLabel.text = @"Correct!";
        _resultLabel.textColor = [UIColor greenColor];
    } else {
        //wrong answer
        _resultLabel.text = @"Incorrect!";
        _resultLabel.textColor = [UIColor redColor];
        
    }
    NSDictionary *user = (NSDictionary *)[self.appManager getRandomFriend];
    [self.appManager incrementCurrentRound];
    
    if ([self.appManager getCurrentRound] != 11) {
        JNEachRoundViewController *nextRound = [[JNEachRoundViewController alloc] initWithNibName:@"JNEachRoundViewController" bundle:nil];
        nextRound.userBeingTested = user;
        [self.navigationController pushViewController:nextRound animated:YES];
    } else {
        //reached 10
        JNSummaryViewController *summaryVC = [[JNSummaryViewController alloc] initWithNibName:@"JNSummaryViewController" bundle:nil];

        [self.navigationController pushViewController:summaryVC animated:YES];
    }
    return YES;
}

@end
