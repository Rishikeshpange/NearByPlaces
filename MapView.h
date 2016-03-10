//
//  MapView.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/7/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapView : UIViewController
//@property (strong, nonatomic) IBOutlet MapView *mapViewotl;
@property (strong, nonatomic) IBOutlet MKMapView *view1;
@property (strong, nonatomic) IBOutlet NSString *lat;
@property (strong, nonatomic) IBOutlet NSString *lon;

@end
