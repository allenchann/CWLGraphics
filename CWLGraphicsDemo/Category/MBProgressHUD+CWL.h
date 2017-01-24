//
//  MBProgressHUD+CWL.h
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/24.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (CWL)

+ (MBProgressHUD *)showMessageToWindow:(NSString *)message;

+ (MBProgressHUD *)showMessage:(NSString *)message inView:(UIView *)view;

@end
