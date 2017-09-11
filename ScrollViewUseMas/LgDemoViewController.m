//
//  LgDemoViewController.m
//  ScrollViewUseMas
//
//  Created by Macx on 2017/8/8.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import "LgDemoViewController.h"
#import "LGScrollView.h"
#import "MacroFile.h"

#import "Masonry.h"

#import "UIView+removeSubViews.h"


@interface LgDemoViewController ()

{
	LGScrollView *_lgScrollV;
}

@property (nonatomic, assign) BOOL isReload;
@end

@implementation LgDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	_lgScrollV = [[LGScrollView alloc]initWithDelegate:self andSuperView:self.view];
	
	[_lgScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
	}];
   
}


	//总共有多少行
-(NSInteger )lgRowCountScrollView:(LGScrollView *)lgScrollView
{
	if (_isReload)
	{
		return 40;
	}
	return 30;
}

	// 行高
-(CGFloat )lgScrollView:(LGScrollView *)lgScrollView andHeightForRow:(NSInteger)row
{

	if (_isReload)
	{
	  return (80*row%3+(15^row)*2.0+60);
	}
		return (80*row%3+(15^row)*2.0+(row|60)*1.5+60);

}

	//便宜量 都去正值 对应的是向内收缩 反之向外扩张

-(UIEdgeInsets)lgEdgsScrollView:(LGScrollView *)lgScrollView forRow:(NSInteger)row
{
	CGFloat left = 0.0f;
	CGFloat right = 0.0f;
	CGFloat top = 0.0f;
	CGFloat bottom = 0.0f;

	if (row%2==0)
	  {
		left = 150;
		right = 50.0f;
		top = 15.0f;
		bottom = 15.0f;
	  }else{
		  left = 10;
		  right = 150.0f;
		  top = 3.0f;
		  bottom = 40.0f;
	  }
	if (_isReload)
	{
		return (UIEdgeInsets){5,5+20*cos(row)+80,5,5+20*cos(row)+80};
	}
	return (UIEdgeInsets){top,left,bottom,right};
}

//每行需要的View
-(UIView *)lgScrollView:(LGScrollView *)lgScrollView andViewForRow:(NSInteger )row
{
   UIView *view = 	[lgScrollView registViewClass:[UIView class] andRow:row];
	
	view.backgroundColor =[UIColor purpleColor];
	if (_isReload)
	{
		view.backgroundColor = COLOR_RADOM
	}
	//在这里可以添加子视图 并且可以用View 注意 使用的是alloc init  方法创建的View
	
	return view;
}

- (IBAction)reloadAction:(id)sender {
	_isReload=!_isReload;
	
	[_lgScrollV reloadData];
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
