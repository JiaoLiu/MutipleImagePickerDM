//
//  DMViewController.m
//  MutipleImagePickerDM
//
//  Created by Jiao on 14-9-11.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import "DMViewController.h"
#import "IFImageGroupsViewController.h"

@interface DMViewController ()

@end

@implementation DMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showListVIew:(id)sender {
    IFImageGroupsViewController *imgGroup = [[IFImageGroupsViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imgGroup];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
