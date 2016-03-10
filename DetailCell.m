//
//  DetailCell.m
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)btnFavoriteClick:(UIButton*)sender
{
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailCell_ClickedFavorite:)])
    {
        [self.delegate detailCell_ClickedFavorite:self];
    }
}
@end
