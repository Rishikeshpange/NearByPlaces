//
//  DetailCell.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/5/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetailCellDelegate;
@interface DetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageType;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property(weak,nonatomic) id<DetailCellDelegate> delegate;
@property(nonatomic,strong)NSIndexPath* indexPath;
@property(nonatomic,strong)IBOutlet UIButton* btnFav;
@end

@protocol DetailCellDelegate <NSObject>

-(void)detailCell_ClickedFavorite:(DetailCell*)detailCell;

@end