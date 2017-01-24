//
//  CWLDrawLineView.m
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CWLDrawLineView.h"
#define minLineWidth 3
#define maxLineWidth 10
@implementation CWLDrawLineView
{
    float lineWidth;
    UIView *disPlayColorView;
    UIColor *lineColor;
}


- (instancetype)init {
    if (self = [super init]) {
        [self setToolView];
        [self setColorView];
    }
    return self;
}

#pragma mark线段粗细,清空撤销
- (void)setToolView{
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    [self addSubview:toolView];
    
    toolView.layer.borderColor = [UIColor grayColor].CGColor;
    toolView.layer.borderWidth = .5;
    toolView.layer.cornerRadius = 3;
    lineWidth = 5;
    lineColor = [UIColor blackColor];
    NSArray *arr = @[@"AA",@"aa",@"清空",@"撤回"];
    
    for (int i = 0; i<4; i++) {
        UIButton *toolBtn = [[UIButton alloc]init];
        toolBtn.tag = 1000+i;
        
        toolBtn.frame = CGRectMake(i*40, 0, 40, 40);
        toolBtn.layer.borderColor = [UIColor grayColor].CGColor;
        toolBtn.layer.borderWidth = 1;
        toolBtn.layer.cornerRadius = 2;
        [toolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [toolBtn setTitle:arr[i] forState:UIControlStateNormal];
        [toolBtn addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [toolView addSubview:toolBtn];
    }
}

#pragma mark切换颜色
- (void)setColorView {
    
    UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(160, 0, SCREENWIDTH-160, 40)];
    colorView.layer.borderColor = [UIColor grayColor].CGColor;
    colorView.layer.borderWidth = .5;
    colorView.layer.cornerRadius = 3;
    [self addSubview:colorView];
    
    UIButton *toolBtn = [[UIButton alloc]init];
    
    toolBtn.frame = CGRectMake(0, 0, 80 , 40);
    toolBtn.layer.borderColor = [UIColor grayColor].CGColor;
    toolBtn.layer.borderWidth = 1;
    toolBtn.layer.cornerRadius = 2;
    toolBtn.tag = 1004;
    [toolBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [toolBtn setTitle:@"颜色调节" forState:UIControlStateNormal];
    [toolBtn addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [colorView addSubview:toolBtn];
    
    disPlayColorView = [[UIView alloc]initWithFrame:CGRectMake(80, 0, 50, 40)];
    
    [colorView addSubview:disPlayColorView];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    
    saveBtn.frame = CGRectMake(130, 0, 40 , 40);
    saveBtn.layer.borderColor = [UIColor grayColor].CGColor;
    saveBtn.layer.borderWidth = 1;
    saveBtn.layer.cornerRadius = 2;
    saveBtn.tag = 1004;
    [saveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    
    [colorView addSubview:saveBtn];
    
    
    
    [self addSubview:self.colorProgress];
    
}

#pragma mark把图片添加到相册
- (void)saveImage {
    
    UIGraphicsBeginImageContext(self.frame.size);
    //获取图像
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //对获取图片进行处理,删除顶部图片
    UIImage *newImage = [image cutImagewithRect:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-40)];
    
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    
    if (!error) {
        [MBProgressHUD showMessageToWindow:@"已保存到相册"];
    }
    
}

#pragma mark getter
/**颜色调节*/
- (CWLColorProgress *)colorProgress {
    
    if (!_colorProgress) {
        CWLColorProgress *pro = [CWLColorProgress nibView];
        
        pro.frame = CGRectMake(160, 40, 150, 150);
        
        [pro setChangeColor:^(float red, float green, float blue) {
            [disPlayColorView setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:1]];
            lineColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        }];
        _colorProgress = pro;
        _colorProgress.alpha = 0;
        _colorProgress.hidden = YES;
    }
    return _colorProgress;
}

/**线段数组*/
- (NSMutableArray *)lineArr
{
    if (!_lineArr) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        _lineArr = arr;
    }
    return _lineArr;
}

/**线宽数组*/
- (NSMutableArray *)lineWidthArr
{
    if (!_lineWidthArr) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        _lineWidthArr = arr;
    }
    return _lineWidthArr;
}

