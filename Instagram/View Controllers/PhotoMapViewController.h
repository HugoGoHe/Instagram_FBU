//
//  PhotoMapViewController.h
//  Instagram
//
//  Created by Hugo Gomez Herrera on 6/27/22.
//

#import "ViewController.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoMapViewControllerDelegate

-(void) didPost;

@end

@interface PhotoMapViewController : ViewController  <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,weak) id<PhotoMapViewControllerDelegate> delegate;

@end




NS_ASSUME_NONNULL_END
