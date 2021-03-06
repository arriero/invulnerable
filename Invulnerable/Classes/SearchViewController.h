//
//  SearchViewController.h
//  Invulnerable
//
//  Created by bailang on 1/15/16.
//  Copyright © 2016 bailang. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface WordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblWord;

@end

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;

@end
