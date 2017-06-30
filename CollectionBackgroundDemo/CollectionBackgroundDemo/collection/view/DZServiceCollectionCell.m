//
//  DZServiceCollectionCell.m
//  爱定州
//
//  Created by CC on 2017/5/10.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import "DZServiceCollectionCell.h"
#import "DZServiceListResponse.h"

@implementation DZServiceCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(DZServiceItem *)model{
    self.pic.image =[UIImage imageNamed:model.smallImgPath];
    self.title.text =model.catalogName;
}

@end
