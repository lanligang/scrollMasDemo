//
//  UIView+removeSubViews.m
//  ScrollViewUseMas
//
//  Created by Macx on 2017/8/8.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import "UIView+removeSubViews.h"

@implementation UIView (removeSubViews)

-(void)remove_subview
{
	for (UIView *v in self.subviews)
	{
	  [v removeFromSuperview];
	}
}

@end
