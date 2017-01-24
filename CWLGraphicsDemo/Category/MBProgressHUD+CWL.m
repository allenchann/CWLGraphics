//
//  MBProgressHUD+CWL.m
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/24.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MBProgressHUD+CWL.h"

@implementation MBProgressHUD (CWL)

+ (MBProgressHUD *)showMessageToWindow:(NSString *)message {
    UIView *window = [UIApplication sharedApplication].keyWindow;
    
    return [self showMessage:message inView:window];
}

+ (MBProgressHUD *)showMessage:(NSString *)message inView:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabel.text = message;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5];
    
    return HUD;
}

@end
