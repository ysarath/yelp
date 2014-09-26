//
//  YelpFilterViewController.m
//  yelp
//
//  Created by Sarath Yalamanchili on 9/23/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import "YelpFilterViewController.h"
#import "YelpSearchResultsViewController.h"
#import "FilterSection.h"
#import "FilterTableViewCell.h"

@interface YelpFilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) NSDictionary *categoryList;
@property (strong, nonatomic) NSDictionary *distanceList;
@property (strong, nonatomic) NSDictionary *sortyByList;
@property (strong, nonatomic) NSDictionary *dealsList;

@property (strong, nonatomic) NSArray *filterSectionTitles;

@property (strong, nonatomic) NSArray *categoryValues;
@property (strong, nonatomic) NSArray *distanceValues;
@property (strong, nonatomic) NSArray *sortByValues;
@property (strong, nonatomic) NSArray *dealsValues;
@end

@implementation YelpFilterViewController
UISearchBar *searchBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
    [self loadFilterData];
    UINib *filterCellNib = [UINib nibWithNibName:@"FilterTableViewCell" bundle:nil];
    [self.filterTableView registerNib:filterCellNib forCellReuseIdentifier:@"FilterTableViewCell"];
    [self addNavigationBarButton];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNavigationBarButton{
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    //RGB and Alpha values
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:200.0/255 green:0.0/255 blue:23.0/255 alpha:1.0f]];
    UIBarButtonItem *applyFilterBtn = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(applyFilter:)];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(cancelFilter:)];
    self.navigationItem.rightBarButtonItem = applyFilterBtn;
    self.navigationItem.leftBarButtonItem = cancelBtn;
    self.navigationItem.title = @"Filters";
    
    
}


-(IBAction)applyFilter:(id)sender{
    //Navigate to Filters Page
   NSLog(@"Apply Filter Clicked");
}

-(IBAction)cancelFilter:(id)sender{
    //Navigate to Filters Page
    NSLog(@"Cancel Filter Clicked");
    [self.navigationController pushViewController:[[YelpSearchResultsViewController alloc] init] animated:YES];
}

-(void)loadFilterData{
    self.filterSectionTitles = @[@"Category",@"Distance", @"Sort by", @"Deals"];
    //Category Filter
    NSArray *keys1 = [NSArray arrayWithObjects:@"food",@"health",@"hotelstravel", @"beautysvc", @"auto", nil];
    self.categoryValues = [NSArray arrayWithObjects:@"Food", @"Health & Medical", @"Hotels & Travel", @"Beauty & Spas", @"Automative", nil];
    self.categoryList = [NSDictionary dictionaryWithObjects:keys1 forKeys:self.categoryValues];
    //Radius Filter
    NSArray *distance = [NSArray arrayWithObjects:@"1000",@"2000",@"3000", @"4000"];
    self.distanceValues = [NSArray arrayWithObjects:@"1 mile", @"2 miles", @"3 miles", @"4 miles"];
    self.distanceList =[NSDictionary dictionaryWithObjects:distance forKeys:self.distanceValues];
    //Sort by filter
    NSArray *keys3 = [NSArray arrayWithObjects:@"BestMatch",@"Distance",@"Rating",@"MostReviwed"];
    self.sortByValues = [NSArray arrayWithObjects:@"Best Match", @"Distance", @"Rating",@"Most Reviewed"];
    self.sortyByList =[NSDictionary dictionaryWithObjects:keys3 forKeys:self.sortByValues];
    //Deals filter
    NSArray *keys4 = [NSArray arrayWithObjects:@"0",@"1", nil];
    self.dealsValues = [NSArray arrayWithObjects:@"Yes", @"No", nil];
    self.dealsList =[NSDictionary dictionaryWithObjects:keys4 forKeys:self.dealsValues];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ self.filterSectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberofRows;
    switch (section) {
        case 0:
            numberofRows =  [self.categoryList count];
            break;
        case 1:
            numberofRows =  [self.distanceList count];
            break;
        case 2:
            numberofRows =  [self.sortyByList count];
            break;
        case 3:
            numberofRows =  [self.dealsList count];
            break;
        default:
            numberofRows = 0;
            break;
    }
    return numberofRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.filterSectionTitles objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell" forIndexPath:indexPath];
    
    if(indexPath.section ==0){
        NSString *category = [self.categoryValues objectAtIndex:indexPath.row];
        cell.filterCellLabel.text = category;
        NSLog(@"Category: %@",category);
    } else if(indexPath.section == 1){
        NSString *distance = [self.distanceValues objectAtIndex:indexPath.row];
        cell.filterCellLabel.text = distance;
    } else if (indexPath.section == 2){
        NSString *sort = [self.sortByValues objectAtIndex:indexPath.row];
        cell.filterCellLabel.text = sort;
        
    } else if (indexPath.section == 3){
        NSString *deal = [self.dealsValues objectAtIndex:indexPath.row];
        cell.filterCellLabel.text = deal;
    } else{
        NSLog(@"Invalid section");
    }
    return  cell;
}



@end
