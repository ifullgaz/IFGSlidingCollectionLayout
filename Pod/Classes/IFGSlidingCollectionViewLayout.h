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
//  IFGSlidingCollectionViewLayout.h
//  IFGSlidingCollectionViewLayout
//
//  Created by Emmanuel Merali on 05/01/2015.
//  Copyright (c) 2015 Mobli. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IFGSlidingCollectionViewLayoutDelegate <NSObject>

- (CGFloat)heightForFeatureCell;
- (CGFloat)heightForCollapsedCell;

@end

@interface IFGSlidingCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) id<IFGSlidingCollectionViewLayoutDelegate> delegate;
@property (assign, nonatomic) CGFloat                       slidingCellFeatureHeight;
@property (assign, nonatomic) CGFloat                       slidingCellCollapsedHeight;
@property (assign, nonatomic) CGFloat                       slidingCellDragDumping;
@property (assign, nonatomic) UIEdgeInsets                  insets;

- (CGFloat)currentCellIndex;
- (void)postInitialization;
- (void)applyLayoutForItemOnTopAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end

