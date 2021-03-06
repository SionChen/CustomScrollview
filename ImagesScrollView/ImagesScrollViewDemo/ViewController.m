//
//  ViewController.m
//  ImagesScrollViewDemo
//
//  Created by 王博 on 15/6/24.
//  Copyright (c) 2015年 wangbo. All rights reserved.
//

#import "ViewController.h"
#import "ImagesScrollView.h"

@interface ViewController () <ImagesScrollViewDelegate>
{
    NSMutableArray * _images;
    NSMutableArray * _imageUrls;
}

@property (weak, nonatomic) IBOutlet ImagesScrollView *imagesScrollView; //在storyboard上创建的
@property (strong, nonatomic) ImagesScrollView *imagesScrollViewfromUrl; //用代码创建的

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _images = [NSMutableArray array];
    _imageUrls = [NSMutableArray array];
    for (NSInteger i = 0; i < 12; i++) {
        // 准备本地数据源
        NSString * imgName = [NSString stringWithFormat:@"background_0%02ld", i];
        NSString * imgPath = [[NSBundle mainBundle] pathForResource:imgName ofType:@"jpg"];
        UIImage * img = [UIImage imageWithContentsOfFile:imgPath];
        [_images addObject:img];
        
        // 准备远程数据源
        NSString * imgUrl = [NSString stringWithFormat:@"http://swkits.com/Images/background_0%02ld.jpg", i];
        [_imageUrls addObject:imgUrl];
    }
    
    [self.imagesScrollView reloadData];
    self.imagesScrollView.isLoop = YES;
    self.imagesScrollView.delegate = self;
    [self.imagesScrollView setImageViewContentMode:UIViewContentModeScaleAspectFill];
    self.imagesScrollView.autoScrollInterval = 2;
    
    self.imagesScrollViewfromUrl = [[ImagesScrollView alloc] initWithFrame:CGRectMake(0, 240, 320, 200)];
    [self.view addSubview:self.imagesScrollViewfromUrl];
    self.imagesScrollViewfromUrl.delegate = self;
    self.imagesScrollViewfromUrl.autoScrollInterval = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfImagesInImagesScrollView:(ImagesScrollView *)imagesScrollView
{
    if (self.imagesScrollView == imagesScrollView) {
        return _images.count;
    } else {
        return _imageUrls.count;
    }
}

- (UIImage *)imagesScrollView:(ImagesScrollView *)imagesScrollView imageWithIndex:(NSInteger)index
{
    if (self.imagesScrollView == imagesScrollView) {
        return _images[index];
    } else {
        return nil;
    }
}

- (NSString *)imagesScrollView:(ImagesScrollView *)imagesScrollView imageUrlStringWithIndex:(NSInteger)index
{
    if (self.imagesScrollViewfromUrl == imagesScrollView) {
        return _imageUrls[index];
    } else {
        return nil;
    }
}

- (void)imagesScrollView:(ImagesScrollView *)imagesScrollView didSelectIndex:(NSInteger)index
{
    NSLog(@"tap:%@ at:%ld", imagesScrollView, index);
}

- (void)imagesScrollView:(ImagesScrollView *)imagesScrollView didScrollToIndex:(NSInteger)index
{
    NSLog(@"%@ scrollToIndex:%ld",imagesScrollView , index);
}

@end
