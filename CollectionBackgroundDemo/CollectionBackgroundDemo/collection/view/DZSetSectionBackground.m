//
//  DZSetSectionBackground.m
//  爱定州
//
//  Created by CC on 2017/5/11.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import "DZSetSectionBackground.h"
#import "DZMyBackReusableView.h"
#import "Header.h"

@interface DZSetSectionBackground ()
/**
 存储 布局的 att
 */
@property (nonatomic,strong) NSMutableArray *layoutInfoArr;

/**
 collection 滑动区域大小
 */
@property (nonatomic,assign) CGSize contentSize;
@end
@implementation DZSetSectionBackground

/**
 布局 布局配置数据  布局前的准备会调用这个方法
 */
- (void)prepareLayout{
    [super prepareLayout];
    //获取布局信息
    [self registerClass:[DZMyBackReusableView class] forDecorationViewOfKind:DZSetSectionBack];
    
    [self.layoutInfoArr removeAllObjects];
    CGRect tmpsectionFrame = CGRectZero;
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < numberOfSections; section++){
        
        NSInteger num = [self.collectionView numberOfItemsInSection:section];
        UICollectionViewLayoutAttributes *first = nil;//组第一个 item att
        UICollectionViewLayoutAttributes *last = nil;//组最后一个 item att
        if (num>0) {
            first = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            last = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:num-1 inSection:section]];
        }
        
        UIEdgeInsets sectionInset = self.sectionInset;
        UIEdgeInsets inset = [self.mydelegate cccollectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        
        if (!UIEdgeInsetsEqualToEdgeInsets(inset, UIEdgeInsetsZero)) {
            sectionInset = inset;
        }
        
        CGSize headerSize = [self.mydelegate cccollectionView:self.collectionView layout:self headerForSectionAtIndex:section];
//        CGSize footerSize = [self.mydelegate cccollectionView:self.collectionView layout:self footerForSectionAtIndex:section];
        
        
        CGRect sectionFrame = CGRectZero;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame = CGRectMake(CGRectGetMinX(first.frame)-headerSize.width+sectionInset.left, CGRectGetMinY(first.frame)+sectionInset.top, CGRectGetMaxX(last.frame)-sectionInset.right, CGRectGetMaxY(last.frame)-sectionInset.bottom);
            sectionFrame.origin.y = sectionInset.top;

            sectionFrame.size.width = sectionFrame.size.width-sectionFrame.origin.x;
            sectionFrame.size.height = CGRectGetHeight(self.collectionView.frame)-sectionInset.top-sectionInset.bottom;
        } else {
            
            sectionFrame = CGRectMake(CGRectGetMinX(first.frame), CGRectGetMinY(first.frame)-headerSize.height+sectionInset.top, CGRectGetMaxX(last.frame), CGRectGetMaxY(last.frame)-sectionInset.bottom);
            sectionFrame.origin.x = sectionInset.left;
            
            sectionFrame.size.width = CGRectGetWidth(self.collectionView.frame)-sectionInset.left-sectionInset.right;
            sectionFrame.size.height = sectionFrame.size.height-sectionFrame.origin.y;

        }
     
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForDecorationViewOfKind:DZSetSectionBack atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        att.frame = sectionFrame;
        att.zIndex = -1;
        att.hidden = NO;

        [self.layoutInfoArr addObject:att];
        
        tmpsectionFrame = sectionFrame;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *rt = [NSMutableArray array];
    [rt addObjectsFromArray:arr];
    for (UICollectionViewLayoutAttributes *att in self.layoutInfoArr) {
        if (CGRectIntersectsRect(att.frame, rect)) {
            [rt addObject:att];
        }
    }
    return rt;
}



-(NSMutableArray *)layoutInfoArr{
    if (_layoutInfoArr==nil) {
        _layoutInfoArr = [NSMutableArray array];
    }
    return _layoutInfoArr;
}

-(UICollectionViewLayoutAttributes*)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    return attrs;
}

@end
