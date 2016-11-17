//
//  NSString+URLQuery.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "NSString+URLQuery.h"

@implementation NSString (URLQuery)

- (NSDictionary *)dictionaryQueryParams {
    NSString *query = [self stringByReplacingOccurrencesOfString:@"?" withString:@""];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [query componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    return params;
}

@end
