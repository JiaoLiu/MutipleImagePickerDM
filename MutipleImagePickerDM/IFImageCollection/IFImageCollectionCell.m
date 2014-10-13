//
//  IFImageCollectionCell.m
//  imagePicker
//
//  Created by Jiao on 14-9-10.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import "IFImageCollectionCell.h"

@implementation IFImageCollectionCell

@synthesize asset = _asset;
@synthesize selectedIDC;
@synthesize photo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        photo = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        photo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:photo];
        
        selectedIDC = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, 5, 25, 25)];
        selectedIDC.image = [UIImage imageNamed:@"icon_photo_able"];
        [photo addSubview:selectedIDC];
    }
    return self;
}

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    photo.image = [UIImage imageWithCGImage:[asset thumbnail]];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        selectedIDC.image = [UIImage imageNamed:@"icon_photo_add"];
    }
    else
    {
        selectedIDC.image = [UIImage imageNamed:@"icon_photo_able"];
    }
}

@end
