//
//  ViewController.m
//  IconMaker
//
//  Created by kangqijun on 15/3/5.
//  Copyright (c) 2015年 kangqijun. All rights reserved.
//

#import "ViewController.h"
#import "SecurityUtil.h"

@interface ViewController ()
{
    UIView *maskView;
    UIView *cornerView;
    UIButton *curBtn;
    UIButton *chooseBtn;
    
    CGPoint sPoint;
}

@property (strong, nonatomic) UIWebView   *bgWebView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bgWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.bgWebView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bgWebView];
    
    [self drawIcon];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (maskView == nil)
    {
        [self initMaskView];
    }
}

#pragma mark 画图标
- (void)drawIcon
{
//    [self creatColorGrayWithFrame:CGRectMake(20, 50, 100, 100) backgroundColor:@"CC9999" layerColor:@"FFFFCC"];
//    [self creatColorGrayWithFrame:CGRectMake(130, 50, 100, 100) backgroundColor:@"FFFFCC" layerColor:@"99CC33"];
//    [self creatColorGrayWithFrame:CGRectMake(20, 160, 100, 100) backgroundColor:@"99CC33" layerColor:@"FF9966"];
//    [self creatColorGrayWithFrame:CGRectMake(130, 160, 100, 100) backgroundColor:@"FF9966" layerColor:@"FF6666"];
//    [self creatColorGrayWithFrame:CGRectMake(75, 105, 100, 100) backgroundColor:@"FF6666" layerColor:@"CC9999"];
    
    [self creatColorGrayWithFrame:CGRectMake(130, 50, 100, 100) backgroundColor:@"CC3399" layerColor:@"0099CC"];
    [self creatColorGrayWithFrame:CGRectMake(130-27.5, 50+27.5, 100, 100) backgroundColor:@"0099CC" layerColor:@"99CC33"];
    [self creatColorGrayWithFrame:CGRectMake(130-55, 50+55, 100, 100) backgroundColor:@"99CC33" layerColor:@"FF9966"];
    [self creatColorGrayWithFrame:CGRectMake(130-82.5, 50+82.5, 100, 100) backgroundColor:@"FF9966" layerColor:@"FF6666"];
    [self creatColorGrayWithFrame:CGRectMake(130-110, 50+110, 100, 100) backgroundColor:@"FF6666" layerColor:@"CC3399"];
}

#pragma mark 创建色块
- (void)creatColorGrayWithFrame:(CGRect)frame backgroundColor:(NSString *)bColor layerColor:(NSString *)lColor
{
    UIView *aView = [[UIView alloc] initWithFrame:frame];
    aView.backgroundColor = [UIColor colorWithHex:bColor];
    [self.view addSubview:aView];
    aView.layer.cornerRadius = 10;
    
    aView.layer.shadowColor = [UIColor blackColor].CGColor;
    aView.layer.shadowOffset = CGSizeMake(5, 5);
    aView.layer.shadowOpacity = 0.6;//阴影透明度，默认0
    
    
    aView.alpha = 0.8;
//    aView.layer.shadowColor = [UIColor colorWithHex:lColor].CGColor;
//    aView.layer.shadowOffset = CGSizeMake(10, 10);
//    aView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//    aView.layer.shadowRadius = 4;//阴影半径，默认3
    
    /*
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = aView.bounds.size.width;
    float height = aView.bounds.size.height;
    float x = aView.bounds.origin.x;
    float y = aView.bounds.origin.y;
    float addWH = 10;
    
    CGPoint topLeft      = aView.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height+addWH);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];  
    //设置阴影路径  
    aView.layer.shadowPath = path.CGPath;
    */
}

