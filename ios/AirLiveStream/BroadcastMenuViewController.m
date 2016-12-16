//
//  BroadcastMenuViewController.m
//  AirLiveStream
//
//  Created by Adam Schlesinger on 12/13/16.
//  Copyright © 2016 Freshplanet, Inc. All rights reserved.
//

#import "BroadcastMenuViewController.h"

@interface BroadcastMenuViewController ()
@end

@implementation BroadcastMenuViewController

- (void)viewDidLoad {
    NSLog(@"AirLiveStream viewDidLoad");
    
    [super viewDidLoad];
    
    CGFloat buttonYPos = 0;
    
    buttonYPos = [self createMenuButton:@"liveBackground.png"
                           selStateFile:@"pausedBackground.png"
                    buttonClickSelector:@selector(liveButtonClicked:)
                                   yPos:buttonYPos];
    
    buttonYPos = [self createMenuButton:@"voice off.png"
                           selStateFile:@"voice on.png"
                    buttonClickSelector:@selector(muteButtonClicked:)
                                   yPos:buttonYPos];
    
    buttonYPos = [self createMenuButton:@"pause.png"
                           selStateFile:@"play.png"
                    buttonClickSelector:@selector(pauseButtonClicked:)
                                   yPos:buttonYPos];
    
    buttonYPos = [self createMenuButton:@"stop.png"
                           selStateFile:nil
                    buttonClickSelector:@selector(stopButtonClicked:)
                                   yPos:buttonYPos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat) createMenuButton:(NSString*)defStateFile
             selStateFile:(NSString*)selStateFile
      buttonClickSelector:(SEL)buttonClickSelector
                        yPos:(CGFloat)yPos {
    
    NSLog(@"AirLiveStream createMenuButton");
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage* defState = [UIImage imageWithContentsOfFile:defStateFile];
    [button setImage:defState forState:UIControlStateNormal];
    
    if (selStateFile) {
        
        UIImage* selState = [UIImage imageWithContentsOfFile:selStateFile];
        [button setImage:selState forState:UIControlStateSelected];
    }
    
    [button addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    [button addTarget:self action:@selector(buttonOut:) forControlEvents:UIControlEventTouchDragExit];
    [button addTarget:self action:@selector(buttonOut:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(buttonOut:) forControlEvents:UIControlEventTouchCancel];
    
    [button addTarget:self action:buttonClickSelector forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    //[button setFrame:CGRectMake(self.view.bounds.size.width - button.frame.size.width, yPos,
      //                          button.frame.size.width, button.frame.size.height)];
    
    return yPos + button.frame.size.height;
}

- (void) buttonDown:(UIButton*)button {
    NSLog(@"AirLiveStream buttonDown");
    
}

- (void) buttonOut:(UIButton*)button {
    NSLog(@"AirLiveStream buttonOut");
    
}

- (void) liveButtonClicked:(UIButton*)button {
    NSLog(@"AirLiveStream liveButtonClicked");
    
}

- (void) muteButtonClicked:(UIButton*)button {
    NSLog(@"AirLiveStream muteButtonClicked");
    
}

- (void) pauseButtonClicked:(UIButton*)button {
    NSLog(@"AirLiveStream pauseButtonClicked");
    
}

- (void) stopButtonClicked:(UIButton*)button {
    NSLog(@"AirLiveStream stopButtonClicked");
    
}

@end
