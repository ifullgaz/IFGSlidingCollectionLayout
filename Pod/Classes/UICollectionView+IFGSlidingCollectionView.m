//
//  UICollectionView+IFGSlidingCollectionView.m
//  Pods
//
//  Created by Emmanuel Merali on 27/10/2015.
//
//

#import "UICollectionView+IFGSlidingCollectionView.h"
#import "IFGSlidingCollectionViewLayout.h"

@implementation UICollectionView (IFGSlidingCollectionLayout)

- (void)showItemOnTopAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    IFGSlidingCollectionViewLayout *layout = (IFGSlidingCollectionViewLayout *)self.collectionViewLayout;
    [layout applyLayoutForItemOnTopAtIndexPath:indexPath animated:animated];
}

@end
