//
//  ViewController.m
//  SingleViewApp
//
//  Created by Mark Meyer on 12/21/15.
//  Copyright © 2015 Sharethrough. All rights reserved.
//

#import "ViewController.h"
#import <SharethroughSDK+DFP/SharethroughSDK+DFP.h>

@interface AdDelegate : NSObject <STRAdViewDelegate>

+ (id)sharedInstance;

@end

@implementation AdDelegate

+ (instancetype)sharedInstance {
    __strong static AdDelegate *testSafeSharedObject = nil;

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
    [[SharethroughSDKDFP sharedInstance] prefetchAdForPlacementKey:@"e7244b42" delegate:self];
}

-(void)orientationDidChange:(NSNotification *)notification{
    NSLog(@"ORIENTATION CHANGED");
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

- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
