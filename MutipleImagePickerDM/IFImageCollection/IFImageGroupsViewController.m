//
//  IFImageGroupsViewController.m
//  imagePicker
//
//  Created by Jiao on 14-9-9.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import "IFImageGroupsViewController.h"
#import "IFImageCollecionViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface IFImageGroupsViewController ()
{
    UITableView *table;
}

@end

@implementation IFImageGroupsViewController
@synthesize assetsGroups;
@synthesize assetsLibrary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        assetsGroups = [[NSMutableArray alloc] init];
        assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"相册";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(rightBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [UIView new];
    table.rowHeight = 55;
    [self.view addSubview:table];
    
    [self setAssetsGroups];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAssetsGroups
{
    NSArray *groupTypes = @[
                   @(ALAssetsGroupSavedPhotos),
                   @(ALAssetsGroupPhotoStream),
                   @(ALAssetsGroupAlbum)
                   ];
    for (NSNumber *type in groupTypes) {
        [assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue] usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group.numberOfAssets > 0) {
                [assetsGroups addObject:group];
            }
            [table reloadData];
        } failureBlock:^(NSError *error) {
            NSLog(@"fail to get assetsLib");
        }];
    }
}

- (void)rightBarButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return assetsGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *albums = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        albums.tag = 100;
        [cell.contentView addSubview:albums];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH - 90, 55)];
        title.tag = 101;
        [cell.contentView addSubview:title];
    }
    
    for (UIView *view in [cell.contentView subviews]) {
        if ([view isKindOfClass:[UIImageView class]] && view.tag == 100) {
            UIImageView *imgView = (UIImageView *)view;
            imgView.image = [UIImage imageWithCGImage:[[assetsGroups objectAtIndex:indexPath.row] posterImage]];
        }
        if ([view isKindOfClass:[UILabel class]] && view.tag == 101) {
            UILabel *label = (UILabel *)view;
            ALAssetsGroup *group = [assetsGroups objectAtIndex:indexPath.row];
            NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] init];
            [mutStr appendAttributedString:[[NSAttributedString alloc] initWithString:[group valueForProperty:ALAssetsGroupPropertyName]]];
            [mutStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
            [mutStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%ld)",(long)group.numberOfAssets] attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}]];
            label.attributedText = mutStr;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IFImageCollecionViewController *collectionVC= [[IFImageCollecionViewController alloc] init];
    collectionVC.assetGroup = [assetsGroups objectAtIndex:indexPath.row];
    collectionVC.maxSelectLimit = 9;
    [collectionVC setTitle:[[assetsGroups objectAtIndex:indexPath.row] valueForProperty:ALAssetsGroupPropertyName]];
    [self.navigationController pushViewController:collectionVC animated:YES];
}

@end
