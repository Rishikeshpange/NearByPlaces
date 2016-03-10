//
//  placesListViewController.m
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "placesListViewController.h"
//#import <GoogleMaps/GoogleMaps.h>
#import "DetailCell.h"
#import "UIImageView+Network.h"
#import "PlaceDetailViewViewController.h"
#import "MapView.h"
#import <CoreLocation/CoreLocation.h>


@interface placesListViewController ()<CLLocationManagerDelegate,DetailCellDelegate>
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}

@end

@implementation placesListViewController
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *apikey=@"AIzaSyAOBJZ-NlF_Dc0WZzG1liTtWdxFLD3YXow";
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    
    self.arrayFavPlaces = [appdelegate favPlacesOfType:appdelegate.key];
    
    

    if (![self connected]) {
        // [self hideAlert];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else{
        
        [self callGoogleApiPlaces:apikey];
        
        self.title  = @"Places";
        
        self.placesTable.delegate=self;
        [self.ToggleFav addTarget:self
                           action:@selector(action:)
                 forControlEvents:UIControlEventValueChanged];
        
        
        geocoder = [[CLGeocoder alloc] init];
        if (locationManager == nil)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            locationManager.delegate = self;
            [locationManager requestAlwaysAuthorization];
        }
        [locationManager startUpdatingLocation];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.arrayFavPlaces = [appdelegate favPlacesOfType:appdelegate.key];
    [self.placesTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callGoogleApiPlaces:(NSString *)apikey
{
    
    NSString* place=appdelegate.key;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=5000&types=%@&key=AIzaSyC6gJrvQP2Fnvi43_QTs09ptABSt-2n7mg",appdelegate.lat,appdelegate.lng,place]]];

    
    //Asynchronous api request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               
                               
                               
                               NSError* error;
                               NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               self.Typearray=[[NSArray alloc] init];
                               self.Typearray=[array valueForKey:@"results"];
                               self.nameArray=[[NSMutableArray alloc] init];
                               self.ImageUrlArray=[[NSMutableArray alloc] init];
                               self.AddressArray=[[NSMutableArray alloc] init];
                               self.RatingsArray=[[NSMutableArray alloc] init];
                               self.LocationArray=[[NSMutableArray alloc] init];
                               self.IDArray = [[NSMutableArray alloc]init];
                               for(NSDictionary *dict in self.Typearray)
                               {
                                   NSString *placeID = [dict objectForKey:@"id"];
                                   [self.IDArray addObject:placeID];
         
                                   NSDictionary *firstName = [dict objectForKey:@"photos"];
                                   NSDictionary *geometry = [[dict objectForKey:@"geometry"] objectForKey:@"location"];
                                
                                   
                                   [self.LocationArray addObject:geometry];
                                   
                                   [self.AddressArray addObject:[dict valueForKey:@"vicinity"]];
                                   NSString *ratings=[dict valueForKey:@"rating"];
                                   if( ratings != nil)
                                   {
                                       [self.RatingsArray addObject:[dict valueForKey:@"rating"]];
                                   }
                                   else{
                                       [self.RatingsArray addObject:@"- - -"];
                                   }
            
                                   [self.nameArray addObject:[dict valueForKey:@"name"]];
                                   NSString *string1=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photoreference=%@&key=AIzaSyC6gJrvQP2Fnvi43_QTs09ptABSt-2n7mg",[[firstName valueForKey:@"photo_reference"] objectAtIndex:0]];
                                   [self.ImageUrlArray addObject:string1];
               
                               }

                               [self.placesTable reloadData];

                               
                           }];
    
    // Get JSON as a NSString from NSData response
    
}


- (IBAction)segmentFavValueChanged:(UISegmentedControl *)sender
{
    
    self.arrayFavPlaces = [appdelegate favPlacesOfType:appdelegate.key];
    
    [self.placesTable reloadData];
}




