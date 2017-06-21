//
//  SwipeTapCollectionView.m
//  SwipeTapAndCollectionView
//
//  Created by Jeffery on 6/19/17.
//  Copyright © 2017 JY_Test. All rights reserved.
//

#import "SwipeTapCollectionView.h"
#import "SwipeTapCollectionViewModel.h"

#import "SwipeTapCollectionViewFlowLayout.h"

#import "UILabelCollectionViewCell.h"


@interface SwipeTapCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) SwipeTapCollectionViewModel *viewModel;
@end

@implementation SwipeTapCollectionView

-(SwipeTapCollectionViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SwipeTapCollectionViewModel alloc] init];
    }
    return _viewModel;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    SwipeTapCollectionViewFlowLayout *layout = [[SwipeTapCollectionViewFlowLayout alloc] init];
    self.collectionViewLayout = layout;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.showsHorizontalScrollIndicator = NO;
    
    [self setCollectionCell];
}


-(void)setCollectionCell
{
    [self registerNib:[UINib nibWithNibName:@"UILabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UILabelCollectionViewCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel getNumberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UILabelCollectionViewCell" forIndexPath:indexPath];
    [cell setTitleAttributedString:[self.viewModel getStringAtIndexPath:indexPath]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel getMaxWidthOfItemsWithCollectionView:collectionView AtIndexPath:indexPath];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    SwipeTapCollectionViewFlowLayout *flowLayout = (SwipeTapCollectionViewFlowLayout *)collectionViewLayout;
    CGFloat itemSpacing = flowLayout.minimumInteritemSpacing;
    
    CGFloat numberOfItems = [self.viewModel getNumberOfItemsInSection:section];
    
    CGFloat edgeLeft = MAXFLOAT;
    CGFloat itemsAndSpacingWidth = 0.0;
    CGFloat horizontalCenter = CGRectGetWidth(collectionView.frame) / 2.0;

    for (NSUInteger i = 0; i < numberOfItems; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat widthOfItem = [self.viewModel getMaxWidthOfItemsWithCollectionView:collectionView AtIndexPath:indexPath].width;
        
        CGFloat delta = horizontalCenter - (itemsAndSpacingWidth + (widthOfItem / 2.0));
        if (delta > 0 && delta < edgeLeft) {
            edgeLeft = delta;
        } else {
            break;
        }
        
        itemsAndSpacingWidth +=  widthOfItem + itemSpacing;
    }
    
    
    NSInteger rowsCount = [self.viewModel getNumberOfItemsInSection:section];
    
    if (rowsCount > 0) {
        
        NSAttributedString *stringN = [self.viewModel getStringAtIndexPath:[NSIndexPath indexPathForItem:rowsCount-1 inSection:section]];
        CGFloat itemNWidth = [stringN boundingRectWithSize:CGSizeMake(FLT_MAX,CGRectGetHeight(collectionView.frame)) options:NSStringDrawingUsesLineFragmentOrigin context:NULL].size.width;
        
        CGFloat collectionWidth = CGRectGetWidth(collectionView.frame);

        return UIEdgeInsetsMake(0.0,
                                edgeLeft,
                                0.0,
                                (collectionWidth - itemNWidth) / 2.0);
        
    }
    
    return UIEdgeInsetsZero;
}

#pragma mark - UICollectionViewDelegate

#pragma mark Highlight
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UILabelCollectionViewCell" forIndexPath:indexPath];
    
    [cell setHighlighted:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UILabelCollectionViewCell" forIndexPath:indexPath];
    
    [cell setHighlighted:NO];
}

#pragma mark Select
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UILabelCollectionViewCell" forIndexPath:indexPath];
    [cell setSelected:![cell isSelected]];
    
    if ([cell isSelected]) {
        [cell.backgroundView setBackgroundColor:[UIColor blueColor]];
    } else {
        [cell.backgroundView setBackgroundColor:[UIColor yellowColor]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UILabelCollectionViewCell" forIndexPath:indexPath];
    
    [cell setSelected:NO];
}

//#pragma mark - UIScrollViewDelegate<NSObject>
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    //    *targetContentOffset = CGPointMake(0,0);
//    NSLog(@"scrollViewWillEndDragging velocity = %@",NSStringFromCGPoint(velocity));
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"scrollViewDidEndDragging decelerate = %@",@(decelerate));
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollViewDidEndDecelerating = %@",scrollView);
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollViewDidEndScrollingAnimation = %@",scrollView);
//}
@end
