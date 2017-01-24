//
//  UIImage+CWLImage.m
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/24.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "UIImage+CWLImage.h"

@implementation UIImage (CWLImage)

- (UIImage *)cutImagewithRect:(CGRect)rect {
    //对获取图片进行处理,删除顶部图片
    CGImageRef imagRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* newImage = [UIImage imageWithCGImage: imagRef];
    CGImageRelease(imagRef);
    
    return newImage;
}

@end