#pragma mark 初始化遮罩
- (void)initMaskView
{
    //截屏区域
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 100)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    maskView.layer.borderColor = [UIColor whiteColor].CGColor;
    maskView.layer.borderWidth = 1.0;
    maskView.center = self.view.center;
    [self.view.window addSubview:maskView];
    
    curBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [curBtn addTarget:self action:@selector(curScreen) forControlEvents:UIControlEventTouchUpInside];
    curBtn.frame = CGRectMake(self.view.frame.size.width-60, 20, 60, 40);
    [curBtn setTitle:@"Cut" forState:UIControlStateNormal];
    [curBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view.window addSubview:curBtn];
    
    chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn addTarget:self action:@selector(choosePicture) forControlEvents:UIControlEventTouchUpInside];
    chooseBtn.frame = CGRectMake(0, 20, 100, 40);
    [chooseBtn setTitle:@"PhotosAlbum" forState:UIControlStateNormal];
    [chooseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view.window addSubview:chooseBtn];
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    //角标
    for (int i = 0; i < 4; i++)
    {
        UIView *lineHorizontalView = [[UIView alloc] initWithFrame:CGRectMake(i%2 * (maskView.frame.size.width-20), i/2 * (maskView.frame.size.height-5), 20, 5)];
        lineHorizontalView.backgroundColor = [UIColor redColor];
        [maskView addSubview:lineHorizontalView];
        
        UIView *lineVerticalView = [[UIView alloc] initWithFrame:CGRectMake(i%2 * (maskView.frame.size.width-5), i/2 * (maskView.frame.size.height-20), 5, 20)];
        lineVerticalView.backgroundColor = [UIColor redColor];
        [maskView addSubview:lineVerticalView];
        
        /*
         UIViewAutoresizingNone 默认是None，也就是当父视图的大小变动时，设置的子view不做任何适应操作
         UIViewAutoresizingFlexibleLeftMargin 视图靠右对齐
         UIViewAutoresizingFlexibleWidth 视图自适应宽度
         UIViewAutoresizingFlexibleRightMargin 视图靠左对齐
         UIViewAutoresizingFlexibleTopMargin 视图靠下对齐
         UIViewAutoresizingFlexibleHeight 视图自适应高度
         UIViewAutoresizingFlexibleBottomMargin 视图靠上对齐
         */
        
        //添加角标约束条件
        switch (i)
        {
            case 0:
            {
                lineHorizontalView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
                lineVerticalView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
                break;
            }
            case 1:
            {
                lineHorizontalView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
                lineVerticalView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
                break;
            }
            case 2:
            {
                lineHorizontalView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
                lineVerticalView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
                break;
            }
            case 3:
            {
                lineHorizontalView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
                lineVerticalView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
                
                lineHorizontalView.backgroundColor = [UIColor yellowColor];
                lineVerticalView.backgroundColor = [UIColor yellowColor];
                break;
            }
            default:
                break;
        }
    }
    
    //右下角标尺
    cornerView = [[UIView alloc] initWithFrame:CGRectMake(maskView.frame.origin.x+maskView.frame.size.width-40, maskView.frame.origin.y+maskView.frame.size.height-40, 40, 40)];
    cornerView.backgroundColor = [UIColor clearColor];
    [self.view.window addSubview:cornerView];
    
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
    roundView.backgroundColor = [UIColor redColor];
    roundView.layer.cornerRadius = 5;
    [cornerView addSubview:roundView];
    
    //角标拖动手势
    UIPanGestureRecognizer *cornerRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cornerhandlePanFrom:)];
    [cornerView addGestureRecognizer:cornerRecognizer];
    
    //遮罩拖动手势
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [maskView addGestureRecognizer:panRecognizer];
}

#pragma mark 截屏按钮事件
- (void)curScreen
{
//    maskView.frame = CGRectMake(0, 30, 250, 250);
    [self cutScreenPictureWith:maskView.frame];
}

