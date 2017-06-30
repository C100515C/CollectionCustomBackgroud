//
//  DZAllServiceViewModel.h
//  爱定州
//
//  Created by CC on 2017/5/10.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZServiceListRequest;
@class DZServiceListResponse;

typedef void (^RequestSuccess)(id response);
typedef void (^RequestError)(id error);

@interface DZAllServiceViewModel : NSObject

-(DZServiceListRequest*)getServiceRequest:(DZServiceListRequest*)request andSuccess:(RequestSuccess)success andError:(RequestError)error;

@end
