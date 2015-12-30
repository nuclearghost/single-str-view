//
//  STRDelegate.m
//  SingleViewApp
//
//  Created by Mark Meyer on 12/30/15.
//  Copyright © 2015 Sharethrough. All rights reserved.
//

#import "STRDelegate.h"

@implementation STRDelegate

+ (instancetype)sharedInstance {
    __strong static STRDelegate *testSafeSharedObject = nil;

    static dispatch_once_t p = 0;
    dispatch_once(&p, ^{
        testSafeSharedObject = [[self alloc] init];
    });

    return testSafeSharedObject;
}

#pragma mark - <STRAdViewDelegate>

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

@end