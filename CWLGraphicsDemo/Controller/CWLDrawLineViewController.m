
//
//  CWLDrawLineViewController.m
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CWLDrawLineViewController.h"
#import "CWLDrawLineView.h"

@interface CWLDrawLineViewController ()

@end

@implementation CWLDrawLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"DrawLine";
    CWLDrawLineView *view = [[CWLDrawLineView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
