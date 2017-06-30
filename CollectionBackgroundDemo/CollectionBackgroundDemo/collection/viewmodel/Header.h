//
//  Header.h
//  CollectionBackgroundDemo
//
//  Created by CC on 2017/6/30.
//  Copyright © 2017年 cc. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define RGB(r, g, b, a)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]
// 获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenSizeScale [UIScreen mainScreen].bounds.size.width/320.0

#endif /* Header_h */
