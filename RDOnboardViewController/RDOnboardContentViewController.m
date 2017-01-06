//
//  RDOnboardFourthViewController.m
//  RiceDonate
//
//  Created by ozr on 15/8/4.
//  Copyright (c) 2015年 ricedonate. All rights reserved.
//

#import "RDOnboardContentViewController.h"
#import <Masonry.h>

@interface RDOnboardContentViewController ()

@property (nonatomic, weak) UIView *firstContainerView;
@property (nonatomic, weak) UIView *secondContainerView;
@property (nonatomic, weak) UIView *thirdContainerView;

@property (nonatomic, weak) UIImageView *topImageView;
@property (nonatomic, weak) UIButton *skipButton;

@end

@implementation RDOnboardContentViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *firstContainerView = [self firstContainerViewMaker];
    [self.view addSubview:firstContainerView];
    self.firstContainerView = firstContainerView;
    
    UIView *secondContainerView = [self secondContainerViewMaker];
    [self.view addSubview:secondContainerView];
    self.secondContainerView = secondContainerView;
    
    UIView *thirdContainerView = [self thirdContainerViewMaker];
    [self.view addSubview:thirdContainerView];
    self.thirdContainerView = thirdContainerView;
    
    
    [self.firstContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [self.secondContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstContainerView.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    [self.thirdContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@25);
        make.top.equalTo(self.secondContainerView.mas_bottom);
    }];
}

#pragma mark - maker

- (UIView *)firstContainerViewMaker
{
    UIView *firstContainerView = [UIView new];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.topImage];
    self.topImageView = imageView;
    [firstContainerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstContainerView).with.offset(30);
        make.centerX.equalTo(firstContainerView);
        make.bottom.equalTo(firstContainerView);
    }];
    
    
    return firstContainerView;
}

- (UIView *)secondContainerViewMaker
{
    UIView *secondContainerView = [UIView new];
    
    UIButton *button = [UIButton new];
    
    UIImage *image;
    
    if (self.view.bounds.size.height <= 480) {
        image = [UIImage imageNamed:@"onborad_4_bt_join"];
    }else if (self.view.bounds.size.height <= 1136/2)
    {
        image = [UIImage imageNamed:@"onborad_5_bt_join"];
    }else
    {
        image = [UIImage imageNamed:@"onborad_6_bt_join"];
    }
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [secondContainerView addSubview:button];
    self.skipButton = button;
    
    if (self.skipCommand) {
        button.rac_command = self.skipCommand;
    }else
    {
        button.hidden = YES;
    }
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(secondContainerView);
    }];
    
    return secondContainerView;
}

- (UIView *)thirdContainerViewMaker
{
    UIView *thirdContainerView = [UIView new];
    return thirdContainerView;
}

#pragma mark -

- (instancetype)initWithImage:(UIImage *)image skipCommand:(RACCommand *)skipCommand
{
    self = [self init];
    if (self) {
        _topImage = image;
        _skipCommand = skipCommand;
    }
    return self;
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
