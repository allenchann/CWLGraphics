//
//  UIImage+CWLImage.h
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/24.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CWLImage)

- (UIImage *)cutImagewithRect:(CGRect)rect;

- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)stringRect color:(UIColor *)color font:(UIFont *)font andImage:(UIImage *)image andImageRect:(CGRect)imageRect;

@end
