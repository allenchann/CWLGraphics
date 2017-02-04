//
//  CWLClipResultViewController.h
//  CWLGraphicsDemo
//
//  Created by allen_Chan on 2017/2/4.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWLClipResultViewController : UIViewController

@property (nonatomic, strong) UIImage *clipImage;

@property (nonatomic, assign) CGSize imageSize;

- (instancetype)initWithImage:(UIImage *)image imageSize:(CGSize)size;


@end
