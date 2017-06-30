//
//  ViewController.m
//  CollectionBackgroundDemo
//
//  Created by CC on 2017/6/30.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ViewController.h"
#import "DZAllServiceVC.h"

@interface ViewController ()
- (IBAction)test:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)test:(id)sender {
    DZAllServiceVC *vc = [[DZAllServiceVC alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
@end
