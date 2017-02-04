//
//  CWLClipView.m
//  CWLGraphicsDemo
//
//  Created by allen_Chan on 2017/2/3.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CWLClipView.h"

@interface CWLClipView ()

{
    CGPoint startPoint;
    CGRect clipRect;
}

@end

@implementation CWLClipView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGFloat f[3] = {10.0,5.0};
    CGContextSetLineDash(context, 2, f, 2);
    CGContextStrokeRect(context, clipRect);
}

#pragma mark touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    startPoint = [touches.anyObject locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    clipRect = CGRectMake(startPoint.x, startPoint.y, currentPoint.x-startPoint.x,currentPoint.y-startPoint.y);
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.clipDelegate respondsToSelector:@selector(clipImageInRect:)]) {
        [self.clipDelegate clipImageInRect:clipRect];
        clipRect = CGRectZero;
        [self setNeedsDisplay];
    }
}

@end
