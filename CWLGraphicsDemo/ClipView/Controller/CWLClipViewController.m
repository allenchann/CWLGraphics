//
//  CWLClipViewController.m
//  CWLGraphics
//
//  Created by allen_Chan on 2017/1/24.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CWLClipViewController.h"
#import "CWLClipView.h"
#import "CWLClipResultViewController.h"

@interface CWLClipViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,clipImageProtocol>

{
    UIImageView *showImageView;
    float scale;
}

@end

@implementation CWLClipViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //在其他离开改页面的方法同样加上下面代码
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ClipView";
    showImageView = [[UIImageView alloc]init];
    showImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:showImageView];
    [showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    
    CWLClipView *view = [[CWLClipView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    view.clipDelegate = self;
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    UIBarButtonItem *chooseImageItem = [[UIBarButtonItem alloc]initWithTitle:@"选择图片" style:0 target:self action:@selector(chooseImage)];
    
    self.navigationItem.rightBarButtonItem = chooseImageItem;
}

- (void)clipImageInRect:(CGRect)rect {
    
    if (showImageView.image) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定选中图片?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CGRect clipRect = CGRectMake(rect.origin.x*scale, rect.origin.y*scale, rect.size.width*scale, rect.size.height*scale);
            CGImageRef imageRef = CGImageCreateWithImageInRect(showImageView.image.CGImage, clipRect);
            UIImage *clipImage = [UIImage imageWithCGImage:imageRef];
            
            NSDate *date        = [NSDate date];
            
            NSTimeZone *zone    = [NSTimeZone systemTimeZone];
            
            NSInteger interval  = [zone secondsFromGMTForDate:date];
            
            NSDate *adate       = [date  dateByAddingTimeInterval:interval];
            
            CGFloat width = rect.size.width/2/15 * scale;
            
            UIImage *timeImage  = [clipImage imageWithStringWaterMark:[[adate description] substringToIndex:19] inRect:CGRectMake(0, clipImage.size.height-width-5, clipImage.size.width, width+5) color:[UIColor orangeColor] font:[UIFont systemFontOfSize:width] andImage:nil andImageRect:CGRectZero];
            
            
            CWLClipResultViewController *con = [[CWLClipResultViewController alloc]initWithImage:timeImage imageSize:rect.size];
            [self.navigationController pushViewController:con animated:YES];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:photoAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
        [MBProgressHUD showMessageToWindow:@"请选择一张图片"];
    
    
    
}

- (void)chooseImage {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
//    [self presentViewController:picker animated:YES completion:nil];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"从相册获取或者拍照" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }
        else
            [MBProgressHUD showMessageToWindow:@"不支持相册调用"];
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }
        else
            [MBProgressHUD showMessageToWindow:@"无法调用相机"];
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    showImageView.image = info[@"UIImagePickerControllerOriginalImage"];
    scale = showImageView.image.size.width/self.view.frame.size.width;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
