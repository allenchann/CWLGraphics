//
//  CWLClipResultViewController.m
//  CWLGraphicsDemo
//
//  Created by allen_Chan on 2017/2/4.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CWLClipResultViewController.h"

@interface CWLClipResultViewController ()

@end

@implementation CWLClipResultViewController

- (instancetype)initWithImage:(UIImage *)image imageSize:(CGSize)size {
    self = [super init];
    self.title = @"结果";
    self.imageSize = size;
    self.clipImage = image;
    
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];   
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.equalTo(@(self.imageSize.height));
        make.width.equalTo(@(self.imageSize.width));
    }];
    
    
    imageView.image = self.clipImage;
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
