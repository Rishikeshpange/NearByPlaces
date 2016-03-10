//
//  placesListViewController.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import<CoreLocation/CoreLocation.h>
#import "Reachability.h"


@interface placesListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    AppDelegate *appdelegate;
    Reachability* internetReachable;
    Reachability* hostReachable;
   NetworkStatus internetActive, hostActive;
}

@property (strong, nonatomic) IBOutlet NSArray *arrayFavPlaces;
@property (strong, nonatomic) IBOutlet NSArray *Typearray;
@property (strong, nonatomic) IBOutlet NSMutableArray *nameArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *ImageUrlArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *AddressArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *RatingsArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *LocationArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *IDArray;
@property (strong, nonatomic) IBOutlet UITableView *placesTable;
@property (strong, nonatomic) IBOutlet UISegmentedControl *ToggleFav;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet NSString *key;



@end
