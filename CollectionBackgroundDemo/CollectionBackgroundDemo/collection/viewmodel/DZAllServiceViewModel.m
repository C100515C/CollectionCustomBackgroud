//
//  DZAllServiceViewModel.m
//  爱定州
//
//  Created by CC on 2017/5/10.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import "DZAllServiceViewModel.h"

#import "DZServiceListRequest.h"
#import "DZServiceListResponse.h"
#import "Header.h"
//宾馆居住
@implementation DZAllServiceViewModel

-(DZServiceListRequest*)getServiceRequest:(DZServiceListRequest*)request andSuccess:(RequestSuccess)success andError:(RequestError)error{
    if (request==nil) {
        request = [[DZServiceListRequest alloc] init];
    }
    
    DZServiceListResponse *res = [[DZServiceListResponse alloc] init];
    NSMutableArray *sectionArr = [NSMutableArray array];
    
    for (int i=0; i<10; i++) {
        DZServiceListItem *section = [[DZServiceListItem alloc] init];
        
        DZServiceItem *title = [[DZServiceItem alloc] init];
        title.catalogName = [NSString stringWithFormat:@"第%d组",i];
        
        section.catalog = title;
        section.catalogList = [NSMutableArray array];
        
        for (int j=0; j<6; j++) {
            DZServiceItem *cell = [[DZServiceItem alloc] init];
            cell.catalogName = [NSString stringWithFormat:@"第%d组",j];
            cell.smallImgPath = @"宾馆居住";
            [section.catalogList addObject:cell];
        }
        [sectionArr addObject:section];
    }
    res.result = sectionArr;
    
    if (success) {
        success(res);
    }
    
    if (error) {
        error(nil);
    }
    
    return request;
    

}


@end
