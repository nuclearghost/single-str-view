//
//  InitialViewController.m
//  SingleViewApp
//
//  Created by Eric Alford on 12/22/15.
//  Copyright © 2015 Sharethrough. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

- (IBAction)presentNextViewController:(id)sender;
@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)presentNextViewController:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
