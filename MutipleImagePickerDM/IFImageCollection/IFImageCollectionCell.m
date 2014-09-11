//
//  IFImageCollectionCell.m
//  imagePicker
//
//  Created by Jiao on 14-9-10.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import "IFImageCollectionCell.h"

@implementation IFImageCollectionCell

@synthesize asset;
@synthesize selectedIDC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImageView *photo = [[UIImageView alloc] initWithFrame:rect];
    photo.image = [UIImage imageWithCGImage:[asset thumbnail]];
    [self.contentView addSubview:photo];
    
    selectedIDC = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width - 30, 5, 25, 25)];
    selectedIDC.image = [UIImage imageNamed:@"icon_photo_able"];
    [photo addSubview:selectedIDC];
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
