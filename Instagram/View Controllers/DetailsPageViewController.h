//
//  DetailsPageViewController.h
//  Instagram
//
//  Created by Hugo Gomez Herrera on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFavs;
@property (weak, nonatomic) IBOutlet UILabel *caption;

@property (strong,nonatomic) Post *selectedPost;

@end

NS_ASSUME_NONNULL_END
