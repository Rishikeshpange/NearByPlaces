//
//  AppDelegate.m
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "AppDelegate.h"
#import "Place.h"

//@import GoogleMaps;
@interface AppDelegate ()
@property(nonatomic,retain)NSMutableArray* arrFavPlaces;
@property(nonatomic,retain)NSMutableDictionary* dictFavPlaces;

@end

@implementation AppDelegate
-(NSMutableArray*)arrFavPlaces{

    if (!_arrFavPlaces)
    {
        _arrFavPlaces = [NSMutableArray array];
    }
    return _arrFavPlaces;
}
-(NSMutableDictionary*)dictFavPlaces
{
    if (!_dictFavPlaces)
    {
        _dictFavPlaces = [NSMutableDictionary dictionary];
    }
    return _dictFavPlaces;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self getInitilPlaces];
  //  [GMSServices provideAPIKey:@"AIzaSyBzqybwTWmqagH0SnumfBMB1ARozhkBwfo"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Core Data stack
//-(void)favoritePlaces
-(void)getInitilPlaces
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (results) {
        for (Place* place in results)
        {
            Place_NSObject* place_ns = [[Place_NSObject alloc] init];
            place_ns.name = place.name;
//            place_ns.rating = place.rating;
            place_ns.imageUrl = place.imageUrl;
            place_ns.address = place.address;
            place_ns.placeType = place.placeType;
            place_ns.placeId = place.placeId;
            
            [self.arrFavPlaces addObject:place_ns];
            
            if ([self.dictFavPlaces objectForKey:place_ns.placeType] == nil)
            {
                [self.dictFavPlaces setObject:[NSMutableArray array]
                                       forKey:place_ns.placeType];
            }
            NSMutableArray* array = [self.dictFavPlaces objectForKey:place_ns.placeType];
            [array addObject:place_ns];
            [self.dictFavPlaces setObject:array
                                   forKey:place_ns.placeType];

            
            
        }

    }
}
-(NSArray*)favPlacesOfType:(NSString*)type
{
    return [self.dictFavPlaces objectForKey:type];
}
-(void)addFavPlace:(Place_NSObject*)plcae ofType:(NSString*)type
{
    if ([self isPlaceFavorite:plcae] == false)
    {
        
        [self.arrFavPlaces addObject:plcae];
        if ([self.dictFavPlaces objectForKey:type] == nil)
        {
            [self.dictFavPlaces setObject:[NSMutableArray array]
                                   forKey:type];
        }
        NSMutableArray* array = [self.dictFavPlaces objectForKey:type];
        [array addObject:plcae];
        [self.dictFavPlaces setObject:array
                               forKey:type];
        
        
        Place *place_coreData = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:[self managedObjectContext]];
        place_coreData.name = plcae.name;
//        place_coreData.rating = plcae.rating;
        place_coreData.imageUrl = plcae.imageUrl;
        place_coreData.address = plcae.address;
        place_coreData.placeType = plcae.placeType;
        place_coreData.placeId = plcae.placeId;
        
        [self saveContext];
        
    }
}
-(BOOL)isPlaceFavorite:(Place_NSObject*)place
{
    return [self.arrFavPlaces containsObject:place];
}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ttl.Drafts" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NearBy" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NearBy.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
//[[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}




@end
