//
//  ShowPicViewController.h
//  IconMaker
//
//  Created by 康起军 on 15/3/7.
//  Copyright (c) 2015年 kangqijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPicViewController : UIViewController

- (void)loadImage:(UIImage *)image;

@property (copy) void (^ dismissBlk)();

@end
