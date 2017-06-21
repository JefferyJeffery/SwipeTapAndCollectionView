//
//  UILabelCollectionViewCell.m
//  SwipeTapAndCollectionView
//
//  Created by Jeffery on 6/19/17.
//  Copyright © 2017 JY_Test. All rights reserved.
//

#import "UILabelCollectionViewCell.h"

#import "UICollectionCellBackgroundView.h"
#import "UICollectionCellSelectedBackgroundView.h"

@interface UILabelCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@end

@implementation UILabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.numberOfLines = 0;
    
    self.backgroundView = [[UICollectionCellBackgroundView alloc] initWithFrame:CGRectZero];
    [self.backgroundView setBackgroundColor:[UIColor yellowColor]];
    
    
//    self.selectedBackgroundView = [[UICollectionCellSelectedBackgroundView alloc] initWithFrame:CGRectZero];
//    self.selectedBackgroundView.backgroundColor = [UIColor redColor];
}

-(void)setTitleAttributedString:(NSAttributedString *)attributedString
{
    [self.titleLabel setAttributedText:attributedString];
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        [self.backgroundView setBackgroundColor:[UIColor blueColor]];
    } else {
        [self.backgroundView setBackgroundColor:[UIColor yellowColor]];
    }
}

@end
