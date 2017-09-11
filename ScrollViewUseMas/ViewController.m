//
//  ViewController.m
//  ScrollViewUseMas
//
//  Created by Macx on 2017/8/6.
//  Copyright © 2017年 LLG. All rights reserved.
//



#import "MacroFile.h"


#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView		*scrollView;
@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	
     ADD_SV(self.scrollView)
	
	UIView *containtView = [UIView new];
	[self.scrollView addSubview:containtView];
	
	[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 350, 5));
	}];
	
	[containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(_scrollView);
		make.height.equalTo(_scrollView);
	}];
	
	int count = 100;
	
	UIView *lastView = nil;
	
	
	
	for (int i = 0; i<count; i++)
	{
		
	  UIView *subv = VIEW_CREACT

	  [containtView addSubview:subv];
	  
	  subv.backgroundColor =COLOR_RADOM

	  [subv mas_makeConstraints:^(MASConstraintMaker *make) {
		  make.top.and.bottom.equalTo(containtView);
		  make.width.mas_equalTo(@(20*i));
		  if ( lastView )
			{
			  make.left.mas_equalTo(lastView.mas_right);
			}
		  else
			{
			  make.left.mas_equalTo(0);
			}
	  }];
	  lastView = subv;
	}

	[containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		 make.right.equalTo(lastView.mas_right);
	}];
	
	
	UIScrollView *bottomScrollV = SCROLLV;
	
	ADD_SV(bottomScrollV);
	
	[bottomScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_scrollView.mas_bottom);
		make.left.equalTo(_scrollView.mas_left);
		make.right.equalTo(_scrollView.mas_right);
		make.bottom.mas_equalTo(0);
	}];
	
	UIView *bottmContaintV = VIEW_CREACT
	
	
	[bottomScrollV addSubview:bottmContaintV];
	
	[bottmContaintV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(bottomScrollV);
		make.width.equalTo(bottomScrollV.mas_width);
	}];
	
	
	UIView *bLastView = nil;
	
	for (int k = 0; k<20; k++)
	{
	  UIView *subv = [UIView new];
	  [bottmContaintV addSubview:subv];
	  subv.backgroundColor = COLOR_RADOM
	  
	  [subv mas_makeConstraints:^(MASConstraintMaker *make) {
		  make.left.equalTo(bottmContaintV.mas_left);
		  make.right.equalTo(bottmContaintV.mas_right);
		  make.height.mas_equalTo(@(20*k));
		  if (bLastView)
			{
			  make.top.mas_equalTo(bLastView.mas_bottom);
			}
		  else
			{
			  make.top.mas_equalTo(0);
			}
	  }];
	  bLastView = subv;

	}
	
	[bottmContaintV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(bLastView.mas_bottom);
	}];
	
	
	
}


-(UIScrollView *)scrollView
{
	if (!_scrollView)
	  {
		_scrollView = SCROLLV
	  }
	return _scrollView;
}




- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
