//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Hugo Gomez Herrera on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "PhotoMapViewController.h"
#import "DetailsPageViewController.h"

@interface HomeFeedViewController ()<UITableViewDataSource,UITableViewDelegate, PhotoMapViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *LogoutButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * arrayOfPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.arrayOfPosts = [[NSMutableArray alloc] init];
    [self getPosts];
    
    // Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

}


- (void) getPosts{

    // fetch data asynchronously
//
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.arrayOfPosts = (NSMutableArray *)posts;

            [self.tableView reloadData];

        }
        else {
            // handle error
            NSLog(@"%@", error.localizedDescription);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Posts"
                                           message:@"The internet connection appears to be offline."
                                           preferredStyle:UIAlertControllerStyleAlert];
             
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
               handler:^(UIAlertAction * action) {}];
             
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [self.refreshControl endRefreshing];

    }];
}

-(void) didPost{

    [self getPosts];
    [self.tableView reloadData];
}




- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    NSLog(@"a");
   // [self dismissViewControllerAnimated:true completion:nil];
    //Switching screen to loginViewController
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    appDelegate.window.rootViewController = loginViewController;
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    myDelegate.window.rootViewController = loginViewController;

    

}

- (IBAction)didTapNewPost:(id)sender {
    
}





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post1 = self.arrayOfPosts[indexPath.row];
    
   // cell.post = self.arrayOfPosts[indexPath.row];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:post1.image.url]];
    cell.picture.image = [UIImage imageWithData:imageData];
 //   cell.userNameLabel.text = [NSString stringWithFormat:@"%@", post1.author.username];
    cell.userNameLabel.text = post1.author.username;
   // cell.profilePicture =
    cell.numberOfFavs.text = [NSString stringWithFormat:@"%@",post1.likeCount];
    cell.caption.text = post1.caption;
    cell.userNameLabel2 = cell.userNameLabel;
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
    formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSString *elapsed = [formatter stringFromDate:post1.createdAt toDate:[NSDate date]];
    
     cell.postedAtLabel.text = elapsed;

    
    
    
    
    NSLog(@"%@", post1);
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"details"]){
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        NSInteger index = myIndexPath.row;
        UINavigationController *navigationController = [segue destinationViewController];
        Post *selectedPost = self.arrayOfPosts[index];
        DetailsPageViewController *detailsPageVC  = (DetailsPageViewController*) navigationController.topViewController;
        
       detailsPageVC.selectedPost = selectedPost;
//        detailsPageVC.delegate = self;

        
    }
}

@end
