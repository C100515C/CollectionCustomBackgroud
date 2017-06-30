//
//  DZMyBackReusableView.m
//  爱定州
//
//  Created by CC on 2017/5/15.
//  Copyright © 2017年 白浩. All rights reserved.
//

#import "DZMyBackReusableView.h"

@implementation DZMyBackReusableView
- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        CGRect imageFrame = self.bounds;
        imageFrame.origin.x = 5;
        imageFrame.origin.y = 5;
        imageFrame.size.width -= 10;
        imageFrame.size.height -= 10;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:imageFrame];
        
        imageView.image=[UIImage imageNamed:@"话题背景"];
        
        [self addSubview:imageView];
        
        self.backgroundColor = [UIColor yellowColor];
        self.layer.cornerRadius = 5;
        self.layer.shadowColor =  [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    }
    
    return self;
    
}
@end
