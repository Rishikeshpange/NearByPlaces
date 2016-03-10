//
//  ViewController.m
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "ViewController.h"
#import "typesCell.h"
#import "placesListViewController.h"


@interface ViewController ()<CLLocationManagerDelegate>
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}


@end

@implementation ViewController
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Typearray = [[NSMutableArray alloc]init];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; 
    [self.Typearray addObjectsFromArray:@[@"food",@"gym",@"school",@"hospital",@"spa",@"restaurant"]];
    self.TypesTable.delegate=self;
   
    
    //[[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:(19.0f/255.0f) green:(151.0f/255.0f) blue:(226.0f/255.0f) alpha:1]];
    self.navigationController.navigationBar.translucent = YES;
   // self.navigationController.navigationBar.translucent = NO;
    if (![self connected]) {
        // [self hideAlert];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else{
       if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
    }
    
    geocoder = [[CLGeocoder alloc] init];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }

    [locationManager startUpdatingLocation];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{

  [locationManager startUpdatingLocation];
}



#pragma mark - UITableview delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.Typearray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    typesCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[typesCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    cell.typeLabel.text = [self.Typearray objectAtIndex:indexPath.row];
    cell.typeImage.layer.cornerRadius = 32.5;
    cell.typeImage.clipsToBounds = YES;
    cell.typeImage.image=[UIImage imageNamed:@"no-image.png"];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    typesCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",selectedCell.typeLabel.text);
    
    appdelegate.key = selectedCell.typeLabel.text;
  
    
}

#pragma mark - CLLocationManager delegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0)
        {
            placemark = [placemarks lastObject];
            appdelegate.lat=[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
             appdelegate.lng=[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];

            
        } else {

        }
    } ];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}



#pragma mark - Network connectivity methods
- (BOOL)connected
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}
- (void)checkNetworkStatus:(NSNotification*)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable: {
            NSLog(@"The internet is down.");
            self->internetActive = NO;
            break;
        }
        case ReachableViaWiFi: {
            NSLog(@"The internet is working via WIFI.");
            self->internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN: {
            NSLog(@"The internet is working via WWAN.");
            self->internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus) {
        case NotReachable: {
            NSLog(@"A gateway to the host server is down.");
            self->hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi: {
            NSLog(@"A gateway to the host server is working via WIFI.");
            self->hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN: {
            NSLog(@"A gateway to the host server is working via WWAN.");
            self->hostActive = YES;
            
            break;
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
