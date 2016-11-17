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

@end

@protocol TSMediaData;

@interface TSMediaData : TSBaseModel

@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *mediaUrlHttps;
@property (strong, nonatomic) NSString *mediaThumbUrl;

@end

@interface TSEntities : TSBaseModel

@property (strong, nonatomic) NSArray <TSMediaData> *media;

@end
