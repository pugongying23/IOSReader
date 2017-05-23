//
//  BookworldCell.h
//  Aphrodite
//
//  Created by XuanLiang on 26/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookworldCell : UITableViewCell

@property(nonatomic,strong) UILabel *  bookName;

@property(nonatomic,strong) UILabel *  bookAuthor;

@property(nonatomic,strong) UILabel *  createdAt;

@property(nonatomic,strong) UIImageView *  bookCoverImg;

@end
