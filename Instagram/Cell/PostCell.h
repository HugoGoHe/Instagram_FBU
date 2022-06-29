//
//  PostCell.h
//  Instagram
//
//  Created by Hugo Gomez Herrera on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFavs;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *postedAtLabel;
@property (weak, nonatomic) Post *post;


@end

NS_ASSUME_NONNULL_END
