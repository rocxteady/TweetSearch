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
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

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
    _usernameLabel.text = _tweet.user.twitterScreenName;
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_tweet.user.profileImageUrlHttps]];
    _statusLabel.text = _tweet.text;
    TSMediaData *mediaData = _tweet.entities.media[0];
    [_statusImageView sd_setImageWithURL:[NSURL URLWithString:mediaData.mediaThumbUrl]];
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
