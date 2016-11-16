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
    
    //Aparecer la barra de navegación para regresar
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Dict" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    lblTitle.text = self.selectedWord;
    lblMeaning.text = [dict objectForKey:self.selectedWord];

    
    //Código Banner de Google
    self.bannerView2.adUnitID = @"ca-app-pub-9597991151956696/9024895562";
    self.bannerView2.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    [self.bannerView2 loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Obligar a que el significado empiece desde el principio del texto.
- (void)viewDidLayoutSubviews {
    [self.lblMeaning setContentOffset:CGPointZero animated:NO];
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
