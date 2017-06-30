//
//  DZServiceCollectionCell.h
//  爱定州
//
//  Created by CC on 2017/5/10.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZServiceItem;
static NSString *const DZServiceCollectionCellID = @"DZServiceCollectionCellID";
@interface DZServiceCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic, weak) DZServiceItem *model;

@end
