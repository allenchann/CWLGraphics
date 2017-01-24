//
//  CWLDrawLineView.h
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWLColorProgress.h"

/**工具状态*/
typedef NS_ENUM(NSUInteger, CWLToolType) {
    /**线条加宽*/
    CWLToolTypeLineWidthPlus = 1000,
    /**线条缩小*/
    CWLToolTypeLineWidthMin,
    /**清空画线*/
    CWLToolTypeClear,
    /**撤销上一条线*/
    CWLToolTypeUndo,
    /**改变颜色*/
    CWLToolTypeChangeColor
    
};

@interface CWLDrawLineView : UIView


/**存放每条线*/
@property (nonatomic, strong) NSMutableArray *lineArr;

/**存放一条线里所有点*/
@property (nonatomic, strong) NSMutableArray *pointArr;

/**存放线段宽度*/
@property (nonatomic, strong) NSMutableArray *lineWidthArr;

/**存放线段颜色*/
@property (nonatomic, strong) NSMutableArray *lineColorArr;

/**调节颜色*/
@property (nonatomic, strong) CWLColorProgress *colorProgress;


@end
