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

- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)stringRect color:(UIColor *)color font:(UIFont *)font andImage:(UIImage *)image andImageRect:(CGRect)imageRect
{
    
    UIGraphicsBeginImageContext(self.size);
//    [color set];
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentRight;
    
    //水印文字
    [markString drawInRect:stringRect withAttributes:@{NSFontAttributeName:font,
                                                       NSParagraphStyleAttributeName:paragraphStyle,
                                                       NSForegroundColorAttributeName:color}];

    if (image) {
        //四个参数为水印图片的位置
        [image drawInRect:imageRect];
    }
    
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

@end
