//
//  ShowPicViewController.m
//  IconMaker
//
//  Created by 康起军 on 15/3/7.
//  Copyright (c) 2015年 kangqijun. All rights reserved.
//

#import "ShowPicViewController.h"

@interface ShowPicViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ShowPicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.imageView];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.frame = CGRectMake(self.view.frame.size.width-100, 20, 100, 40);
    [saveBtn setTitle:@"Save to Album" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:saveBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(backToMainView) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 20, 80, 40);
    [cancelBtn setTitle:@"Back" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
}

- (void)loadImage:(UIImage *)image
{
    self.imageView.image = image;
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.imageView.center = self.view.center;
}

- (void)saveImage
{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);//保存图片到照片库
}

//保存回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    NSString *msg = @"";
    NSString *sure = @"";
    NSString *cancel = @"";
    
    NSInteger aTag = 0;
    
    if (!error)
    {
        msg = @"图片已保存到相册.";
        sure = @"确定";
        cancel = nil;
        
        aTag = 100;
    }
    else
    {
        msg = [NSString stringWithFormat:@"图片已保存失败，%@",error.domain];
        sure = @"再来一次";
        cancel = @"取消";
        
        aTag = 101;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:sure, nil];
    alertView.tag = aTag;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100)
    {
        [self backToMainView];
    }
    else
    {
        if (buttonIndex == 0)
        {
            [self backToMainView];
        }
        else
        {
            [self saveImage];
        }
    }
}

- (void)backToMainView
{
    self.dismissBlk();
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
