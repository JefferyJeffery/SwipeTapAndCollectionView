//
//  SwipeTapCollectionViewModel.m
//  SwipeTapAndCollectionView
//
//  Created by Jeffery on 6/20/17.
//  Copyright © 2017 JY_Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeTapCollectionViewModel.h"
#import "NSString+untils.h"

@interface SwipeTapCollectionViewModel ()
@property (nonnull, nonatomic, strong, readonly) NSArray *brandTitles;
@property (nonnull, nonatomic, strong, readonly) NSMutableArray *brandTitlesWidth;
@end

@implementation SwipeTapCollectionViewModel
#pragma mark -
-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _brandTitles = @[
                         [@"Tatum Mel2344endez" attributedBrandTitle],
                         [@"Femrewerwale" attributedBrandTitle],
                         [@"1934343460-03-16" attributedBrandTitle],
                         [@"040-01-0867" attributedBrandTitle],
                         [@"9601 C23lifton Court" attributedBrandTitle],
                         [@"East Wind342434sor Hill, CT 06028" attributedBrandTitle],
                         [@"(8608888888) 597-8359" attributedBrandTitle],
                         [@"tatummelendezHJv" attributedBrandTitle]
                         ];
        
        _brandTitlesWidth = nil;
    }
    
    return self;
}

-(CGSize)getMaxWidthOfItemsWithCollectionView:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath
{
    if (_brandTitlesWidth == nil) {
        _brandTitlesWidth = [NSMutableArray array];
        for (NSAttributedString *attributedString in _brandTitles) {
            CGSize size = [attributedString boundingRectWithSize:CGSizeMake(FLT_MAX,CGRectGetHeight(collectionView.frame)) options:NSStringDrawingUsesLineFragmentOrigin context:NULL].size;
            [_brandTitlesWidth addObject:[NSValue valueWithCGSize:CGSizeMake(ceil(size.width), size.height)]];
        }
    }
    
    NSValue *value = [_brandTitlesWidth objectAtIndex:indexPath.row];
    
    return [value CGSizeValue];
}


-(NSInteger)getNumberOfItemsInSection:(NSInteger)section
{
    return [_brandTitles count];
}

-(NSAttributedString *)getStringAtIndexPath:(NSIndexPath *)indexPath
{
    return [_brandTitles objectAtIndex:indexPath.row];
}

@end
