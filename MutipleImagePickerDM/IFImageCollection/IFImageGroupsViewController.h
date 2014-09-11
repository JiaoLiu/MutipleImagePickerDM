//
//  IFImageGroupsViewController.h
//  imagePicker
//
//  Created by Jiao on 14-9-9.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface IFImageGroupsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSMutableArray *assetsGroups;
@property (nonatomic, strong)ALAssetsLibrary *assetsLibrary;

@end
