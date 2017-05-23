//
//  QRCodeViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 30/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SGGenerateQRCodeVC.h"
#import "SGScanningQRCodeVC.h"
#import "SGAlertView.h"
#import <Photos/Photos.h>

@interface QRCodeViewController : UIViewController

@property(nonatomic,strong) AVCaptureDeviceInput *  input;

@property(nonatomic,strong) AVCaptureMetadataOutput *  output;

@property(nonatomic,strong) AVCaptureSession *  session;

@property(nonatomic,strong) AVCaptureVideoPreviewLayer *  layer;

@end
