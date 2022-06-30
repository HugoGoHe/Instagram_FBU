//
//  DetailsPageViewController.m
//  Instagram
//
//  Created by Hugo Gomez Herrera on 6/29/22.
//

#import "DetailsPageViewController.h"
#import "HomeFeedViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"

@interface DetailsPageViewController ()

@end

@implementation DetailsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.selectedPost.image.url]];
    self.picture.image = [UIImage imageWithData:imageData];
    self.numberOfFavs.text = [NSString stringWithFormat:@"%@", self.selectedPost.likeCount];
    self.caption.text = self.selectedPost.caption;
}
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
