//
//  CWLColorProgress.h
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CWLColorProgressType) {
    CWLColorProgressTypeRed = 2000,
    CWLColorProgressTypeGreen,
    CWLColorProgressTypeBlue,
};

@interface CWLColorProgress : UIView
@property (weak, nonatomic) IBOutlet UISlider *rSlider;
@property (weak, nonatomic) IBOutlet UISlider *gSlider;
@property (weak, nonatomic) IBOutlet UISlider *bSlider;

+ (instancetype)nibView;

@property (nonatomic, copy) void (^changeColor)(float red,float green,float blue);

@end
