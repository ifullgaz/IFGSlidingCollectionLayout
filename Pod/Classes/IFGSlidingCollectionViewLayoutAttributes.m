//
//  IFGSlidingCollectionViewLayoutAttributes.m
//  IFGSlidingCollectionViewLayout
//
//  Created by Emmanuel Merali on 05/01/2015.
//  Copyright (c) 2015 Mobli. All rights reserved.
//

#import "IFGSlidingCollectionViewLayoutAttributes.h"

@implementation IFGSlidingCollectionViewLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    IFGSlidingCollectionViewLayoutAttributes *newAttributes = [super copyWithZone:zone];
    newAttributes.slidingCellCollapsedHeight = self.slidingCellCollapsedHeight;
    newAttributes.slidingCellFeatureHeight = self.slidingCellFeatureHeight;
    return newAttributes;
}

- (BOOL)isEqual:(id)object {
    IFGSlidingCollectionViewLayoutAttributes *otherAttributes = (IFGSlidingCollectionViewLayoutAttributes *)object;
    if (otherAttributes.slidingCellCollapsedHeight == self.slidingCellCollapsedHeight &&
        otherAttributes.slidingCellFeatureHeight == self.slidingCellFeatureHeight) {
        return [super isEqual:object];
    }
    return NO;
}

@end
