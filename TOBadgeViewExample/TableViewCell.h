//
//  TableViewCell.h
//  TOBadgeViewExample
//
//  Created by Tim Oliver on 8/11/18.
//  Copyright © 2018 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOBadgeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet TOBadgeView *badgeView;

@end

NS_ASSUME_NONNULL_END
