//
//  PlaceDetailViewViewController.h
//  NearByApp
//
//  Created by Rishikesh Pange on 06/03/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceDetailViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *DetailImageView;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *ratings;
@property (nonatomic, strong) NSString *location;
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *addressText;
@property (strong, nonatomic) IBOutlet UIButton *MapButton;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;

@end
