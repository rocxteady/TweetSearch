//
//  ViewController.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 16/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSTweetSearchViewController.h"
#import "TSAPIClient.h"
#import "TSTextCell.h"
#import "TSMediaCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TSTweetSearchViewController+Private.h"
#import "TSTweetSearchViewController+DataHelper.h"
#import "TSSearchHelper.h"

static NSString *textCellIdentifier = @"TSTextCell";
static NSString *mediaCellIdentifier = @"TSMediaCell";

typedef NS_ENUM(NSUInteger, DataStatus) {
    DataStatusIdle,
    DataStatusLoading,
    DataStatusFinished
};

@interface TSTweetSearchViewController () <UISearchControllerDelegate, UISearchBarDelegate>
{
    NSString *searchQuery;
    NSTimer *searchTimer;
    TSSearchHelper *searchHelper;
}
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) TSSearchMetedata *lastSearchMetaData;
@property (assign, nonatomic) DataStatus dataStatus;

@end

@implementation TSTweetSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    searchHelper = [TSSearchHelper new];
    [self setupSearchBar];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tweets = [NSMutableArray array];
}

- (void)setupSearchBar {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.placeholder = @"Search Tweets";
    self.navigationItem.titleView = self.searchController.searchBar;
    self.searchController.delegate = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.definesPresentationContext = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
}

- (void)resetData {
    [searchHelper stop];
    [self removeTweets];
}

#pragma mark - Search API
- (void)getTweets {
    _dataStatus = DataStatusLoading;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [searchHelper searchWithQuery:searchQuery block:^(TSSearchResult *result, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        _dataStatus = DataStatusIdle;
        if (!error) {
            _lastSearchMetaData = result.searchMetadata;
            if (_lastSearchMetaData.nextResults.length == 0) {
                _dataStatus = DataStatusFinished;
            }
            if (result.statuses.count > 0) {
                [self addNewTweets:result.statuses];
            }
        }
    }];
}

#pragma mark - Search Timer Handler
- (void)search {
    NSString *searchText = searchTimer.userInfo[@"searchText"];
    [self resetData];
    searchQuery = [NSString stringWithFormat:@"q=%@", searchText];
    [self getTweets];
}

#pragma mark - UISearchBar Delegates
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchTimer && searchTimer.isValid) {
        [searchTimer invalidate];
    }
    if (searchText.length == 0) {
        [self resetData];
        return;
    }
    searchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(search) userInfo:@{@"searchText": searchText} repeats:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self resetData];
}

#pragma mark - UITableViewDelegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *genericCell;
    TSTweet *tweet = self.tweets[indexPath.row];
    if (tweet.entities.media.count > 0) {
        TSMediaCell *cell = [tableView dequeueReusableCellWithIdentifier:mediaCellIdentifier forIndexPath:indexPath];
        cell.usernameLabel.text = tweet.user.twitterScreenName;
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrlHttps]];
        cell.statusLabel.text = tweet.text;
        TSMediaData *mediaData = tweet.entities.media[0];
        [cell.statusImageView sd_setImageWithURL:[NSURL URLWithString:mediaData.mediaThumbUrl]];
        genericCell = cell;
    }
    else {
        TSTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier forIndexPath:indexPath];
        cell.usernameLabel.text = tweet.user.twitterScreenName;
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrlHttps]];
        cell.statusLabel.text = tweet.text;
        genericCell = cell;
    }
    
    if (indexPath.row == self.tweets.count - 1 && _dataStatus == DataStatusIdle) {
        searchQuery = _lastSearchMetaData.nextResults;
        [self getTweets];
    }
    
    return genericCell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSTweet *tweet = self.tweets[indexPath.row];
    if (tweet.entities.media) {
        return 201.0;
    }
    return 47.0;
}

#pragma mark - UIScrollView Delegates

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_searchController.searchBar.isFirstResponder) {
        [_searchController.searchBar resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
