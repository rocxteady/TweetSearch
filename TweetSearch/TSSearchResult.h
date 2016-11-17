//
//  TSSearchResult.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSBaseModel.h"
#import "TSTweet.h"

@class TSSearchMetedata;

@interface TSSearchResult : TSBaseModel

@property (strong, nonatomic) NSArray <TSTweet> *statuses;
@property (strong, nonatomic) TSSearchMetedata *searchMetadata;

@end

@interface TSSearchMetedata : TSBaseModel

@property (strong, nonatomic) NSString *maxIdStr;
@property (strong, nonatomic) NSString *nextResults;

@end