#pragma mark - UITableview delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.ToggleFav.selectedSegmentIndex == 0)
    {
        return [self.Typearray count];    //count number of row from counting array hear cataGorry is An Array

    }
    else
    {
        return [self.arrayFavPlaces count];    //count number of row from counting array hear cataGorry is An Array
    }
    return 0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"DetailCell";
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.delegate = self;
    cell.indexPath = indexPath;
    if (cell == nil)
    {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:MyIdentifier];
    }
    
    if (self.ToggleFav.selectedSegmentIndex == 0)
    {
        cell.NameLabel.text = [self.nameArray objectAtIndex:indexPath.row];
        cell.imageType.layer.cornerRadius = 45;
        cell.imageType.clipsToBounds = YES;
        cell.imageType.backgroundColor=[UIColor lightGrayColor];
        
        //IMAGE CACHING METHOD USING CATEGORY CLASS (UIImageView+Network.h,CacheNB.h)
        [cell.imageType loadImageFromURL:[NSURL URLWithString:[self.ImageUrlArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"no-image.png"] cachingKey:[self.nameArray objectAtIndex:indexPath.row] ];
        
        cell.btnFav.hidden = false;
    }
    else
    {
        Place_NSObject* place = [self.arrayFavPlaces objectAtIndex:indexPath.row];
        cell.NameLabel.text = place.name;
        cell.imageType.layer.cornerRadius = 45;
        cell.imageType.clipsToBounds = YES;
        cell.imageType.backgroundColor=[UIColor lightGrayColor];
        
        //IMAGE CACHING METHOD USING CATEGORY CLASS (UIImageView+Network.h,CacheNB.h)
        [cell.imageType loadImageFromURL:[NSURL URLWithString:place.imageUrl] placeholderImage:[UIImage imageNamed:@"no-image.png"] cachingKey:place.name ];
        cell.btnFav.hidden = true;
        
    }

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.placesTable indexPathForSelectedRow];
        PlaceDetailViewViewController *destViewController = segue.destinationViewController;
        
        if (self.ToggleFav.selectedSegmentIndex == 0)
        {
            destViewController.imageUrl = [self.ImageUrlArray objectAtIndex:indexPath.row];
            destViewController.key = [self.nameArray objectAtIndex:indexPath.row];
            destViewController.address = [self.AddressArray objectAtIndex:indexPath.row];
            destViewController.ratings = [self.RatingsArray objectAtIndex:indexPath.row];
            destViewController.location = [self.LocationArray objectAtIndex:indexPath.row];
            destViewController.NameLabel.text = [self.nameArray objectAtIndex:indexPath.row];
        }
        else
        {
            Place_NSObject* place = [self.arrayFavPlaces objectAtIndex:indexPath.row];
            destViewController.imageUrl = place.imageUrl;
            destViewController.key = place.name;
            destViewController.address = place.address;
            destViewController.ratings = place.rating;
            destViewController.location = place.location;
            destViewController.NameLabel.text = place.name;
        }


    }
}

- (void)action:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {

    }
    else if (sender.selectedSegmentIndex == 1)
    {

    }
}

-(void)detailCell_ClickedFavorite:(DetailCell*)detailCell
{
    NSString* name = [self.nameArray objectAtIndex:detailCell.indexPath.row];
    NSString* rating = [self.RatingsArray objectAtIndex:detailCell.indexPath.row];
    NSString* imageUrl = [self.ImageUrlArray objectAtIndex:detailCell.indexPath.row];
    NSString* address = [self.AddressArray objectAtIndex:detailCell.indexPath.row];
    NSString* location = [self.LocationArray objectAtIndex:detailCell.indexPath.row];
    NSString* placeID = [self.IDArray objectAtIndex:detailCell.indexPath.row];
    
    Place_NSObject* place = [[Place_NSObject alloc] init];
    place.name = name;
    place.rating = rating;
    place.imageUrl = imageUrl;
    place.address = address;
    place.location = location;
    place.placeId = placeID;
    place.placeType = appdelegate.key;
    [appdelegate addFavPlace:place ofType:appdelegate.key];
    
}


#pragma mark - CLLocationManager delegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
