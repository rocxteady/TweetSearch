//
//  TSTweetSearchViewController+DataHelper.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSTweetSearchViewController+DataHelper.h"
#import "TSTweetSearchViewController+Private.h"

@implementation TSTweetSearchViewController (DataHelper)

- (void)removeTweets {
    if (self.tweets.count == 0) {
        return;
    }
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.tweets.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    [self.tweets removeAllObjects];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addNewTweets:(NSArray *)tweets {
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger i = self.tweets.count; i < self.tweets.count + tweets.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    [self.tweets addObjectsFromArray:tweets];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

@end
