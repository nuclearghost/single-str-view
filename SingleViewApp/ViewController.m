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

static NSString *kPlacementKey = @"e7244b42";

@interface ViewController () <STRAdViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
//    [[SharethroughSDK sharedInstance] prefetchAdForPlacementKey:kPlacementKey delegate:[AdDelegate sharedInstance]];
//    [[SharethroughSDK sharedInstance] prefetchAdForPlacementKey:@"f8b11995" delegate:self];
}

- (void)didPrefetchAdvertisement:(STRAdvertisement *)strAd {
    NSLog(@"didPrefetch");
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

- (IBAction)fetchAds:(id)sender {
    [[SharethroughSDK sharedInstance] prefetchAdForPlacementKey:kPlacementKey delegate:self];
}

- (IBAction)AssignAllAds:(id)sender {
    [self assignAllAds];
}

- (IBAction)clearAssignedAds:(id)sender {
    [self clearAds];
}

- (IBAction)logAdCounts:(id)sender {
    [self numberOfAdsAvialable];
}

- (NSInteger)numberOfAdsAvialable {
    NSInteger nAds = [[SharethroughSDK sharedInstance] totalNumberOfAdsAvailableForPlacement:kPlacementKey];
    NSInteger nUnassignedAds = [[SharethroughSDK sharedInstance] unassignedNumberOfAdsAvailableForPlacement:kPlacementKey];
    NSLog(@"There are %ld total ads assigned and unassigned. %ld unassigned", (long)nAds, (long)nUnassignedAds);
    return nAds;
}

- (void)assignAllAds {
    NSInteger nAds = [self numberOfAdsAvialable];
    for (int i = 0; i < nAds; ++i) {
        [[SharethroughSDK sharedInstance] AdForPlacement:kPlacementKey atIndex:i];
    }
    NSInteger nUnassignedAds = [[SharethroughSDK sharedInstance] unassignedNumberOfAdsAvailableForPlacement:kPlacementKey];
    NSLog(@"Assigned %ld ads. %ld unassigned", (long)nAds, (long)nUnassignedAds);
}

- (void)clearAds {
    [[SharethroughSDK sharedInstance] clearCachedAdsForPlacement:kPlacementKey];
    NSInteger nAds = [self numberOfAdsAvialable];
    NSLog(@"Expected %ld to be 0", (long)nAds);
}
@end
