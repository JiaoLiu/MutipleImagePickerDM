//
//  IFImageCollecionViewController.m
//  imagePicker
//
//  Created by Jiao on 14-9-10.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import "IFImageCollecionViewController.h"
#import "IFImageCollectionCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface IFImageCollecionViewController ()
{
    UIButton *sendBtn;
}

@end

@implementation IFImageCollecionViewController

@synthesize maxSelectLimit;
@synthesize selectedAssetUrls;
@synthesize mutAssets;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectedAssetUrls = [NSMutableOrderedSet orderedSet];
        mutAssets = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(rightBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.hidesBackButton = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) collectionViewLayout:layout];
    // Register cell class
    [collectionView registerClass:[IFImageCollectionCell class] forCellWithReuseIdentifier:@"AssetsCell"];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.allowsMultipleSelection = YES;
    if (![self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // > iOS7
        collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114);
    }
    
    [self.view addSubview:collectionView];
    
    UIView *footerTool = [[UIView alloc] initWithFrame:CGRectMake(0, collectionView.frame.origin.y + collectionView.frame.size.height, SCREEN_WIDTH, 50)];
    footerTool.backgroundColor = RGB(245,245,245);
    [self.view addSubview:footerTool];
    
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    seperator.backgroundColor = [UIColor lightGrayColor];
    [footerTool addSubview:seperator];
    
    sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 78, 8, 70, 34)];
    sendBtn.backgroundColor = RGB(0, 122, 255);
    sendBtn.layer.cornerRadius = 3;
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerTool addSubview:sendBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAssetGroup:(ALAssetsGroup *)assetGroup
{
    _assetGroup = assetGroup;
    [assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [mutAssets addObject:result];
        };
    }];
}

- (void)updateSendBtn
{
    if (selectedAssetUrls.count > 0) {
        [sendBtn setTitle:[NSString stringWithFormat:@"发送(%lu)",(unsigned long)selectedAssetUrls.count] forState:UIControlStateNormal];
    }
    else
    {
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    }
}

- (void)sendBtnClicked
{
    if (selectedAssetUrls.count > 0) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        for (NSURL *url in selectedAssetUrls) {
            [library assetForURL:url resultBlock:^(ALAsset *asset) {
                if (asset) {
                    UIImage *img = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                    NSLog(@"send %@",img);
                }
            } failureBlock:^(NSError *error) {
                NSLog(@"Not Found");
            }];
        }
        [self rightBarButtonClicked];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择要发送的图片" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)rightBarButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mutAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IFImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AssetsCell" forIndexPath:indexPath];
    cell.asset = [mutAssets objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(75, 75);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(6, 0, 0, 0);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedAssetUrls.count >= maxSelectLimit) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"你最多可以选择%ld张照片", (long)maxSelectLimit] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [[mutAssets objectAtIndex:indexPath.row] valueForProperty:ALAssetPropertyAssetURL];
    [selectedAssetUrls addObject:url];
    [self updateSendBtn];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [[mutAssets objectAtIndex:indexPath.row] valueForProperty:ALAssetPropertyAssetURL];
    [selectedAssetUrls removeObject:url];
    [self updateSendBtn];
}

@end
