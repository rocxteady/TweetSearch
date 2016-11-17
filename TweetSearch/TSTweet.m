//
//  TSTweet.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSTweet.h"

@implementation TSTweet

@end

@implementation TSMediaData

- (void)setMediaUrlHttps:(NSString *)mediaUrlHttps {
    _mediaUrlHttps = mediaUrlHttps;
    _mediaThumbUrl = [NSString stringWithFormat:@"%@:thumb", mediaUrlHttps];
}

@end

@implementation TSEntities

@end
