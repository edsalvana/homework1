//
//  MainViewController.m
//  homework1
//
//  Created by Ed Salvana on 2/15/14.
//  Copyright (c) 2014 Ed Salvana. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
//@property (weak, nonatomic) UIView *postContainerView; //if we want vars to be accessible throughout this file, define them here, seems like it should be strong instead of weak because they will be released immediately?
@property (strong, nonatomic) UITextField *inputText;
@property (strong, nonatomic) UIView   *composerViewContainer;

// Declare some methods that will be called when the keyboard is about to be shown or hidden
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
        
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    NSLog(@"view loaded");
    
    
    //set font and colors, these should be constants
    UIFont  *font1 = [UIFont boldSystemFontOfSize:14];
    UIFont  *font2 = [UIFont systemFontOfSize:12 ];
    UIFont  *font3 = [UIFont systemFontOfSize:14 ];
    UIColor *grey = [UIColor colorWithRed:147.0/255.0 green:147.0/255.0 blue:147.0/255.0 alpha:1.0];
    UIColor *lightGrey = [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0];
    UIColor *lightStrokeGrey     = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    UIColor *darkStrokeGrey      = [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0];
    UIColor *lightBackgroundGrey = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
  
    //main post container vars
    int postX       = 10;
    int postY       = 6;
    int postWidth   = 302;
    int postHeight  = 600;
    
    ///image vars
    int imageX      = -4;
    int imageWidth  = postWidth + (-imageX * 2);
    int imageHeight = 232;

    //create frames for ui elements
    CGRect postFrame  = CGRectMake(  postX,  postY,  postWidth,  postHeight  );
    CGRect imageFrame = CGRectMake(  imageX, 0, imageWidth, imageHeight );
    
    //MAIN VIEW CONTAINER ------------------------------------------------------------------------
    UIView *postContainerView               = [[UIView alloc] initWithFrame:postFrame];
    postContainerView.backgroundColor       = [UIColor whiteColor];
    postContainerView.layer.borderColor     = [UIColor colorWithRed:191.0/255.0 green:194.0/255.0 blue:199.0/255.0 alpha:1.0].CGColor;
    postContainerView.layer.borderWidth     = 0;
    postContainerView.layer.cornerRadius    = 2.0;
    postContainerView.layer.shadowColor     = [UIColor blackColor].CGColor;
    postContainerView.layer.shadowOffset    = CGSizeMake(0, 0);
    postContainerView.layer.shadowOpacity   = 0.05;
    postContainerView.layer.shadowRadius    = 4;
    
    //CREATE IMAGE ------------------------------------------------------------------------
    UIImage *postImage                      = [UIImage imageNamed:@"doge.jpg"];
    UIImageView *postImageView              = [[UIImageView alloc] initWithImage:postImage];
    postImageView.contentMode               = UIViewContentModeScaleAspectFill;
    postImageView.layer.shadowColor         = [UIColor blackColor].CGColor;
    postImageView.layer.shadowOffset        = CGSizeMake(0, 2);
    postImageView.layer.shadowOpacity       = 0.25;
    postImageView.layer.shadowRadius        = 4;
    postImageView.frame = imageFrame;
    postImageView.clipsToBounds = YES;
    
    //CREATE PROFILE IMAGE ------------------------------------------------------------------------
    UIImage *profileImage                   = [UIImage imageNamed:@"myPhoto.jpg"];
    UIImageView *profileImageView           = [[UIImageView alloc] initWithImage:profileImage];
    profileImageView.frame                  = CGRectMake( 10, 10, 34, 34 );
    profileImageView.contentMode            = UIViewContentModeScaleToFill;
    
    //CREATE PROFILE TEXT holy shit this took forever  --------------------------------------------
    UILabel *profileNameLabel   = [[UILabel alloc] init ];
    profileNameLabel.frame      = CGRectMake( profileImageView.frame.origin.x + profileImageView.frame.size.width + 10,
                                              profileImageView.frame.origin.y, 243, 34 );
    profileNameLabel.numberOfLines = 0;
    
    //create 2 string that we want to apply attributes to and set their attribs
    NSMutableAttributedString *postNameValue = [[NSMutableAttributedString alloc]initWithString:@"Ed Salvana\n"];
    NSMutableAttributedString *postTimeValue = [[NSMutableAttributedString alloc]initWithString:@"22 minutes ago near Dogeseville"];
    
    //apply attributes. i'm sure there's a shorter way to do this
    [postNameValue addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, postNameValue.length)];
    [postTimeValue addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, postTimeValue.length)];
    [postTimeValue addAttribute:NSForegroundColorAttributeName value:grey range:NSMakeRange(0, postTimeValue.length)];
    
    //concatenate strings, and then set the value of the label
    [postNameValue appendAttributedString:postTimeValue];
    profileNameLabel.attributedText = postNameValue;
    
    //CREATE POST TEXT ----------------------------------------------------------------------------
    UILabel *postText   = [[UILabel alloc] init ];
    postText.frame      = CGRectMake( profileImageView.frame.origin.x,
                                      profileImageView.frame.origin.y + profileImageView.frame.size.height + 15,
                                      postWidth - 20, 1 );
    postText.numberOfLines = 0;
    NSMutableAttributedString *postTextValue = [[NSMutableAttributedString alloc] initWithString:@"Lorem Ipsum is simply dummy text of the printing. cc: "];
    NSMutableAttributedString *postTextValueCC = [[NSMutableAttributedString alloc]initWithString:@"NyanCat"];
    [postTextValue addAttribute:NSFontAttributeName value:font3 range:NSMakeRange(0, postTextValue.length)];
    [postTextValueCC addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, postTextValueCC.length)];
    
    //concatenate strings, and then set the value of the label
    [postTextValue appendAttributedString:postTextValueCC];
    
    postText.attributedText = postTextValue;
    [postText sizeToFit];
    
    //update the post image based on height of text, this is not working when the
    postImageView.frame = CGRectMake(  imageX, postText.frame.origin.y + postText.frame.size.height + 15, imageWidth, imageHeight );
    
    //CREATE BUTTON CONTAINER ------------------------------------------------------------------------
    CGRect buttonContainerFrame = CGRectMake( 0, postImageView.frame.origin.y + postImageView.frame.size.height + 15, postWidth, 41 );
    UIView   *buttonContainer = [[UIView alloc] initWithFrame:buttonContainerFrame ];
    buttonContainer.layer.borderWidth     = 1;
    buttonContainer.layer.borderColor     = lightStrokeGrey.CGColor;
    buttonContainer.layer.backgroundColor = lightBackgroundGrey.CGColor;
    
    //CREATE BUTTONS ------------------------------------------------------------------------
    //can create function to format these
    UIImage  *likeImage     = [UIImage imageNamed:@"like.png"];
    UIButton *likeButton    = [UIButton buttonWithType:UIButtonTypeCustom]; //research how we do this with alloc
    [likeButton setImage:likeImage forState:UIControlStateNormal];
    [likeButton setTitle:@"Like"   forState:UIControlStateNormal];
    [likeButton setTitleColor:grey forState:UIControlStateNormal];
    likeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    likeButton.frame        = CGRectMake(0, 0, postWidth/3, 41);
    likeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0); //T,L,B,R ??
    
    UIImage  *commentImage      = [UIImage imageNamed:@"comment.png"];
    UIButton *commentButton     = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setImage:commentImage forState:UIControlStateNormal];
    [commentButton setTitle:@"Comment"   forState:UIControlStateNormal];
    [commentButton setTitleColor:grey    forState:UIControlStateNormal];
    commentButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    commentButton.frame        = CGRectMake(postWidth/3, 0, postWidth/3, 41);
    commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    UIImage  *shareImage        = [UIImage imageNamed:@"share.png"];
    UIButton *shareButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:shareImage forState:UIControlStateNormal];
    [shareButton setTitle:@"Share"   forState:UIControlStateNormal];
    [shareButton setTitleColor:grey  forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    shareButton.frame        = CGRectMake(postWidth/3 * 2, 0, postWidth/3, 41);
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    //add buttons to buttonContainer
    [buttonContainer addSubview:likeButton ];
    [buttonContainer addSubview:commentButton ];
    [buttonContainer addSubview:shareButton ];
    
    //CREATE COMPOSER ------------------------------------------------------------------------
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat tabBarHeight                = 44;
    CGFloat composerViewContainerHeight = 44;
    CGFloat navigationBarHeight         = 128/2; //is there a programmatic way to calculate this
    CGRect composerViewContainerFrame = CGRectMake( -1, screenHeight - tabBarHeight - composerViewContainerHeight - navigationBarHeight, 322, 44 );
    self.composerViewContainer = [[UIView alloc] initWithFrame:composerViewContainerFrame ];
    self.composerViewContainer.layer.borderWidth = 0.5;
    self.composerViewContainer.layer.borderColor     = darkStrokeGrey.CGColor;
    self.composerViewContainer.layer.backgroundColor = lightBackgroundGrey.CGColor;
    
    //camera button
    UIImage  *cameraImage     = [UIImage imageNamed:@"camera.png"];
    UIButton *cameraButton    = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    cameraButton.frame        = CGRectMake(0, 0, 44, 44 );
    
    //input textfield
    CGRect inputTextFrame = CGRectMake(cameraButton.frame.size.width, 6, 215, 44-12 );
    self.inputText = [[UITextField alloc] initWithFrame:inputTextFrame ];
    self.inputText.borderStyle = UITextBorderStyleRoundedRect;
    self.inputText.layer.borderWidth = 0.5;
    self.inputText.layer.borderColor = darkStrokeGrey.CGColor;
    self.inputText.layer.cornerRadius    = 4.0;
    self.inputText.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.inputText.placeholder = @"Write a comment...";
    
    //post button
    UIButton *postButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    [postButton setTitle:@"Post"   forState:UIControlStateNormal];
    [postButton setTitleColor:lightGrey  forState:UIControlStateNormal];
    postButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    postButton.frame        = CGRectMake(self.inputText.frame.origin.x + self.inputText.frame.size.width, 0, 64, 44);
    
    [self.composerViewContainer addSubview:postButton ];
    [self.composerViewContainer addSubview:self.inputText ];
    [self.composerViewContainer addSubview:cameraButton ];
    
    //ADD MOCK TAB BAR ------------------------------------------------------------------------
    UIImage *tabBarImage                   = [UIImage imageNamed:@"tabBar.png"];
    UIImageView *tabBarImageView           = [[UIImageView alloc] initWithImage:tabBarImage];
    tabBarImageView.frame                  = CGRectMake( 0, self.composerViewContainer.frame.origin.y +
                                                          self.composerViewContainer.frame.size.height,
                                                          320, 44 );
    
    //ATTACH VIEWS ------------------------------------------------------------------------
    [postContainerView addSubview:postText];
    [postContainerView addSubview:postImageView];
    [postContainerView addSubview:profileImageView ];
    [postContainerView addSubview:profileNameLabel ];
    [postContainerView addSubview:buttonContainer];
    [self.view         addSubview:postContainerView];
    [self.view         addSubview:self.composerViewContainer];
    [self.view         addSubview:tabBarImageView];
    
    //NAVIGATION BAR ------------------------------------------------------------------------
    [self.navigationItem setTitle:@"Post"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65.0/255.0 green:95.0/255.0 blue:156.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                    NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;  //set bar style to white
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    NSArray *actionButtonItems = @[shareItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(respondToTapGesture)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self.view addGestureRecognizer:tapRecognizer];
  
}

-(void)respondToTapGesture {
    NSLog(@"potato!");
    [self.view endEditing:YES];
}


-(void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.composerViewContainer.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.composerViewContainer.frame.size.height, self.composerViewContainer.frame.size.width, self.composerViewContainer.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat tabBarHeight                = 44;
    CGFloat composerViewContainerHeight = 44;
    CGFloat navigationBarHeight         = 128/2; //is there a programmatic way to calculate this
    
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.composerViewContainer.frame = CGRectMake( -1, screenHeight - tabBarHeight - composerViewContainerHeight - navigationBarHeight, 322, 44 );
                     }
                     completion:nil];
}


@end
