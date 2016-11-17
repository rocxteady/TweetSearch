//
//  ViewController.m
//  TweetSearch
//
//  Created by Ulaş Sancak on 16/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TweetSearchViewController.h"
#import "TSAPIClient.h"

@interface TweetSearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation TweetSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[TSAPIClient sharedClient] auth:^(BOOL result, NSError *error) {
        if (result) {
            NSLog(@"Authentication success.");
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end