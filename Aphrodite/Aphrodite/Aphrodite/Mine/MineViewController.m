//
//  MineViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "MineViewController.h"

@implementation MineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor  =  BACKGROUNDCOLOR;
    
    UIFont *  font = [UIFont fontWithName:MY_FONT_VALUE size:21];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: MY_FONT_COLOR };
    self.navigationController.navigationBar.titleTextAttributes =dic;
    self.navigationItem.title = @"我的";
    //头部的用户信息  点击事件  头像
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 60)*0.5, 80, 60, 60)];
    self.img.layer.cornerRadius = 20;
    self.img.layer.masksToBounds = true;
    self.img.image = [UIImage imageNamed:@"isIogin"];
    self.img.userInteractionEnabled=true;
    [self.view addSubview:self.img];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImg)];
    [self.img addGestureRecognizer:tap];
    //昵称
    self.loginLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, kScreenWidth-20, 40)];
    self.loginLab.textAlignment = NSTextAlignmentCenter;
    self.loginLab.text = @"登陆账号后可以获取更过信息";
    
    self.loginLab.font=[UIFont fontWithName:MY_FONT_VALUE size:16];
    [self.view addSubview:self.loginLab];
    
    self.arrText = [[NSArray alloc]initWithObjects:@"账户",@"修改密码",@"音乐",@"检查更新",@"关于", nil];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 210, kScreenWidth, 240)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    self.LoginOrLonout = [[UIButton alloc]initWithFrame:CGRectMake(10, kScreenHeight - 100, kScreenWidth-20, 40)];
    self.LoginOrLonout.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.LoginOrLonout setTitle:@"登陆" forState:UIControlStateNormal];
    [self.LoginOrLonout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.LoginOrLonout.backgroundColor =[UIColor redColor];
    self.LoginOrLonout.layer.cornerRadius = 10;
    self.LoginOrLonout.layer.masksToBounds = true;
    [self.LoginOrLonout addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.LoginOrLonout];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = false;
    
    self.loginLab.text = [localStorage getName];
    if ([localStorage IsLogin]) {
         [self.LoginOrLonout setTitle:@"注销" forState:UIControlStateNormal];
    }else{
         [self.LoginOrLonout setTitle:@"登陆" forState:UIControlStateNormal];
    }
    if ([localStorage IsLogin] && [localStorage IsChangeLogin]) {
        AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
        [query whereKey:@"userId" equalTo:[localStorage getUserId]];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count > 0) {
                self.obj = objects[0];
                self.loginLab.text=self.obj[@"userName"];
                [localStorage setValueByKey:self.obj[@"userName"] key:USER_NAME_KEY];
                AVFile * fileImg = self.obj[@"head"];
                NSURL * url = [NSURL URLWithString:fileImg.url];
                [self.img sd_setImageWithURL:url placeholderImage: [UIImage imageNamed:@"Coverimg"]];
            }
        }];
    }
}

#pragma 登陆
-(void)loginOut{
    
    if ([localStorage IsLogin]) {
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"0" forKey:USER_OLD_ID_KEY];
        [user setObject:@"0" forKey:USER_ID_KEY];
        [user setObject:@"登陆账号后可以获取更过信息" forKey:USER_NAME_KEY];
        [user synchronize];
        [AVUser logOut];
        [self.LoginOrLonout setTitle:@"登陆" forState:UIControlStateNormal];
    }else{
        LoginViewController * vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:true];

    }
}

#pragma tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrText.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [self.tableview  dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 80, 20)];
    lab.text = self.arrText[indexPath.row];
    lab.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    lab.textAlignment = NSTextAlignmentLeft;
    [cell addSubview:lab];
    return cell;
}

#pragma 账户,修改密码,音乐,检查更新,关于
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            if (self.obj!=nil && [localStorage IsLogin] && self.img.image!=nil) {
                if (self.vc==nil) {
                    self.vc = [[infoViewController alloc]init];
                }
                self.vc.image = self.img.image;
                self.vc.obj = self.obj;
                [self presentViewController:self.vc animated:true completion:^{}];
            }else{
                LKErrorBubble(@"稍等片刻", 1);
            }
        }
            break;
        case 1:{
            
        }
            break;
            
        case 2:{
            //音乐
            
        }
            break;
            
        case 3:{
            NSString * str = @"暂时没有更新";
            [self aboutAndUpdata:str];
        }
            break;
            
        case 4:{
            NSString * str =@"没有关于";
            [self aboutAndUpdata:str];
        }
            break;
    
        default:
            break;
    }
}
#pragma 检查更新,关于
-(void)aboutAndUpdata:(NSString *)str{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancer = [UIAlertAction actionWithTitle:@"了解" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancer];
    
    [self presentViewController:alert animated:true completion:^{
        
    }];
    
}

#pragma 更改头像
-(void)changeImg{
    if ([localStorage IsLogin]) {
        //相机
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择相册" message:@"相册或相机" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        //相册
        UIAlertAction * lib = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.imgPicker==nil) {
                self.imgPicker = [[UIImagePickerController alloc] init];
                self.imgPicker.delegate = self;
                self.imgPicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                self.imgPicker.allowsEditing = YES;
            }
            self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imgPicker animated:true completion:^{
                
            }];
        }];
        //取消
        UIAlertAction * cancer = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:photo];
        [alert addAction:lib];
        [alert addAction:cancer];
        [self presentViewController:alert animated:true completion:^{
            
        }];
    }else{
        LKErrorBubble(@"登陆", 1);
    }
}

#pragma  获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:true completion:^{
        self.img.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
        [query whereKey:@"userId" equalTo:[localStorage getUserId]];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count > 0) {
                NSData * data = UIImagePNGRepresentation( [info objectForKey:UIImagePickerControllerOriginalImage]);
                AVFile *file = [AVFile fileWithName:@"img.png" data:data];
                AVObject * obj = objects[0];
                [obj setObject:file forKey:@"head"];
                [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    
                }];
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
