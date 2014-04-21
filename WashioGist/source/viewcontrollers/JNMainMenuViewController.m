//
//  JNMainMenuViewController.m
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import "JNMainMenuViewController.h"
#import <Parse/Parse.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "MBProgressHUD.h"
#import "JNEachRoundViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface JNMainMenuViewController ()
@property (nonatomic, weak) IBOutlet UIButton *playGameButton;
@property (nonatomic, weak) IBOutlet UIImageView *faceImageView;
@property (nonatomic, weak) IBOutlet UILabel *currentScoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *fbNameLabel;
@end

@implementation JNMainMenuViewController
@synthesize playGameButton = _playGameButton;
@synthesize faceImageView = _faceImageView;
@synthesize currentScoreLabel = _currentScoreLabel;
@synthesize fbNameLabel = _fbNameLabel;

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
    self.navigationController.title = @"Facebook Main Menu Profile";
    self.title = @"iOS Challenge MainMenu";
    
    //update the labels and imageViews
    _fbNameLabel.text = [[[PFUser currentUser] objectForKey:@"profile"] objectForKey:@"name"];
    self.appManager.currentScore = 0;
    [self.appManager resetCurrentRound];
    self.currentScoreLabel.text = [NSString stringWithFormat:@"%i",self.appManager.currentScore];
    //get the imageView for my profile picture
    [self getFacebookImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)getFacebookImage {
    __weak __typeof(self)weakSelf = self;
    NSURL *imageURL = [NSURL URLWithString:[[[PFUser currentUser] objectForKey:@"profile"] objectForKey:@"pictureURL"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:imageURL];
    [_faceImageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"placeholder-image"]
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

- (IBAction)playButtonPressed:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self)weakSelf = self;
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        [weakSelf.appManager assignFacebookFriends:friends];
        JNEachRoundViewController *eachRoundVC = [[JNEachRoundViewController alloc] initWithNibName:@"JNEachRoundViewController" bundle:nil];
        eachRoundVC.userBeingTested = (NSDictionary *)[self.appManager getRandomFriend];
//facebook picture profile
//        https://graph.facebook.com/[profile_id]/picture

        [weakSelf.navigationController pushViewController:eachRoundVC animated:YES];
        // 1

    }];
}


//NSLog(@"Found: %i friends", friends.count);
//        for (NSDictionary<FBGraphUser>* friend in friends) {
//            NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
//        }



@end
