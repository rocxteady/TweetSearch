//
//  TweetDetailViewController.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 18/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSTweetDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TSTweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *tweetScrollView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *statusImageIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusImageLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusImageTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation TSTweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Setting main scroll view's content inset manually beacuse of the 3D touch preview.
    self.tweetScrollView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0);
    [self loadData];
}

- (void)loadData {
    if (_tweet.entities.media.count == 0) {
        [_statusImageView removeFromSuperview];
    }
    else {
        TSMediaData *mediaData = _tweet.entities.media[0];
        CGFloat mediaWidth = [UIScreen mainScreen].bounds.size.width - (_statusImageLeadingConstraint.constant + _statusImageTrailingConstraint.constant);
        CGFloat mediaHeight = mediaWidth * (CGFloat)mediaData.sizes.large.h/mediaData.sizes.large.w;
        _statusImageViewHeightConstraint.constant = mediaHeight;
        [_statusImageIndicator startAnimating];
        [_statusImageView sd_setImageWithURL:[NSURL URLWithString:mediaData.mediaLargeUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [_statusImageIndicator stopAnimating];
        }];
    }
    _usernameLabel.text = _tweet.user.twitterScreenName;
    _nameLabel.text = _tweet.user.name;
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_tweet.user.profileImageUrlHttps]];
    _statusLabel.text = _tweet.text;
    _dateLabel.text = _tweet.createdAtReadable;
    
    _retweetCountLabel.text = [NSString stringWithFormat:@"%lu", _tweet.retweetCount];
    _likeCountLabel.text = [NSString stringWithFormat:@"%lu", _tweet.favoriteCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
