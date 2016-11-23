//
//  TSMediaCell.h
//  TweetSearch
//
//  Created by Ulaş Sancak on 17/11/2016.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "TSTextCell.h"

static NSString *mediaCellIdentifier = @"TSMediaCell";
static CGFloat const MediaCellHeight = 201.0;

@interface TSMediaCell : TSTextCell

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@end
