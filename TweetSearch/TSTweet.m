//
//  TSTweet.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSTweet.h"

@implementation TSTweet

- (void)setCreatedAt:(NSString *)createdAt {
    _createdAt = createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    _createdAtDate = [dateFormatter dateFromString:_createdAt];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    _createdAtReadable = [dateFormatter stringFromDate:_createdAtDate];
}

@end

@implementation TSMediaSize

@end

@implementation TSMediaSizes

@end

@implementation TSMediaData

- (void)setMediaUrlHttps:(NSString *)mediaUrlHttps {
    _mediaUrlHttps = mediaUrlHttps;
    _mediaThumbUrl = [NSString stringWithFormat:@"%@:thumb", mediaUrlHttps];
    _mediaLargeUrl = [NSString stringWithFormat:@"%@:large", mediaUrlHttps];
}

@end

@implementation TSEntities

@end