/**线段颜色数组*/
- (NSMutableArray *)lineColorArr
{
    if (!_lineColorArr) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        _lineColorArr = arr;
    }
    return _lineColorArr;
}

#pragma mark  action
/**按钮点击效果*/
- (void)toolClick:(UIButton *)sender {
    
    CWLToolType type = sender.tag;
    switch (type) {
        case CWLToolTypeLineWidthPlus:
        {
            if (lineWidth < maxLineWidth) {
                lineWidth ++;
            }
        }
            break;
        case CWLToolTypeLineWidthMin:
        {
            if (lineWidth > minLineWidth) {
                lineWidth --;
            }
        }
            break;
        case CWLToolTypeClear:
        {
            [self.lineArr removeAllObjects];
            [self.lineWidthArr removeAllObjects];
            [self.lineColorArr removeAllObjects];
            [self setNeedsDisplay];
        }
            break;
        case CWLToolTypeUndo:
        {
            [self.lineArr removeLastObject];
            [self.lineWidthArr removeLastObject];
            [self.lineColorArr removeLastObject];
            [self setNeedsDisplay];
        }
            break;
        case CWLToolTypeChangeColor:
        {
            [self showOrHideProgress];
        }
            break;
        default:
            break;
    }
}

/**
 *  隐藏或者显示颜色调节空间
 */
- (void)showOrHideProgress {
    [UIView beginAnimations:nil context:nil];
    
    if (self.colorProgress.hidden == YES) {
        self.colorProgress.alpha = 1;
        self.colorProgress.hidden = NO;
    }else {
        self.colorProgress.alpha = 0;
        self.colorProgress.hidden = YES;
    }
    
    
    [UIView commitAnimations];
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
//    简单画线
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 3);  //线宽
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, 0, 0);
//
//    CGContextAddLineToPoint(context, 50, 100);
//    CGContextAddLineToPoint(context, 51, 101);
//    
//    CGContextStrokePath(context);
    //画线
    [self drawLine:self.lineArr];
}


#pragma mark touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //初始化点数组
    self.pointArr = [[NSMutableArray alloc]init];
    //点数组添加第一个元素
    [self.pointArr addObject:[NSValue valueWithCGPoint:[touches.anyObject locationInView:self]]];
    //把当前线段加进线数组中
    [self.lineArr addObject:self.pointArr];
    [self.lineColorArr addObject:lineColor];
    [self.lineWidthArr addObject:@(lineWidth)];
    
    //判断是否在调节颜色
    if (self.colorProgress.hidden == NO) {
        [self showOrHideProgress];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //判断是否调节颜色
    if (self.colorProgress.hidden == YES) {
        //添加点
        [self.pointArr addObject:[NSValue valueWithCGPoint:[touches.anyObject locationInView:self]]];
        //重绘视图
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark绘制
- (void)drawLine:(NSArray *)line {
    //判断是否有线
    if (line.count>0) {
        
        //遍历线数组
        for (NSArray *pointArr in line) {
            //获取当前上下文对象
            CGContextRef context = UIGraphicsGetCurrentContext();
            //通道开始
            CGContextBeginPath(context);
            //线宽
            float width = [self.lineWidthArr[[line indexOfObject:pointArr]] floatValue];
            //线颜色
            UIColor *color = self.lineColorArr[[line indexOfObject:pointArr]];
            //设置线宽
            CGContextSetLineWidth(context, width);
            //设置线条颜色
            CGContextSetStrokeColorWithColor(context, color.CGColor);
            //获取起点
            CGPoint startPoint = [pointArr[0] CGPointValue];
            //移动到绘制点
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            //判断是否应该画线,并开始添加点
            if (pointArr.count>1) {
                for (int i=1; i<pointArr.count; i++) {
                    CGPoint linePoint = [pointArr[i] CGPointValue];
                    CGContextAddLineToPoint(context, linePoint.x, linePoint.y);
                }
            }
            //画线
            CGContextStrokePath(context);
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
