//
//  PlaceDetailViewViewController.m
//  NearByApp
//
//  Created by Rishikesh Pange on 06/03/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "PlaceDetailViewViewController.h"
#import "MapView.h"

#import "CacheNB.h"

@interface PlaceDetailViewViewController ()

@end

@implementation PlaceDetailViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.ratingsLabel.text=[NSString stringWithFormat:@"%@",self.ratings];
    self.NameLabel.text=[NSString stringWithFormat:@"%@",self.key];
    self.MapButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.MapButton.clipsToBounds = YES;
    
     self.title  = @"Place Details";
    NSData *imagedata=[CacheNB objectForKey:self.key];
    
    if (imagedata)
    {
        [self addGradientToView:self.DetailImageView];
        self.DetailImageView.image = [UIImage imageWithData:[CacheNB objectForKey:self.key]];
    }
    else
    {
        self.DetailImageView.image = [UIImage imageNamed:@"no_image_thumb.png"];
        
    }
    self.addressLabel.text=self.address;
    self.addressText.text=self.address;

    // Do any additional setup after loading the view.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"mapViewIdentifier"]) {
         NSDictionary *locationdic=self.location;
        MapView *destViewController = segue.destinationViewController;
        destViewController.lat = [locationdic valueForKey:@"lat"];
         destViewController.lon = [locationdic valueForKey:@"lng"];
        
    }
}
- (IBAction)markAsFavourite:(id)sender
{
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)addGradientToView:(UIView *)view
{
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
                        (id)[[UIColor clearColor] CGColor]
                        ];
    [view.layer insertSublayer:gradient atIndex:0];
}

@end
