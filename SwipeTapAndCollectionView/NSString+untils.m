//
//  NSMutableAttributedString+swaipeTapCollection.m
//  SwipeTapAndCollectionView
//
//  Created by Jeffery on 6/20/17.
//  Copyright © 2017 JY_Test. All rights reserved.
//

#import "NSString+untils.h"

#import <UIKit/UIKit.h>

@implementation NSString (swaipeTapCollection)
-(NSAttributedString *)attributedBrandTitle
{
    return
    [[NSAttributedString alloc] initWithString:self
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor colorWithRed:0.3 green:0.2 blue:0.5 alpha:1.0],
                                                 NSFontAttributeName: [UIFont fontWithName:@"Verdana" size:18.0]}];
}
@end
