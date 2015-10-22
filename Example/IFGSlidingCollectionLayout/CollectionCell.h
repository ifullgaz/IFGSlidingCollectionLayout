//
//  HLPHelperCollectionCell.h
//  Helprz
//
//  Created by Emmanuel Merali on 05/01/2015.
//  Copyright (c) 2015 Pit'n'Pack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell

@property (weak, readonly) UIImageView                      *backgroundImageView;
@property (weak, readonly) UILabel                          *textLabel;
@property (weak, readonly) UILabel                          *detailTextLabel;

@property (assign, nonatomic) CGFloat                       normalImageCoverAlpha;
@property (assign, nonatomic) CGFloat                       featuredImageCoverAlpha;

@end
