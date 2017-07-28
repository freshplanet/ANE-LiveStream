/*
 * Copyright 2017 FreshPlanet
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
