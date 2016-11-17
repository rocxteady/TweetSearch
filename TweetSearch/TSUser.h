//
//  TSUser.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSBaseModel.h"

@interface TSUser : TSBaseModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *profileImageUrlHttps;

@property (strong, nonatomic) NSString *twitterScreenName;

@end
