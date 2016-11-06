//
//  MeaningViewController.h
//  Origen
//
//  Created by Jhon Salazar on 11/4/16.
//  Copyright © 2016 bailang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface MeaningViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMeaning;
@property (assign) NSInteger curIndex;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView2;


@end
