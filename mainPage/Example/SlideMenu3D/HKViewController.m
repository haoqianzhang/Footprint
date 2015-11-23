//
//  HKViewController.m
//  SlideMenu3D
//
//  Created by @hunk on 04/06/2015.
//  Copyright (c) 2014 @hunk. All rights reserved.
//

#import "HKViewController.h"
#import "HKAppDelegate.h"
#import "HKSubViewController.h"

@interface HKViewController ()

@end

@implementation HKViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    BOOL valuePan = [HKAppDelegate mainDelegate].slideMenuVC.enablePan;
    self.enablePanButton.enabled = !valuePan;
    self.disablePanButton.enabled = valuePan;
}

- (IBAction)menuAction:(id)sender {
    [[HKAppDelegate mainDelegate].slideMenuVC toggleMenu];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:239/255.0f green:239/255.0f  blue:239/255.0f alpha:1.0f];  //设置navigation bar背景色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:66.0 green:81.0 blue:94.0 alpha:0.5],UITextAttributeTextColor, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1],UITextAttributeTextShadowColor,[UIFont fontWithName:@"Marion-Italic" size:28.0],UITextAttributeFont,nil]];    //设置navigation bar title
    UIView *viewA = (UIView *)[self.view viewWithTag:1];
    UIView *viewB = (UIView *)[self.view viewWithTag:2];
    UIView *viewC = (UIView *)[self.view viewWithTag:3];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewA.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewA.bounds;
    maskLayer.path = maskPath.CGPath;
    viewA.layer.mask = maskLayer;
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:viewC.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = viewC.bounds;
    maskLayer2.path = maskPath2.CGPath;
    viewC.layer.mask = maskLayer2;
    UITextField *text = [self.view viewWithTag:4];
    text.layer.cornerRadius = 16.5;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSubviewAction:(UIButton *)sender {
    

    HKSubViewController *subVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SubViewController"];
    [self.navigationController pushViewController:subVC animated:YES];
}

- (IBAction)panAction:(UIButton *)sender {
    NSNumber *some = [NSNumber numberWithInteger:sender.tag];
    BOOL valuePan = [some boolValue];
    [[HKAppDelegate mainDelegate].slideMenuVC setEnablePan:valuePan];
    
    self.enablePanButton.enabled = !valuePan;
    self.disablePanButton.enabled = valuePan;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
#endif

- (BOOL)shouldAutorotate {
    return YES;
}


- (IBAction)toogleMenu:(UIButton *)sender {
    BOOL rightside = false;
    if ([sender.currentTitle isEqualToString:@"Menu in right side"]) {
        [sender setTitle:@"Menu in left side" forState:UIControlStateNormal];
        rightside = true;
    }else{
        [sender setTitle:@"Menu in right side" forState:UIControlStateNormal];
    }
    
    [[HKAppDelegate mainDelegate] toogleSideMenu:rightside];
}


@end
