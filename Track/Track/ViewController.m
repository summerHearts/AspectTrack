//
//  ViewController.m
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import "ViewController.h"
#import "Tracker.h"
#import "MainHomeController.h"
static NSString *const viewWillAppear = @"viewWillAppear";

static NSString *const viewWillDisappear = @"viewWillDisappear";


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pushButton;
- (IBAction)pushAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[Tracker sharedInstance] addLog:[[LogData create]
                                      event:viewWillAppear]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[Tracker sharedInstance] addLog:[[LogData create]
                                      event:viewWillDisappear]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushAction:(id)sender {
    MainHomeController *mainHomeController = [[MainHomeController alloc]init];
    [self.navigationController pushViewController:mainHomeController animated:YES];
}
@end
