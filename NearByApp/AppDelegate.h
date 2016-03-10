//
//  AppDelegate.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Place.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) IBOutlet NSString *key;
@property (nonatomic, strong) IBOutlet NSString *lat;
@property (nonatomic, strong) IBOutlet NSString *lng;

-(NSArray*)favPlacesOfType:(NSString*)type;
-(void)addFavPlace:(Place_NSObject*)plcae ofType:(NSString*)type;
-(BOOL)isPlaceFavorite:(Place_NSObject*)place;

@end

