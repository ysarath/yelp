//
//  YelpSearchResultsViewController.m
//  yelp
//
//  Created by Sarath Yalamanchili on 9/19/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import "YelpSearchResultsViewController.h"
#import "YelpClient.h"
#import "YelpResultsCell.h"
#import "UIImageView+AFNetworking.h"
#import "YelpFilterViewController.h"


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";


@interface YelpSearchResultsViewController ()
- (void)dismissKeyboard;
@property (nonatomic, strong) YelpClient *client;
@property (strong, nonatomic) NSArray *listings;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end

@implementation YelpSearchResultsViewController
UISearchBar *searchBar;
NSMutableArray * filteredNames;
UISearchDisplayController * searchController;


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
    [self addNavigationBarButton];
    //Register Table view cell
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self;
    self.resultsTableView.rowHeight = 100;
    [self.resultsTableView registerNib:[UINib nibWithNibName:@"YelpResultsCell" bundle:nil] forCellReuseIdentifier:@"YelpResultsCell"];
    
    [self fetchYelpResults:@"thai"];
    NSLog(@"Before loading");
   // [self.resultsTableView reloadData];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)filterClicked:(id)sender{
    //Navigate to Filters Page
    NSLog(@"Navigation to Filters Page");
        [self.navigationController pushViewController:[[YelpFilterViewController alloc] init] animated:YES];
}

-(void)addNavigationBarButton{
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    //RGB and Alpha values
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:200.0/255 green:0.0/255 blue:23.0/255 alpha:1.0f]];
    //Search Bar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    searchBar.delegate = self;
    [searchBar setBarTintColor:[UIColor redColor]];
    [searchBar setTintColor:[UIColor blackColor]];
    self.navigationItem.titleView = searchBar;

    
    UIBarButtonItem *myNavBtn = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(filterClicked:)];

   // [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
  //
   // self.navigationController.navigationBar.barStyle = UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = myNavBtn;
   // [self.navigationController.navigationItem setLeftBarButtonItem:myNavBtn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    

}

- (void)dismissKeyboard {
   // [self.view endEditing:YES];
     [searchBar resignFirstResponder];
}

- (void)fetchYelpResults:(NSString *) term{
    
    
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Date Retreival  Complete");
        NSLog(@"response: %@", response);
        self.listings = response[@"businesses"];
        [self.resultsTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"No of rows %i",[self.listings count]);
   return [self.listings count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YelpResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpResultsCell" forIndexPath:indexPath];
    NSDictionary *result = [self.listings objectAtIndex:indexPath.row];
    cell.resturantNameLabel.text = result[@"name"];
    [cell.resturantImageView setImageWithURL:[NSURL URLWithString:result[@"image_url"]]];
    
    NSInteger reviewCount = [result[@"review_count"] integerValue];
    cell.resturantReviewsLabel.text = [NSString stringWithFormat:@"%d reviews",reviewCount] ;
    [cell.resturantRatingsImageView setImageWithURL:[NSURL URLWithString:result[@"rating_img_url"]]];
    
    NSArray *address = [result valueForKeyPath:@"location.display_address"];
    NSString *concatAddress = [[NSString alloc]init];
    NSLog(@"Address Count %i" , [address count]);
    for (int i=0; i <[address count]; i++) {
        if (i >1){
            concatAddress = [concatAddress stringByAppendingString:@" ,"];
        }
        concatAddress = [concatAddress stringByAppendingString:address[i]];
    }
    cell.resturantAddressLabel.text = concatAddress;

    NSArray *categories = result[@"categories"];
    NSString *concatcategories = [[NSString alloc]init];
    NSLog(@"Categories count %i" ,[categories count]);
    for (int i=0; i <[categories count]; i++) {
        if (i >1){
            concatcategories = [concatcategories stringByAppendingString:@" ,"];
        }
        concatcategories = [concatcategories stringByAppendingString:categories[i][0]];
    }
    cell.resturantCategoryLabel.text = concatcategories;
    
       NSLog(@"Resturant Name @%",result[@"name"]);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static YelpResultsCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.resultsTableView dequeueReusableCellWithIdentifier:@"YelpResultsCell"];
    });
    
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

@end
