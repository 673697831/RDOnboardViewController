//
//  RDOnboardFourthViewController.h
//  RiceDonate
//
//  Created by ozr on 15/8/4.
//  Copyright (c) 2015年 ricedonate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

@interface RDOnboardContentViewController : UIViewController

@property (nonatomic, strong) UIImage *topImage;
@property (nonatomic, strong) RACCommand *skipCommand;

- (instancetype)initWithImage:(UIImage *)image
                  skipCommand:(RACCommand *)skipCommand;

@end
