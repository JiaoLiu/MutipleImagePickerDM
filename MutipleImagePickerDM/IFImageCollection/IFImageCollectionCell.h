//
//  IFImageCollectionCell.h
//  imagePicker
//
//  Created by Jiao on 14-9-10.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface IFImageCollectionCell : UICollectionViewCell

@property (nonatomic, strong)ALAsset *asset;
@property (nonatomic, strong)UIImageView *selectedIDC;
@property (nonatomic, strong)UIImageView *photo;

@end
