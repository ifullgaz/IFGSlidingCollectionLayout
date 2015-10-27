//
//  CollectionCell.m
//  SliddingCollectionView
//
//  Created by Emmanuel Merali on 05/01/2015.
//  Copyright (c) 2015 Mobli. All rights reserved.
//

#import "CollectionCell.h"
#import <IFGSlidingCollectionLayout/IFGSlidingCollectionLayout.h>

@interface CollectionCell ()

@property (weak, nonatomic) IBOutlet UIView                 *imageCover;
@property (weak, nonatomic) IBOutlet UIImageView            *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel                *textLabel;
@property (weak, nonatomic) IBOutlet UILabel                *detailTextLabel;

@end


@implementation CollectionCell

- (void)postInitialisation {
    self.clipsToBounds = YES;
    self.normalImageCoverAlpha = 0.5f;
    self.featuredImageCoverAlpha = 0.2f;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self postInitialisation];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self postInitialisation];
    }
    return self;
}

- (void)applyLayoutAttributes:(IFGSlidingCollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];

    CGFloat slidingCellFeatureHeight = layoutAttributes.slidingCellFeatureHeight;
    CGFloat slidingCellCollapsedHeight = layoutAttributes.slidingCellCollapsedHeight;
    CGFloat featureNormaHeightDifference = slidingCellFeatureHeight - slidingCellCollapsedHeight;
    
    // how much its grown from normal to feature
    CGFloat amountGrown = slidingCellFeatureHeight - self.frame.size.height;
    
    // percent of growth from normal to feature
    CGFloat percentOfGrowth = 1 - (amountGrown / featureNormaHeightDifference);
    
    //Curve the percent so that the animations move smoother
    percentOfGrowth = sin(percentOfGrowth * M_PI_2);
    
    CGFloat scaleAndAlpha = MAX(percentOfGrowth, 0.5f);
    
    // scale title as it collapses but keep origin x the same and the y location proportional to view height.  Also fade in alpha
    self.textLabel.transform = CGAffineTransformMakeScale(scaleAndAlpha, scaleAndAlpha);
//    self.textLabel.center = self.contentView.center;
    
    // keep detail just under text label
//    self.detailTextLabel.center = CGPointMake(self.center.x, self.textLabel.center.y + 40.0f);
    
    // its convenient to set the alpha of the fading controls to the percent of growth value
    self.detailTextLabel.alpha = percentOfGrowth;
    
    // when full size, alpha of imageCover should be 20%, when collapsed should be 90%
    self.imageCover.alpha = self.normalImageCoverAlpha - (percentOfGrowth * (self.normalImageCoverAlpha - self.featuredImageCoverAlpha));
}

@end

