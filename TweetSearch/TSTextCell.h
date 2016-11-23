//
//  TSTextCell.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *textCellIdentifier = @"TSTextCell";
static CGFloat const textCellHeight = 47.0;

@interface TSTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
