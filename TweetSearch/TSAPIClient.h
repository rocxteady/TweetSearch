//
//  TSAPIClient.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 16/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSSearchResult.h"

typedef void (^TSAPIClientBooleanBlock)(BOOL result, NSError *error);

typedef void (^TSAPIClientSearchBlock)(TSSearchResult *result, NSError *error);

@interface TSAPIClient : NSObject

@property (nonatomic, readonly, getter=isAuthenticated) BOOL authenticated;

+ (TSAPIClient *)sharedClient;

- (void)auth:(TSAPIClientBooleanBlock)block;

- (NSURLSessionDataTask *)searchWithQuery:(NSString *)searchQuery block:(TSAPIClientSearchBlock)block;

@end
