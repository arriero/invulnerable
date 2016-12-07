//
//  SearchViewController.m
//  Invulnerable
//
//  Created by bailang on 1/15/16.
//  Copyright © 2016 bailang. All rights reserved.
//

#import "SearchViewController.h"
#import "MeaningViewController.h"
#import "InfoViewController.h"

@implementation WordCell

@end

@interface SearchViewController() <UITableViewDelegate, UISearchBarDelegate>

@property (assign) NSInteger selectedIndex;
@property (strong, nonatomic) NSString* selectedWord;

@property (strong, nonatomic) NSArray* keys;

@property (strong, nonatomic) NSMutableArray* filterWords;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Leer el archivo
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Dict" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    self.keys = [dict allKeys];

    self.filterWords = [[NSMutableArray alloc] init];
    [self.filterWords addObjectsFromArray:self.keys];
    
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    
    //Código Banner de Google
    self.bannerView.adUnitID = @"ca-app-pub-9597991151956696/9024895562";
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    [self.bannerView loadRequest:request];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Ocultar la barra de navegación
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate
// Altura de las celdas
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

//Número de columnas en la tabla filtrada
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger count = self.filterWords.count;
    return count > 0 ? count:1;
}

NSString *const kWordCellId = @"WordCell";
//Llenar la tabla
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WordCell *cell = [tableView dequeueReusableCellWithIdentifier:kWordCellId];
    
    NSString* wordText = self.filterWords[indexPath.row];
    cell.lblWord.text = wordText;
   
    return cell;
}

//El código cuando se selecciona la celda se pasó al de llamado a la otra pantalla para que no llamara dos veces.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString* selectedWord = self.filterWords[indexPath.row];
//    self.selectedIndex = [self getIndexOfWord:selectedWord];
}

//Cuando se llama la otra pantalla
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"showMeaning"]){
        //Conseguir el índice de la celda seleccionada
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        //Identificar la palabra
        self.selectedWord = self.filterWords[indexPath.row];
        MeaningViewController *targetController = segue.destinationViewController;
        targetController.selectedWord = self.selectedWord;
    }
}

//cuando cambian las letras en el panel de busqueda
#pragma mark - searchBar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.filterWords removeAllObjects];
    
    if(searchText.length == 0) {
        [self.filterWords addObjectsFromArray: self.keys];
    }
    else {
        for (NSString* wordText in self.keys) {
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
