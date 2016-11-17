//
//  TSAPIClient.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 16/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSAPIClient.h"
#import <AFNetworking/AFNetworking.h>
#import "TSConstants.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
#import "NSString+URLQuery.h"

typedef void (^TSAPIClientStringBlock)(NSString *response, NSError *error);
typedef void (^TSAPIClientDictionaryBlock)(NSDictionary *response, NSError *error);

static NSString *const OAUTHTokenURL = @"https://api.twitter.com/oauth2/token";
static NSString *const SearchURL = @"https://api.twitter.com/1.1/search/tweets.json";

@interface TSAPIClient ()

@property (strong, nonatomic) NSString *bearerTokenCredentials;
@property (strong, nonatomic) NSURLSessionConfiguration *configuration;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) AFHTTPRequestSerializer *queryRequestSerializer;
@property (weak, nonatomic) NSURLSessionDataTask *searchDataTask;
@property (strong, nonatomic) NSString *bearerToken;

@end

@implementation TSAPIClient

#pragma mark - Public

- (void)auth:(TSAPIClientBooleanBlock)block {
    [self getBearerToken:^(NSString *response, NSError *error) {
        if (error) {
            block(NO, error);
        }
        else {
            [self saveBearerToken:response];
            block(YES, nil);
        }
    }];
}

- (NSURLSessionDataTask *)searchWithQuery:(NSString *)searchQuery block:(TSAPIClientSearchBlock)block {
    return [self getSearchResultWithQuery:searchQuery block:^(NSDictionary *response, NSError *error) {
        if (!error) {
            TSSearchResult *result = [[TSSearchResult alloc] initWithDictionary:response error:&error];
            block(result, error);
        }
        else {
            block(nil, error);
        }
    }];
}

#pragma mark - Private

+ (TSAPIClient *)sharedClient {
    static id sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    return sharedClient;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createBearerTokenCredentials];
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_configuration];
    }
    return self;
}

//Getting bearer token for authorization from Twitter API
- (void)getBearerToken:(TSAPIClientStringBlock)block {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_configuration];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:[NSString stringWithFormat:@"Basic %@", _bearerTokenCredentials] forHTTPHeaderField:@"Authorization"];
    manager.requestSerializer = requestSerializer;
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:OAUTHTokenURL parameters:@{@"grant_type": @"client_credentials"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject[@"access_token"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}

- (NSURLSessionDataTask *)getSearchResultWithQuery:(NSString *)query block:(TSAPIClientDictionaryBlock)block{
    if (_searchDataTask && _searchDataTask.state == NSURLSessionTaskStateRunning) {
        [_searchDataTask cancel];
    }
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_configuration];
    AFHTTPRequestSerializer *requestSerializer = [self queryRequestSerializer];
    manager.requestSerializer = requestSerializer;
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    _searchDataTask = [manager GET:SearchURL parameters:[query dictionaryQueryParams] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
    return _searchDataTask;
}


// Generating generic serializer for Twitter API Requests

- (AFHTTPRequestSerializer *)queryRequestSerializer {
    if (!_queryRequestSerializer) {
        _queryRequestSerializer = [AFHTTPRequestSerializer serializer];
        [_queryRequestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", self.bearerToken] forHTTPHeaderField:@"Authorization"];
    }
    return _queryRequestSerializer;
}

//Getting bearer token for Twitter API Request Authentication

- (NSString *)bearerToken {
    if (!_bearerToken) {
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KeychainTokenService];
        _bearerToken = keychain[@"token"];
    }
    return _bearerToken;
}

//Creating bearer token for first authentication with Twitter
- (void)createBearerTokenCredentials {
    NSString *tokenCredentials = [NSString stringWithFormat:@"%@:%@", TwitterConsumerKey, TwitterConsumerSecret];
    NSData *data = [tokenCredentials dataUsingEncoding:NSUTF8StringEncoding];
    _bearerTokenCredentials = [data base64EncodedStringWithOptions:kNilOptions];
}

//Saving the bearer token to Keychain for further requets
- (void)saveBearerToken:(NSString *)bearerToken {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KeychainTokenService];
    keychain[@"token"] = bearerToken;
}

@end
