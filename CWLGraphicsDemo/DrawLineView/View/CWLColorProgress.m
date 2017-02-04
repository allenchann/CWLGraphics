//
//  CWLColorProgress.m
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CWLColorProgress.h"

@implementation CWLColorProgress
{
    float red;
    float green;
    float blue;
}

- (IBAction)RProgress:(UISlider *)sender {
    CWLColorProgressType type = sender.tag;
    
    switch (type) {
        case CWLColorProgressTypeRed:
            red = sender.value;
            break;
        case CWLColorProgressTypeGreen:
            green = sender.value;
            break;
        case CWLColorProgressTypeBlue:
            blue = sender.value;
            break;
        default:
            break;
    }
    
    self.changeColor(red,green,blue);
    
}

+ (instancetype)nibView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    return views.firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    red = 0;
    green = 0;
    blue = 0;
    self.rSlider.value = 0;
    self.gSlider.value = 0;
    self.bSlider.value = 0;
}

- (void)setProgress {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
