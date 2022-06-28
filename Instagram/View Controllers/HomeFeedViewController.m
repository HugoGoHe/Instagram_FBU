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

@interface HomeFeedViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *LogoutButton;
@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
