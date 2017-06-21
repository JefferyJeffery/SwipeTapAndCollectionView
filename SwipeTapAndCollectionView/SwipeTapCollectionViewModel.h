//
//  SwipeTapCollectionViewModel.h
//  SwipeTapAndCollectionView
//
//  Created by Jeffery on 6/20/17.
//  Copyright © 2017 JY_Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwipeTapCollectionViewModel : NSObject
-(NSInteger)getNumberOfItemsInSection:(NSInteger)section;
-(NSAttributedString *)getStringAtIndexPath:(NSIndexPath *)indexPath;

-(CGSize)getMaxWidthOfItemsWithCollectionView:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath;
@end
