//
//  QRCodeViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 30/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =  BACKGROUNDCOLOR;
    self.navigationItem.title=@"扫描";
    [self QRCode];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = true;
}

#pragma 扫描二维码
-(void)QRCode{
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
            NSLog(@"因为系统原因, 无法访问相册");
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 照片 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
            [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
        } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                    
                }
            }];
        }
        
    } else {
        
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
        
    }

    
}



@end
