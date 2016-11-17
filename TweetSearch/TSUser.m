//
//  TSUser.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSUser.h"

@implementation TSUser

- (void)setScreenName:(NSString *)screenName {
    _screenName = screenName;
    _twitterScreenName = [NSString stringWithFormat:@"@%@", screenName];
}

@end
