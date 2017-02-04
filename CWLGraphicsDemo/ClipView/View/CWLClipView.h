//
//  CWLClipView.h
//  CWLGraphicsDemo
//
//  Created by allen_Chan on 2017/2/3.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clipImageProtocol <NSObject>

- (void)clipImageInRect:(CGRect)rect;

@end

@interface CWLClipView : UIView

@property (nonatomic, assign) id<clipImageProtocol> clipDelegate;

@end
