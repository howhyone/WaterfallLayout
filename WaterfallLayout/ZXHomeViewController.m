//
//  ZXHomeViewController.m
//  WaterfallLayout
//
//  Created by mob on 2018/8/8.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "ZXHomeViewController.h"
#import "ViewController.h"
@interface ZXHomeViewController ()

@end

@implementation ZXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"首页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickWaterfallBtn:(id)sender {
    
    ViewController *viewcontroller = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
