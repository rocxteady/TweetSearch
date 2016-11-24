//
//  TSTweet.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSBaseModel.h"
#import "TSUser.h"

@class TSEntities;

@protocol TSTweet;

@interface TSTweet : TSBaseModel

@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) TSUser *user;
@property (strong, nonatomic) TSEntities *entities;
@property (strong, nonatomic) NSString *createdAt;
@property (strong, nonatomic, readonly) NSDate *createdAtDate;
@property (strong, nonatomic, readonly) NSString *createdAtReadable;
@property (assign, nonatomic) NSUInteger retweetCount;
@property (assign, nonatomic) NSUInteger favoriteCount;

@end

@interface TSMediaSize : TSBaseModel

@property (strong, nonatomic) NSString *resize;
@property (assign, nonatomic) NSUInteger w;
@property (assign, nonatomic) NSUInteger h;

@end

@interface TSMediaSizes : TSBaseModel

@property (strong, nonatomic) TSMediaSize *medium;
@property (strong, nonatomic) TSMediaSize *large;
@property (strong, nonatomic) TSMediaSize *thumb;
@property (strong, nonatomic) TSMediaSize *small;

@end

@protocol TSMediaData;

@interface TSMediaData : TSBaseModel

@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *mediaUrlHttps;
@property (strong, nonatomic, readonly) NSString *mediaThumbUrl;
@property (strong, nonatomic, readonly) NSString *mediaLargeUrl;
@property (strong, nonatomic) TSMediaSizes *sizes;

@end

@interface TSEntities : TSBaseModel

@property (strong, nonatomic) NSArray <TSMediaData> *media;

@end
