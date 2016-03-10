//
//  ViewController.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import<CoreLocation/CoreLocation.h>
#import "Reachability.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    AppDelegate *appdelegate;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
}

@property (strong, nonatomic) IBOutlet UITableView *TypesTable;
@property (strong, nonatomic) IBOutlet NSMutableArray *Typearray;
@property (strong, nonatomic) IBOutlet NSString *typestring;
@property (nonatomic, retain) CLLocationManager *locationManager;


@end

