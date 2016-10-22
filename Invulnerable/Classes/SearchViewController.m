//
//  SearchViewController.m
//  Invulnerable
//
//  Created by bailang on 1/15/16.
//  Copyright © 2016 bailang. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailViewController.h"

@implementation WordCell

@end

@interface SearchViewController() <UITableViewDelegate, UISearchBarDelegate>

@property (assign) NSInteger selectedIndex;

@property (strong, nonatomic) NSArray* words;
@property (strong, nonatomic) NSMutableArray* filterWords;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Keyword" ofType:@"plist"];
    
    self.words = [[NSArray alloc]initWithContentsOfFile:path];
    
    self.filterWords = [[NSMutableArray alloc] init];
    [self.filterWords addObjectsFromArray:self.words];
    
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    
    [self.searchBar setBackgroundColor:[UIColor clearColor]];
//    [self.searchBar setTranslucent:YES];
    [[self.searchBar.subviews objectAtIndex:0] setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topBar2"] forBarMetrics:UIBarMetricsDefault];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)getIndexOfWord: (NSString*)wordText {
    for (int i = 0; i < self.words.count; i++) {
        NSString* orgWord = self.words[i];
        if([orgWord isEqualToString: wordText]) {
            return i;
        }
    }
    return -1;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger count = self.filterWords.count;
    return count > 0 ? count:1;
}

NSString *const kWordCellId = @"WordCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WordCell *cell = [tableView dequeueReusableCellWithIdentifier:kWordCellId];
    
    NSString* wordText = self.filterWords[indexPath.row];
    cell.lblWord.text = wordText;
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* selectedWord = self.filterWords[indexPath.row];
    self.selectedIndex = [self getIndexOfWord:selectedWord];
    
    [self performSegueWithIdentifier:@"SearchDetailSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SearchDetailSegue"]) {
        
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.curIndex = self.selectedIndex;
    }
}

#pragma mark - searchBar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.filterWords removeAllObjects];
    
    if(searchText.length == 0) {
        [self.filterWords addObjectsFromArray: self.words];
    }
    else {
        for (NSString* wordText in self.words) {
            NSString* orgText = [wordText lowercaseString];
            NSString* searchStr = [searchText lowercaseString];
            if([orgText containsString:searchStr]) {
                [self.filterWords addObject: wordText];
            }
        }
        if(self.filterWords.count == 0) {
//            [self.filterWords addObjectsFromArray: self.words];
            [self.filterWords addObject: @" "];
        }

    }
    
    [self.tableView reloadData];
}

@end