#pragma mark 截屏方法
- (void)cutScreenPictureWith:(CGRect)rect
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
//    [img drawInRect:CGRectMake(1, 1, rect.size.width-2, rect.size.height-2)];
    
    UIImage *cutImage=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([img CGImage], rect)];
    
    NSData *data = UIImagePNGRepresentation(cutImage);
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filepath = [NSString stringWithFormat:@"%@/icon.png", documentsPath];
    
    [data writeToFile:filepath atomically:YES];
    
    [UIView animateWithDuration:0.1 animations:^{
        maskView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            maskView.alpha = 0.3;
        } completion:^(BOOL finished) {
            
            maskView.hidden = YES;
            cornerView.hidden = YES;
            
            curBtn.hidden = YES;
            chooseBtn.hidden = YES;
            
            ShowPicViewController *picVC = [[ShowPicViewController alloc] init];
            
            [self presentViewController:picVC animated:YES completion:^{
                
                [picVC loadImage:cutImage];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            }];
            
            [picVC setDismissBlk:^{
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                
                maskView.hidden = NO;
                cornerView.hidden = NO;
                
                curBtn.hidden = NO;
                chooseBtn.hidden = NO;
                
            }];
        }];
    }];
}

#pragma mark 选择相册图片
- (void)choosePicture
{
    maskView.hidden = YES;
    cornerView.hidden = YES;
    
    curBtn.hidden = YES;
    chooseBtn.hidden = YES;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark imagePickerController
//编码图片
- (NSString *)htmlForJPGImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    NSString *imageSource = [NSString stringWithFormat:@"data:image/jpg;base64,%@",[SecurityUtil encodeBase64Data:imageData]];
    return [NSString stringWithFormat:@"<img src = \"%@\" />", imageSource];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    maskView.hidden = NO;
    cornerView.hidden = NO;
    
    curBtn.hidden = NO;
    chooseBtn.hidden = NO;
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSString *stringImage = [self htmlForJPGImage:image];
    
    //构造内容
    NSString *contentImg = [NSString stringWithFormat:@"%@", stringImage];
    NSString *content =[NSString stringWithFormat:
                        @"<html>"
                        "<style type=\"text/css\">"
                        "<!--"
                        "body{font-size:40pt;line-height:60pt;}"
                        "-->"
                        "</style>"
                        "<body>"
                        "%@"
                        "</body>"
                        "</html>"
                        , contentImg];
    
    //让self.contentWebView加载content
    [self.bgWebView loadHTMLString:content baseURL:nil];
    
    if (image.size.width < self.view.frame.size.width && image.size.height < self.view.frame.size.height)
    {
        self.bgWebView.frame = CGRectMake(0, 0, image.size.width+20, image.size.height+20);
        self.bgWebView.center = self.view.center;
    }
    else if (image.size.width >= self.view.frame.size.width && image.size.height >= self.view.frame.size.height)
    {
       self. bgWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    else if (image.size.width > self.view.frame.size.width && image.size.height < self.view.frame.size.height)
    {
        self.bgWebView.frame = CGRectMake(0, (self.view.frame.size.height - image.size.height)/2, self.view.frame.size.width, image.size.height);
    }
    else if (image.size.width < self.view.frame.size.width && image.size.height > self.view.frame.size.height)
    {
        self.bgWebView.frame = CGRectMake((self.view.frame.size.width - image.size.width)/2, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    maskView.hidden = NO;
    cornerView.hidden = NO;
    
    curBtn.hidden = NO;
    chooseBtn.hidden = NO;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark 遮罩手势方法
-(void)handlePanFrom:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGPoint point = maskView.frame.origin;
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            sPoint = [gestureRecognizer locationInView:maskView];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint mPoint = [gestureRecognizer locationInView:self.view];
            
            CGRect rect = maskView.frame;
            rect.origin.x = mPoint.x - sPoint.x;
            rect.origin.y = mPoint.y - sPoint.y;
            maskView.frame = rect;
            
            CGRect corRect = cornerView.frame;
            corRect.origin.x += maskView.frame.origin.x - point.x;
            corRect.origin.y += maskView.frame.origin.y - point.y;
            cornerView.frame = corRect;
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [UIView animateWithDuration:0.1 animations:^{
                
                CGRect rect = maskView.frame;
                
                if (rect.origin.x < 0)
                {
                    rect.origin.x = 0;
                }
                else if (rect.origin.x + rect.size.width > self.view.frame.size.width)
                {
                    rect.origin.x = self.view.frame.size.width - rect.size.width;
                }
                
                if (rect.origin.y < 0)
                {
                    rect.origin.y = 0;
                }
                else if (rect.origin.y + rect.size.height > self.view.frame.size.height)
                {
                    rect.origin.y = self.view.frame.size.height - rect.size.height;
                }
                
                maskView.frame = rect;
                
                CGRect corRect = cornerView.frame;
                corRect.origin.x += maskView.frame.origin.x - point.x;
                corRect.origin.y += maskView.frame.origin.y - point.y;
                cornerView.frame = corRect;
                
            }];
            
            [UIView animateWithDuration:0.1 animations:^{
                
                CGRect corRect = cornerView.frame;
                corRect.origin.x = maskView.frame.origin.x + maskView.frame.size.width - corRect.size.width;
                corRect.origin.y = maskView.frame.origin.y + maskView.frame.size.height - corRect.size.height;
                cornerView.frame = corRect;
                
            }];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark 角标手势方法
- (void)cornerhandlePanFrom:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGPoint point = cornerView.frame.origin;
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            sPoint = [gestureRecognizer locationInView:cornerView];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint mPoint = [gestureRecognizer locationInView:self.view];
            
            CGRect rect = cornerView.frame;
            rect.origin.x = mPoint.x - sPoint.x;
            rect.origin.y = mPoint.y - sPoint.y;
            cornerView.frame = rect;
            
            [UIView animateWithDuration:0.1 animations:^{
                
                CGRect rect = maskView.frame;
                rect.size.width += cornerView.frame.origin.x - point.x;
                rect.size.height += cornerView.frame.origin.y - point.y;
                maskView.frame = rect;
            }];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            if (maskView.frame.size.width < 40)
            {
                [UIView animateWithDuration:0.1 animations:^{
                    
                    CGRect rect = maskView.frame;
                    rect.size.width = 40;
                    maskView.frame = rect;
                    
                    CGRect corRect = cornerView.frame;
                    corRect.origin.x = maskView.frame.origin.x + 5;
                    cornerView.frame = corRect;
                    
                }];
            }
            
            if (maskView.frame.size.height < 40)
            {
                [UIView animateWithDuration:0.1 animations:^{
                    
                    CGRect rect = maskView.frame;
                    rect.size.height = 40;
                    maskView.frame = rect;
                    
                    CGRect corRect = cornerView.frame;
                    corRect.origin.y = maskView.frame.origin.y + 5;
                    cornerView.frame = corRect;
                    
                }];
            }
            
            [UIView animateWithDuration:0.1 animations:^{
                
                CGRect rect = maskView.frame;
                
                if (rect.origin.x < 0)
                {
                    rect.origin.x = 0;
                }
                else if (rect.origin.x + rect.size.width > self.view.frame.size.width)
                {
                    rect.origin.x = self.view.frame.size.width - rect.size.width;
                }
                
                if (rect.origin.y < 0)
                {
                    rect.origin.y = 0;
                }
                else if (rect.origin.y + rect.size.height > self.view.frame.size.height)
                {
                    rect.origin.y = self.view.frame.size.height - rect.size.height;
                }
                
                if (rect.size.width > self.view.frame.size.width)
                {
                    rect.origin.x = 0;
                    rect.size.width = self.view.frame.size.width;
                }
                
                if (rect.size.height > self.view.frame.size.height)
                {
                    rect.origin.y = 0;
                    rect.size.height = self.view.frame.size.height;
                }
                
                maskView.frame = rect;
            }];
            
            [UIView animateWithDuration:0.1 animations:^{
                
                CGRect corRect = cornerView.frame;
                corRect.origin.x = maskView.frame.origin.x + maskView.frame.size.width - corRect.size.width;
                corRect.origin.y = maskView.frame.origin.y + maskView.frame.size.height - corRect.size.height;
                cornerView.frame = corRect;
                
            }];
            
            break;
        }
            
        default:
            break;
    }
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
