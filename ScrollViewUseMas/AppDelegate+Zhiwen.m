//
//  AppDelegate+Zhiwen.m
//  ScrollViewUseMas
//
//  Created by Macx on 2017/8/10.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import "AppDelegate+Zhiwen.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation AppDelegate (Zhiwen)
-(void)zhiwen
{
	if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
	  {
		[self evaluateAuthenticate];
	  }
}

-(void)evaluateAuthenticate
{
		//创建LAContext
	LAContext* context = [[LAContext alloc] init];
	NSError* error = nil;
	NSString* result = @"请验证已有指纹";
	
		//首先使用canEvaluatePolicy 判断设备支持状态
	if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
			//支持指纹验证
		[context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
			if (success) {
					//验证成功，主线程处理UI
			}
			else
			  {
				NSLog(@"%@",error.localizedDescription);
				switch (error.code) {
					case LAErrorSystemCancel:
				  {
						//系统取消授权，如其他APP切入
					break;
				  }
					case LAErrorUserCancel:
				  {
						//用户取消验证Touch ID
					break;
				  }
					case LAErrorAuthenticationFailed:
				  {
						//授权失败
					break;
				  }
					case LAErrorPasscodeNotSet:
				  {
						//系统未设置密码
					break;
				  }
					case LAErrorTouchIDNotAvailable:
				  {
						//设备Touch ID不可用，例如未打开
					break;
				  }
					case LAErrorTouchIDNotEnrolled:
				  {
						//设备Touch ID不可用，用户未录入
					break;
				  }
					case LAErrorUserFallback:
				  {
					[[NSOperationQueue mainQueue] addOperationWithBlock:^{
							//用户选择输入密码，切换主线程处理
					}];
					break;
				  }
					default:
				  {
					[[NSOperationQueue mainQueue] addOperationWithBlock:^{
							//其他情况，切换主线程处理
					}];
					break;
				  }
				}
			  }
		}];
	}
	else
	  {
			//不支持指纹识别，LOG出错误详情
		NSLog(@"不支持指纹识别");
		
		switch (error.code) {
			case LAErrorTouchIDNotEnrolled:
		  {
			NSLog(@"TouchID is not enrolled");
			break;
		  }
			case LAErrorPasscodeNotSet:
		  {
			NSLog(@"A passcode has not been set");
			break;
		  }
			default:
		  {
			NSLog(@"TouchID not available");
			break;
		  }
		}
		
		NSLog(@"%@",error.localizedDescription);
	  }
}

@end
