//
//  DetailViewController.h
//  Invulnerable
//
//  Created by bailang on 1/15/16.
//  Copyright © 2016 bailang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end

@interface DetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (assign) NSInteger curIndex;

@end
