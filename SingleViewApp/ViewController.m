//
//  ViewController.m
//  SingleViewApp
//
//  Created by Mark Meyer on 12/21/15.
//  Copyright © 2015 Sharethrough. All rights reserved.
//

#import "ViewController.h"
//#import <SharethroughSDK+DFP/SharethroughSDK+DFP.h>
#import <SharethroughSDK+DFP/SharethroughSDK.h>

//@interface AdDelegate : NSObject <STRAdViewDelegate>
//
//+ (id)sharedInstance;
//
//@end
//
//@implementation AdDelegate
//
//+ (instancetype)sharedInstance {
//    __strong static AdDelegate *testSafeSharedObject = nil;
//
//    static dispatch_once_t p = 0;
//    dispatch_once(&p, ^{
//        testSafeSharedObject = [[self alloc] init];
//    });
//
//    return testSafeSharedObject;
//}
//
//#pragma mark - <STRAdViewDelegate>
//
//- (void)didPrefetchAdvertisement:(STRAdvertisement *)strAd {
//    NSLog(@"didPrefetch");
//}
//
//- (void)didFailToPrefetchForPlacementKey:(NSString *)placementKey {
//    NSLog(@"failed to prefetch");
//}
//
//- (void)adView:(id<STRAdView>)adView didFetchAdForPlacementKey:(NSString *)placementKey atIndex:(NSInteger)adIndex {
//    NSLog(@"didFetch");
//}
//
//- (void)adView:(id<STRAdView>)adView didFailToFetchAdForPlacementKey:(NSString *)placementKey atIndex:(NSInteger)adIndex{
//    NSLog(@"didFail");
//}
//
//@end

static NSString *kPlacementKey = @"e7244b42";

@interface ViewController () <STRAdViewDelegate>

- (IBAction)popViewController:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if DEBUG
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
#endif
    
    // Do any additional setup after loading the view, typically from a nib.
//    [[SharethroughSDK sharedInstance] prefetchAdForPlacementKey:kPlacementKey delegate:[AdDelegate sharedInstance]];
//    [[SharethroughSDK sharedInstance] prefetchAdForPlacementKey:@"f8b11995" delegate:self];
}

-(void)orientationDidChange:(NSNotification *)notification{
    NSLog(@"ORIENTATION CHANGED");
}

- (void)didPrefetchAdvertisement:(STRAdvertisement *)strAd {
    NSLog(@"didPrefetch");
    [self assignAllAds];
}

- (void)didFailToPrefetchForPlacementKey:(NSString *)placementKey {
    NSLog(@"failed to prefetch");
}

- (void)adView:(id<STRAdView>)adView didFetchAdForPlacementKey:(NSString *)placementKey atIndex:(NSInteger)adIndex {
    NSLog(@"didFetch");
}

- (void)adView:(id<STRAdView>)adView didFailToFetchAdForPlacementKey:(NSString *)placementKey atIndex:(NSInteger)adIndex{
    NSLog(@"didFail");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fetchAds:(id)sender {
    [[SharethroughSDK sharedInstance] prefetchAdForPlacementKey:kPlacementKey delegate:self];
}

- (NSInteger)numberOfAdsAvialable {
    NSInteger nAds = [[SharethroughSDK sharedInstance] totalNumberOfAdsAvailableForPlacement:kPlacementKey];
    NSLog(@"There are %ld ads available", (long)nAds);
    return nAds;
}

- (void)assignAllAds {
    NSInteger nAds = [self numberOfAdsAvialable];
    for (int i = 0; i < nAds; ++i) {
        [[SharethroughSDK sharedInstance] AdForPlacement:kPlacementKey atIndex:i];
    }
    NSInteger nUnassignedAds = [[SharethroughSDK sharedInstance] unassignedNumberOfAdsAvailableForPlacement:kPlacementKey];
    NSLog(@"Assigned %ld ads. %ld unassigned", (long)nAds, (long)nUnassignedAds);
    [self clearAds];
}

- (void)clearAds {
    [[SharethroughSDK sharedInstance] clearCachedAdsForPlacement:kPlacementKey];
    NSInteger nAds = [self numberOfAdsAvialable];
    NSLog(@"Expected %ld to be 0", (long)nAds);
}
@end
