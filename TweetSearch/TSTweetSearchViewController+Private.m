//
//  TSTweetSearchViewController+Private.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSTweetSearchViewController+Private.h"
#import <objc/runtime.h>

@implementation TSTweetSearchViewController (Private)

@dynamic tweets;

- (void)setTweets:(NSMutableArray *)tweets {
    objc_setAssociatedObject(self, @selector(tweets), tweets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)tweets {
    return objc_getAssociatedObject(self, @selector(tweets));
}

@end
