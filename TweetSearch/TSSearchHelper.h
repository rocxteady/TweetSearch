//
//  TSSearchHelper.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSAPIClient.h"

@interface TSSearchHelper : NSObject

@property (nonatomic, readonly, getter=isSearching) BOOL searching;

- (void)searchWithQuery:(NSString *)searchQuery block:(TSAPIClientSearchBlock)block;

- (void)stop;

@end
