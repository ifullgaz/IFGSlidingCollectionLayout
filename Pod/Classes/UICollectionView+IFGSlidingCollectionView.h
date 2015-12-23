//
//  UICollectionView+IFGSlidingCollectionView.h
//  Pods
//
//  Created by Emmanuel Merali on 27/10/2015.
//
//

#import <UIKit/UIKit.h>

@interface UICollectionView (IFGSlidingCollectionView)

- (NSIndexPath *)indexPathForTopItem;
- (void)showItemOnTopAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end
