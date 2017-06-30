//
//  DZServiceListResponse.h
//  爱定州
//
//  Created by CC on 2017/5/10.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZServiceItem : NSObject
@property (nonatomic, copy)NSString *catalogId;
@property (nonatomic, copy)NSString *catalogName;
@property (nonatomic, copy)NSString *parentCatalogId;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *smallImgPath;
@property (nonatomic, copy)NSString *url;

@end

@interface DZServiceListItem : NSObject
@property (nonatomic,strong) NSMutableArray <DZServiceItem*> *catalogList;

@property (nonatomic,strong) DZServiceItem *catalog;


@end

@interface DZServiceListResponse : NSObject
@property (nonatomic,strong) NSMutableArray <DZServiceListItem*> *result;

@end
