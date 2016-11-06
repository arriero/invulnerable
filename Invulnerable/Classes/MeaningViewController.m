//
//  MeaningViewController.m
//  Origen
//
//  Created by Jhon Salazar on 11/4/16.
//  Copyright © 2016 bailang. All rights reserved.
//

#import "MeaningViewController.h"

@interface MeaningViewController ()

@end

@implementation MeaningViewController

@synthesize lblMeaning;
@synthesize lblTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
/*    if(self.curIndex < 0 || self.curIndex >= 925) {
        self.curIndex = 0;
    }
*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Dictionary" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    NSArray* words = [dict objectForKey:@"NAME"];
    NSString* title = words[self.curIndex];
    lblTitle.text = title;

    NSArray* meanings = [dict objectForKey:@"DESCRIPTION"];
    NSString* description = meanings[self.curIndex];
    lblMeaning.text = description;
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
