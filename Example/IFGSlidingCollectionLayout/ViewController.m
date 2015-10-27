//
//  ViewController.m
//  SliddingCollectionView
//
//  Created by Emmanuel Merali on 15/01/2015.
//  Copyright (c) 2015 mobli. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCell.h"
#import <IFGSlidingCollectionLayout/IFGSlidingCollectionLayout.h>

@interface ViewController ()

@end

@interface ViewController (UICollectionViewDelegate) <UICollectionViewDelegate, UICollectionViewDataSource>

@end


@implementation ViewController (UICollectionViewDelegate)

static NSString * const reuseIdentifier = @"CollectionCell";

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.item;
    CollectionCell *slidingMenuCell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // alternate for demo.  Simply set the properties of the passed in cell
    if (row % 2 == 0) {
        slidingMenuCell.textLabel.text = @"Something Special";
        slidingMenuCell.detailTextLabel.text = @"For your loved ones!";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"Image 1"];
    }else{
        
        slidingMenuCell.textLabel.text = @"This Thing Too";
        slidingMenuCell.detailTextLabel.text = @"This thing will blow your mind.";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"Image 2"];
    }
    
    return slidingMenuCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView showItemOnTopAtIndexPath:indexPath animated:YES];
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    IFGSlidingCollectionViewLayout *layout = (IFGSlidingCollectionViewLayout *)self.collectionViewLayout;
//    layout.slidingCellCollapsedHeight = 88;
//    layout.slidingCellFeatureHeight   = 240;
    layout.slidingCellDragDumping     = .5;
//    layout.insets = UIEdgeInsetsMake(100, 20, 50, 20);
}

@end
