//
//  RDOnboardViewController.m
//  RiceDonate
//
//  Created by ozr on 15/8/5.
//  Copyright (c) 2015年 ricedonate. All rights reserved.
//

#import "RDOnboardViewController.h"
#import "RDOnboardContentViewController.h"
#import <UIColor+Expanded.h>


static CGFloat const kPageControlHeight = 25;
//static CGFloat const kSkipButtonWidth = 100;
//static CGFloat const kSkipButtonHeight = 44;
//static CGFloat const kBackgroundMaskAlpha = 0.6;
//static CGFloat const kDefaultBlurRadius = 20;
//static CGFloat const kDefaultSaturationDeltaFactor = 1.8;

@interface RDOnboardViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *topImages;
@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation RDOnboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self generateImages];
    
    RDOnboardContentViewController *vc1 =[[RDOnboardContentViewController alloc] initWithImage:self.topImages[0] skipCommand:nil];
    RDOnboardContentViewController *vc2 =[[RDOnboardContentViewController alloc] initWithImage:self.topImages[1] skipCommand:nil];
    RDOnboardContentViewController *vc3 =[[RDOnboardContentViewController alloc] initWithImage:self.topImages[2] skipCommand:nil];
    RDOnboardContentViewController *vc4 =[[RDOnboardContentViewController alloc] initWithImage:self.topImages[3] skipCommand:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }]];
    
    self.viewControllers = @[vc1, vc2, vc3, vc4];
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageViewController.view.frame = self.view.frame;
    pageViewController.view.backgroundColor = [UIColor whiteColor];
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    
    [pageViewController setViewControllers:@[vc1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController didMoveToParentViewController:self];
    self.pageViewController = pageViewController;
    
    UIPageControl *pageControl = [UIPageControl new];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithHexString:@"ff6600"]];
    [pageControl setPageIndicatorTintColor:[UIColor colorWithHexString:@"d7d8d9"]];
    pageControl.numberOfPages = self.viewControllers.count;
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    self.pageControl.frame = CGRectMake(0, self.view.bounds.size.height - kPageControlHeight, self.view.frame.size.width, 7);
    [self.view addSubview:self.pageControl];
    
}

#pragma mark - 

- (void)generateImages
{
    if (self.view.bounds.size.height <= 480) {
        UIImage *image0 = [UIImage imageNamed:@"onborad_4_top_first"];
        UIImage *image1 = [UIImage imageNamed:@"onborad_4_top_second"];
        UIImage *image2 = [UIImage imageNamed:@"onborad_4_top_third"];
        UIImage *image3 = [UIImage imageNamed:@"onborad_4_top_fourth"];
        self.topImages = @[image0, image1, image2, image3];
    }else if (self.view.bounds.size.height <= 1136/2)
    {
        UIImage *image0 = [UIImage imageNamed:@"onborad_5_top_first"];
        UIImage *image1 = [UIImage imageNamed:@"onborad_5_top_second"];
        UIImage *image2 = [UIImage imageNamed:@"onborad_5_top_third"];
        UIImage *image3 = [UIImage imageNamed:@"onborad_5_top_fourth"];
        self.topImages = @[image0, image1, image2, image3];
    }else
    {
        UIImage *image0 = [UIImage imageNamed:@"onborad_6_top_first"];
        UIImage *image1 = [UIImage imageNamed:@"onborad_6_top_second"];
        UIImage *image2 = [UIImage imageNamed:@"onborad_6_top_third"];
        UIImage *image3 = [UIImage imageNamed:@"onborad_6_top_fourth"];
        self.topImages = @[image0, image1, image2, image3];
    }
}

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    // return the previous view controller in the array unless we're at the beginning
    if (viewController == [self.viewControllers firstObject]) {
        return nil;
    }
    else {
        NSInteger priorPageIndex = [self.viewControllers indexOfObject:viewController] - 1;
        return self.viewControllers[priorPageIndex];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    // return the next view controller in the array unless we're at the end
    if (viewController == [self.viewControllers lastObject]) {
        return nil;
    }
    else {
        NSInteger nextPageIndex = [_viewControllers indexOfObject:viewController] + 1;
        return self.viewControllers[nextPageIndex];
    }
}


#pragma mark - Page view controller delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    // if we haven't completed animating yet, we don't want to do anything because it could be cancelled
    if (!completed) {
        return;
    }
    
    // get the view controller we are moving towards, then get the index, then set it as the current page
    // for the page control dots
    UIViewController *viewController = [pageViewController.viewControllers lastObject];
    NSInteger newIndex = [self.viewControllers indexOfObject:viewController];
    [self.pageControl setCurrentPage:newIndex];
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
