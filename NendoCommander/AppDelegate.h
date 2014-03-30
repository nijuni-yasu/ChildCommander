//
//  AppDelegate.h
//  NendoCommander
//
//  Created by 安川 尚宏 on 2014/03/29.
//  Copyright (c) 2014年 Naohiro Yasukawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    NSString *whiteText;
    NSString *blackText;
    NSString *blueText;
    NSString *redText;
    NSString *grennText;
    
}

@property (nonatomic, retain) NSString *whiteText;
@property (nonatomic, retain) NSString *blackText;
@property (nonatomic, retain) NSString *blueText;
@property (nonatomic, retain) NSString *redText;
@property (nonatomic, retain) NSString *greenText;

@property (strong, nonatomic) UIWindow *window;

@end
