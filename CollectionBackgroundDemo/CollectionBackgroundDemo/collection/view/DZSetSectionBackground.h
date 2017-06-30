//
//  DZSetSectionBackground.h
//  爱定州
//
//  Created by CC on 2017/5/11.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const DZSetSectionBack = @"ccDecoration";

@protocol DZSetSectionBackgroundLayoutDelegate<NSObject>

@required
-(UIEdgeInsets)cccollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
-(CGSize)cccollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout headerForSectionAtIndex:(NSInteger)section;

@optional
-(CGSize)cccollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout footerForSectionAtIndex:(NSInteger)section;

@end
@interface DZSetSectionBackground : UICollectionViewFlowLayout
@property (nonatomic, assign)id<DZSetSectionBackgroundLayoutDelegate> mydelegate;

@end
