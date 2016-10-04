//
//  ViewController.m
//  KLRadarView
//
//  Created by kl on 16/10/4.
//  Copyright © 2016年 kl. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "RadarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    RadarView *radarView = [[RadarView alloc] initWithFrame:CGRectMake(0, 40, kWidth, 290)];
    radarView.backgroundColor = [UIColor whiteColor];
    radarView.dataArray = @[
                            @[
                                @{
                                    @"text" : @"label1",
                                    @"value" : @"0.2"
                                    },
                                @{
                                    @"text" : @"label2",
                                    @"value" : @"0.6"
                                    },
                                @{
                                    @"text" : @"label3",
                                    @"value" : @"0.8"
                                    },
                                @{
                                    @"text" : @"label4",
                                    @"value" : @"0.5"
                                    },
                                @{
                                    @"text" : @"label5",
                                    @"value" : @"0.4"
                                    }
                                ],
                            @[
                                @{
                                    @"text" : @"label1",
                                    @"value" : @"0.4"
                                    },
                                @{
                                    @"text" : @"label2",
                                    @"value" : @"0.8"
                                    },
                                @{
                                    @"text" : @"label3",
                                    @"value" : @"0.6"
                                    },
                                @{
                                    @"text" : @"label4",
                                    @"value" : @"0.6"
                                    },
                                @{
                                    @"text" : @"label5",
                                    @"value" : @"0.7"
                                    }
                                ]
                            ];
    radarView.rgbFloats = @[@[@29, @152, @255], @[@255, @55, @0]];
    [self.view addSubview:radarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
