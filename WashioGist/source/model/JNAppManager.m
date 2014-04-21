//
//  JNAppManager.m
//  WashioGist
//
//  Created by jamesn on 4/20/14.
//  Copyright (c) 2014 Washio. All rights reserved.
//

#import "JNAppManager.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation JNAppManager
@synthesize currentScore = _currentScore;
@synthesize facebookFriends = _facebookFriends;
@synthesize randomizedFriendSample = _randomizedFriendSample;



// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides


- (id)init {
    if (self = [super init]) {
        //initializer
        _currentScore = 0;
        _currentRound = 0;
        _facebookFriends = [NSArray array];
        _randomizedFriendSample = [NSMutableArray array];
    }
    return self;
}

// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (int)getCurrentRound {
    return _currentRound;
}

- (void)incrementCurrentRound {
    _currentRound++;
}

- (void)resetCurrentRound {
    _currentRound = 0;
}


- (void)assignFacebookFriends:(NSArray *)arrayOfFriends {
    _facebookFriends = arrayOfFriends;
    //NSLog(@"friends are:%@", _facebookFriends);
    _randomizedFriendSample = [NSMutableArray arrayWithArray:_facebookFriends];
    [self shuffle];
    
}

- (NSDictionary<FBGraphUser>* )getRandomFriend {
    //        for (NSDictionary<FBGraphUser>* friend in friends) {
    //            NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
    //        }
    if ([_randomizedFriendSample count] == 0) {
        return nil;
    }
    NSDictionary<FBGraphUser>* aUser = [_randomizedFriendSample objectAtIndex: arc4random() % [_randomizedFriendSample count]];
    return aUser;
}


- (void)resetCurrentScore {
    _currentScore = 0;
}

- (void)incrementScore {
    _currentScore++;
}

// *************************************************************************************************
#pragma mark -
#pragma mark Private Methods


- (void)shuffle
{
    NSUInteger count = [_randomizedFriendSample count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [_randomizedFriendSample exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    NSLog(@"_randomizedSample is:%@", _randomizedFriendSample);
}



@end
