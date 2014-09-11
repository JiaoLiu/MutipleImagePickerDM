//
//  IFImageCollecionViewController.h
//  imagePicker
//
//  Created by Jiao on 14-9-10.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface IFImageCollecionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)ALAssetsGroup *assetGroup;
@property (nonatomic, assign)NSInteger maxSelectLimit;
@property (nonatomic, strong)NSMutableOrderedSet *selectedAssetUrls;
@property (nonatomic, strong)NSMutableArray *mutAssets;

@end
