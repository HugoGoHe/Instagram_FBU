//
//  LoginViewController.m
//  Instagram
//
//  Created by Hugo Gomez Herrera on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

//@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
//@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didTapLogin:(id)sender {
    //Check for empty fields
    [self checkBlank:self.usernameTextField.text ParameterTwo:self.passwordTextField.text];

    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
//            [self performSegueWithIdentifier:@"firstSegue" sender:nil];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
            self.view.window.rootViewController = tabBarController;

            
            // display view controller that needs to shown after successful login
        }
    }];
}
- (IBAction)didTapSignUp:(id)sender {
    //Check for empty fields
    [self checkBlank:self.usernameTextField.text ParameterTwo:self.passwordTextField.text];

    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"firstSegue" sender:nil];

            // manually segue to logged in view
        }
    }];
}

-(void)checkBlank:(NSString *) username ParameterTwo:(NSString *) password{
    if( [username isEqual:@""] || [password isEqual:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                   message:@"One or more fields are empty"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        // create a cancel action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle cancel response here. Doing nothing will dismiss the view.
                                                          }];
        // add the cancel action to the alertController
        [alert addAction:cancelAction];

        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        
    }
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
