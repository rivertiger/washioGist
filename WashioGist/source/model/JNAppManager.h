//
//  JNAppManager.h
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Facebook-iOS-SDK/FacebookSDK/FBGraphUser.h>

// *************************************************************************************************
#pragma mark -
#pragma mark Public interface


@interface JNAppManager : NSObject 
@property (nonatomic, assign) int currentScore;
@property (nonatomic, assign) int currentRound;
@property (nonatomic, strong, readonly) NSArray *facebookFriends;
@property (nonatomic, strong, readonly) NSMutableArray *randomizedFriendSample;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (int)getCurrentRound;
- (void)incrementCurrentRound;
- (void)resetCurrentRound;
- (void)incrementScore;
- (void)resetCurrentScore;

- (void)assignFacebookFriends:(NSArray *)arrayOfFriends;
- (NSDictionary<FBGraphUser> *)getRandomFriend;
@end
