//
//  MapView.m
//  NearByApp
//
//  Created by Rishikesh Pange on 3/7/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "MapView.h"
#import "Annotation.h"


#define METERS_PER_MILE 1609.344

@interface MapView ()

@end

@implementation MapView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"Map View";
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
CLLocationCoordinate2D zoomLocation;
zoomLocation.latitude = [self.lat doubleValue];
zoomLocation.longitude= [self.lon doubleValue];


MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
   
   
    Annotation *addAnnotation = [[Annotation alloc] initWithCoordinate:zoomLocation];
   

// 3
[_view1 setRegion:viewRegion animated:YES];
     [_view1 addAnnotation:addAnnotation];
    
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

@end
