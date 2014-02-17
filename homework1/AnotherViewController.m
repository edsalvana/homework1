//
//  AnotherViewController.m
//  homework1
//
//  Created by Ed Salvana on 2/17/14.
//  Copyright (c) 2014 Ed Salvana. All rights reserved.
//

#import "AnotherViewController.h"
#import "MainViewController.h"

@interface AnotherViewController ()

- (IBAction)goToNextView:(id)sender;
@end

@implementation AnotherViewController



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
    // Do any additional setup after loading the view from its nib.
    
    //Hack to hide the title
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleDone target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    [self.navigationItem setTitle:@"Homework #1"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65.0/255.0 green:95.0/255.0 blue:156.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;  //set bar style to white
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToNextView:(id)sender {
    
    MainViewController *nextView = [[MainViewController alloc] init];
    [self.navigationController pushViewController:nextView animated:YES];
}
@end
