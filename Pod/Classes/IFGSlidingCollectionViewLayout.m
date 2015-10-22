/***********************************************************************************
 *
 * Copyright (c) 2014 Robots and Pencils Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 ***********************************************************************************/

//
//  AbstractHelpersCollectionViewLayout.m
//  Helprz
//
//  Created by Emmanuel Merali on 05/01/2015.
//  Copyright (c) 2015 Mobli. All rights reserved.
//

#import "IFGSlidingCollectionViewLayout.h"
#import "IFGSlidingCollectionViewLayoutAttributes.h"

@interface IFGSlidingCollectionViewLayout ()

@property (strong, nonatomic) NSDictionary                  *layoutAttributes;
@property (readonly, nonatomic) CGFloat                     slidingCellDragVelocity;

@end

@interface IFGSlidingCollectionViewLayout (Private)

- (CGFloat)currentCellIndex;
- (CGFloat)featureHeight;
- (CGFloat)collapsedHeight;

@end


@implementation IFGSlidingCollectionViewLayout (Private)

- (CGFloat)currentCellIndex {
    return (self.collectionView.contentOffset.y / self.slidingCellDragVelocity);
}

- (CGFloat)featureHeight {
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForFeatureCell)]) {
        return [self.delegate heightForFeatureCell];
    }
    else {
        return self.slidingCellFeatureHeight;
    }
}

- (CGFloat)collapsedHeight {
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForCollapsedCell)]) {
        return [self.delegate heightForCollapsedCell];
    }
    else {
        return self.slidingCellCollapsedHeight;
    }
}

@end

@implementation IFGSlidingCollectionViewLayout

- (void)postInitialization {
    self.slidingCellFeatureHeight = 240;
    self.slidingCellCollapsedHeight = 88;
    self.slidingCellDragDumping = 1.0;
    self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize some defaults
        [self postInitialization];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self postInitialization];
}

- (void)prepareLayout {
    [super prepareLayout];

    CGFloat collectionViewWidth = self.collectionView.bounds.size.width - self.insets.left - self.insets.right;
    CGFloat currentCellIndex = [self currentCellIndex];
    NSInteger topFeatureIndex = MAX(0, (NSInteger)currentCellIndex);
    CGFloat topCellsInterpolation =  currentCellIndex - (CGFloat)topFeatureIndex;
    NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
    
    // last rect will be used to calculate frames past the first one.  We initialize it to a non junk 0 value
    CGRect lastRect = CGRectMake(self.insets.left, self.insets.top, collectionViewWidth, self.slidingCellCollapsedHeight);
    NSInteger numItems = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat featureHeight = [self featureHeight];
    CGFloat normalHeight = [self collapsedHeight];
    
    NSIndexPath *indexPath;
    for (NSInteger itemIndex = 0; itemIndex < numItems; itemIndex++) {
        indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
        
        IFGSlidingCollectionViewLayoutAttributes *attributes = [IFGSlidingCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.slidingCellCollapsedHeight = normalHeight;
        attributes.slidingCellFeatureHeight = featureHeight;
        attributes.zIndex = itemIndex;
        NSInteger yValue = self.insets.top;
        
        if (itemIndex <= topFeatureIndex) {
            // before our top feature cell
            CGFloat yOffset = normalHeight * (topFeatureIndex - itemIndex + topCellsInterpolation);
            yValue+= self.collectionView.contentOffset.y - yOffset;
            attributes.frame = CGRectMake(self.insets.left, yValue, collectionViewWidth, featureHeight);
        }
        else if (itemIndex == (topFeatureIndex + 1) && itemIndex != numItems) {
            // the cell after the feature which grows into one as it goes up unless its the last cell (back to top)
            yValue = lastRect.origin.y + lastRect.size.height;
            CGFloat bottomYValue = yValue + normalHeight;
            CGFloat amountToGrow = MAX((featureHeight - normalHeight) * topCellsInterpolation, 0);
            NSInteger newHeight = normalHeight + amountToGrow;
            attributes.frame = CGRectMake(self.insets.left, bottomYValue - newHeight, collectionViewWidth, newHeight);
        }
        else {
            // all other cells above or below those on screen
            yValue = lastRect.origin.y + lastRect.size.height;
            attributes.frame = CGRectMake(self.insets.left, yValue, collectionViewWidth, normalHeight);
        }
        
        lastRect = attributes.frame;
        [layoutAttributes setObject:attributes forKey:indexPath];
    }
    
    self.layoutAttributes = layoutAttributes;
}

- (CGSize)collectionViewContentSize {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    CGFloat height = ((numberOfItems - 1) * self.slidingCellDragVelocity) + self.collectionView.frame.size.height;
    return CGSizeMake(self.collectionView.frame.size.width, height);
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // create layouts for the rectangles in the view
    NSMutableArray *attributesInRect =  [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in [self.layoutAttributes allValues]) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [attributesInRect addObject:attributes];
        }
    }
    
    return attributesInRect;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat proposedPageIndex = roundf(proposedContentOffset.y / self.slidingCellDragVelocity);
    CGFloat nearestPageOffset = proposedPageIndex * self.slidingCellDragVelocity;
    return CGPointMake(proposedContentOffset.x, nearestPageOffset);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutAttributes[indexPath];
}

// bounds change causes prepareLayout if YES
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

- (void)setSlidingCellDragDumping:(CGFloat)slidingCellDragDumping {
    if (self.slidingCellDragDumping != slidingCellDragDumping) {
        [self willChangeValueForKey:@"slidingCellDragDumping"];
        _slidingCellDragDumping = slidingCellDragDumping;
        [self didChangeValueForKey:@"slidingCellDragDumping"];
    }
}

- (CGFloat)slidingCellDragVelocity {
    return self.slidingCellCollapsedHeight / self.slidingCellDragDumping;
}
@end

