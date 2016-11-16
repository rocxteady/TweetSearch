//
//  TSAPIClient.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 16/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TSAPIClientBooleanBlock)(BOOL result, NSError *error);

@interface TSAPIClient : NSObject

+ (TSAPIClient *)sharedClient;

- (void)auth:(TSAPIClientBooleanBlock)block;

@end
