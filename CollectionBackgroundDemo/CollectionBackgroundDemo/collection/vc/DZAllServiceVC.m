//
//  DZAllServiceVC.m
//  爱定州
//
//  Created by CC on 2017/5/10.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import "DZAllServiceVC.h"


#import "DZAllServiceViewModel.h"

#import "DZServiceListResponse.h"
#import "DZServiceListRequest.h"

#import "DZServiceCollectionCell.h"

#import "DZSetSectionBackground.h"

#import "Header.h"

@interface DZAllServiceVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZSetSectionBackgroundLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mycollection;

@property (nonatomic, strong)DZAllServiceViewModel *manager;
@property (nonatomic,strong) DZServiceListRequest *requset;
@property (nonatomic,strong) DZServiceListResponse *response;

@property (nonatomic, strong)NSMutableArray *dataSouce;

@end

static NSString *const SectionHeader = @"SectionHeader";
static NSString *const SectionFooter = @"SectionFooter";
static const CGFloat  SectionHeaderHeight = 40;
static const CGFloat  SectionFooterrHeight = 10;

@implementation DZAllServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部";
    
    [self initCollection];
    
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get data
-(void)getData{
    __weak typeof(self) weakself = self;
   self.requset = [self.manager getServiceRequest:self.requset andSuccess:^(id response) {
        weakself.response = response;
        if (response) {
            [weakself.dataSouce addObjectsFromArray:weakself.response.result];
            [weakself.mycollection reloadData];
        }
        
    } andError:^(id error) {
        
    }];
}

#pragma mark - init ui
-(void)initCollection{
    [self.mycollection registerNib:[UINib nibWithNibName:@"DZServiceCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DZServiceCollectionCellID];
    
    [self.mycollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SectionHeader];
    [self.mycollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SectionFooter];

    self.mycollection.delegate = self;
    self.mycollection.dataSource = self;
    
    DZSetSectionBackground *layout = [[DZSetSectionBackground alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//UICollectionViewScrollDirectionHorizontal;//UICollectionViewScrollDirectionVertical;
    layout.mydelegate = self;
    self.mycollection.collectionViewLayout = layout;
    self.mycollection.backgroundColor = RGB(234, 234, 234, 1);
}

#pragma mark - property
-(DZServiceListRequest*)requset{
    if (_requset==nil) {
        _requset = [[DZServiceListRequest alloc] init];
    }
    return _requset;
}
-(DZAllServiceViewModel*)manager{
    if (_manager==nil) {
        _manager = [[DZAllServiceViewModel alloc] init];
    }
    return _manager;
}

-(NSMutableArray*)dataSouce{
    if (_dataSouce==nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

#pragma mark - collection
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    DZServiceListItem *item = self.dataSouce[section];
    return item.catalogList.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSouce.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DZServiceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DZServiceCollectionCellID forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DZServiceCollectionCell" owner:nil options:nil] firstObject];
    }
    DZServiceListItem *item = self.dataSouce[indexPath.section];

    DZServiceItem *model = item.catalogList[indexPath.row];
    cell.model = model;
    
    return cell;
}

/**
 /定义每个Section 的 margin 边距

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 15, 5, 15);
}

/**
 定义每个UICollectionViewCell 的大小

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param indexPath indexPath description
 @return return value description
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth-100)/3.0, (ScreenWidth-(100/ScreenSizeScale))/3.0);
}

/**
 每个section中不同的行之间的行间距

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 15;
}

/**
 组 之中 每个item之间的间距

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 30;
}

/**
 collection 组 头尾  背景  view 返回回调

 @param collectionView collectionView description
 @param kind kind description
 @param indexPath indexPath description
 @return return value description
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind==DZSetSectionBack) {
        //背景设置 在自定义 view 里面这里设置无效
        UICollectionReusableView *view =[self.mycollection supplementaryViewForElementKind:DZSetSectionBack atIndexPath:indexPath];

        return view;
    }else
        //组头 设置
        if (kind==UICollectionElementKindSectionHeader){
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SectionHeader forIndexPath:indexPath];
        if (view==nil) {
            view = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,SectionHeaderHeight)];
        }
            UILabel *title = [view viewWithTag:1111];
            if (title==nil) {
                title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20,20)];
                title.tag = 1111;
                title.font = [UIFont systemFontOfSize:15];
                title.textColor = RGB(115, 115, 115, 1);
                title.textAlignment = NSTextAlignmentCenter;
                [view addSubview:title];
                title.backgroundColor = [UIColor clearColor];
            }
            DZServiceListItem *item = self.dataSouce[indexPath.section];
            view.backgroundColor = [UIColor clearColor];//RGB(234, 234, 234, 1);

            title.text = item.catalog.catalogName;
            
        return view;
    }else if (kind==UICollectionElementKindSectionFooter){
        //组 底部设置
         UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SectionFooter forIndexPath:indexPath];
        if (view==nil) {
            view = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,SectionFooterrHeight)];
        }
        view.backgroundColor =[UIColor clearColor];// RGB(234, 234, 234, 1);
        return view;
    }
    return nil;
}

/**
 collection 组 header size

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(ScreenWidth, SectionHeaderHeight);
}

/**
 collection  组 footer size

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, SectionFooterrHeight);
}


/**
 collection 选择每一个 item 回调

 @param collectionView collectionView description
 @param indexPath indexPath description
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DZServiceListItem *item = self.dataSouce[indexPath.section];
    
    DZServiceItem *model = item.catalogList[indexPath.row];
    [self pushWith:model];
}

#pragma mark - DZSetSectionBackgroundLayoutDelegate

/**
 自定义 layout 回调 返回 每一组 背景的边距

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
-(UIEdgeInsets)cccollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, -10, 5);//可以调整背景图宽度
}

/**
 获取 collection header 大小

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
-(CGSize)cccollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout headerForSectionAtIndex:(NSInteger)section{
    return CGSizeMake(ScreenWidth, SectionHeaderHeight);

}

/**
 获取 collection footer 大小 

 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 @return return value description
 */
-(CGSize)cccollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout footerForSectionAtIndex:(NSInteger)section{
    return CGSizeMake(ScreenWidth, SectionFooterrHeight);

}

#pragma mark - push  option
-(void)pushWith:(DZServiceItem*)model{
    
}

@end
