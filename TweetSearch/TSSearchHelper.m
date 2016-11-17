//
//  TSSearchHelper.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSSearchHelper.h"

@interface TSSearchHelper ()

@property (weak, nonatomic) NSURLSessionDataTask *searchDataTask;

@end

@implementation TSSearchHelper

- (void)searchWithQuery:(NSString *)searchQuery block:(TSAPIClientSearchBlock)block {
    [self stop];
    _searchDataTask = [[TSAPIClient sharedClient] searchWithQuery:searchQuery block:block];
}

- (void)stop {
    if (self.isSearching) {
        [_searchDataTask cancel];
    }
}

- (BOOL)isSearching {
    if (_searchDataTask && _searchDataTask.state == NSURLSessionTaskStateRunning) {
        return YES;
    }
    return NO;
}

@end
