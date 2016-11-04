//
//  DetailViewController.m
//  Invulnerable
//
//  Created by bailang on 1/15/16.
//  Copyright © 2016 bailang. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailCell

@end

@interface DetailViewController ()

@property (assign) NSInteger minIndex;
@property (assign) NSInteger maxIndex;

@property (strong, nonatomic) NSArray* meanings;
@property (strong, nonatomic) NSMutableArray* selectMeaning;
@property (strong, nonatomic) NSArray* words;
@property (strong, nonatomic) NSMutableArray* selectWord;

@end

#define IS_IOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 && floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1)
#define IS_IOS8  ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)
#define IS_IPHONE6PLUS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] nativeScale] == 3.0f)

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.curIndex < 0 || self.curIndex >= 925) {
        self.curIndex = 0;
    }
    
    self.minIndex = self.curIndex;
    self.maxIndex = self.curIndex;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Dictionary" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    self.words = [dict objectForKey:@"NAME"];
    self.meanings = [dict objectForKey:@"DESCRIPTION"];
    
    self.selectWord = [NSMutableArray array];
    [self.selectWord addObject:self.words[self.curIndex]];
    
    self.selectMeaning = [NSMutableArray array];
    [self.selectMeaning addObject:self.meanings[self.curIndex]];
    
//    Because of self.automaticallyAdjustsScrollViewInsets you must add code below in viewWillApper
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //manually triggered pulltorefresh
//    [self.tableView triggerPullToRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView DataManagement
- (void)insertRowAtTop {
    __weak typeof(self) weakSelf = self;
    
    
    self.minIndex--;
    
    int64_t delayInSeconds = 2.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.selectMeaning insertObject:weakSelf.meanings[weakSelf.minIndex] atIndex:0];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        
    });
}

- (void)insertRowAtBottom {
    __weak typeof(self) weakSelf = self;
    
    
    self.maxIndex++;
    
    int64_t delayInSeconds = 2.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSInteger lastIndex = weakSelf.selectMeaning.count;
        [weakSelf.tableView beginUpdates];
        [weakSelf.selectMeaning insertObject:weakSelf.meanings[weakSelf.maxIndex] atIndex:lastIndex];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:lastIndex inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = self.selectMeaning.count;
    return count > 0 ? count:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString* contentString = self.curDict[indexPath.row];
//    CGSize constraintSize = {self.view.frame.size.width, 20000};
//    CGSize neededSize = [contentString sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:constraintSize  lineBreakMode:UILineBreakModeCharacterWrap];
//    if ( neededSize.height <= 18)
//        return 45;
//    else
//        return neededSize.height;
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* Return an estimated height or calculate
     * estimated height dynamically on information
     * that makes sense in your case.
     */
    return 200.0f;
}

NSString *const kDetailCell = @"DetailCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailCell];
    
    NSString* description = self.selectMeaning[indexPath.row];
    cell.lblDescription.text = description;
        
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
