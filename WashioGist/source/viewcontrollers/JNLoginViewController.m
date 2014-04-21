//
//  JNLoginViewController.m
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import "JNLoginViewController.h"

#import "JNMainMenuViewController.h"
#import "MBProgressHUD.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <Parse/Parse.h>


@interface JNLoginViewController ()

@end

@implementation JNLoginViewController

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
    
    // Check if user is cached and linked to Facebook, if so, bypass login
//    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
//        [self.navigationController pushViewController:[[JNMainViewController alloc] initWithNibName:@"JNMainViewController" bundle:nil] animated:NO];
//    }
}


/* Login to facebook method */
- (IBAction)loginButtonTouchHandler:(id)sender  {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    __weak __typeof(self)weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Logging in...";
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //[_activityIndicator stopAnimating]; // Hide loading indicator

        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
//            JNMainMenuViewController *mainVC = [[JNMainMenuViewController alloc] initWithNibName:@"JNMainMenuViewController" bundle:nil];
//           [self.navigationController pushViewController:mainVC animated:YES];
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [weakSelf getFBUserInfo];

        } else {
            NSLog(@"User with facebook logged in!");
//            JNMainMenuViewController *mainVC = [[JNMainMenuViewController alloc] initWithNibName:@"JNMainMenuViewController" bundle:nil];
//            [self.navigationController pushViewController:mainVC animated:YES];
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [weakSelf getFBUserInfo];
        }
    }];
    
    //[_activityIndicator startAnimating]; // Show loading indicator until login is finished
}


- (void)getFBUserInfo {
    // Send request to Facebook
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            if (userData[@"name"]) {
                userProfile[@"name"] = userData[@"name"];
            }
            
            if (userData[@"location"][@"name"]) {
                userProfile[@"location"] = userData[@"location"][@"name"];
            }
            
            if (userData[@"gender"]) {
                userProfile[@"gender"] = userData[@"gender"];
            }
            
            if (userData[@"birthday"]) {
                userProfile[@"birthday"] = userData[@"birthday"];
            }
            
            if (userData[@"relationship_status"]) {
                userProfile[@"relationship"] = userData[@"relationship_status"];
            }
            
            if ([pictureURL absoluteString]) {
                userProfile[@"pictureURL"] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *errorBlock) {
                if (!!succeeded) {
                    //succeeded
                    JNMainMenuViewController *mainVC = [[JNMainMenuViewController alloc] initWithNibName:@"JNMainMenuViewController" bundle:nil];
                    [self.navigationController pushViewController:mainVC animated:YES];
                } else {
                    // failed
                    NSLog(@"failure block");
                }
            }];
            
            //[self updateProfile];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            //[self logoutButtonTouchHandler:nil];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
    
}




@end
