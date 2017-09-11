//
//  LGScrollView.m
//  ScrollViewUseMas
//
//  Created by Macx on 2017/8/8.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import "LGScrollView.h"

#import "Masonry.h"

@interface LGScrollView ()
{
	UIScrollView * _scrollView;
	UIView       * _containtView;
	
}
@property (nonatomic, assign) id dataSource;
@property (nonatomic, assign) id delegate;

@property (nonatomic, assign) NSInteger lastCount;


@end


@implementation LGScrollView


- (instancetype)initWithDelegate:(id)delegate andSuperView:(UIView *)sv
{
	self = [super init];
	if (self)
	{
	  [sv addSubview:self];
	  
	  self.delegate = delegate;
	  
	  self.dataSource = delegate;
	  
	  _scrollView = [[UIScrollView alloc]init];
	  
	  _scrollView.backgroundColor = [UIColor whiteColor];
	  
	  _containtView = [[UIView alloc]init];
	  
	  _containtView.backgroundColor = [UIColor whiteColor];
	  
	  [_scrollView addSubview:_containtView];
	  
	  [self addSubview:self.scrollView];
	  
	  _lastCount = 0;
	  
	  [self addLayoutView];
	  
	}
	return self;
}


-(void)addLayoutView
{
	
	[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	
	[_containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(_scrollView);
		make.width.equalTo(_scrollView);
	}];
	
	
	NSInteger count = [self rowCount];
	
	_lastCount = count;
	
	UIView *lastView = nil;
	CGFloat lastBottom = 0.0f;
	
	for (int i = 0; i<count; i++)
	{
	  UIView *sbv = [self subVForRow:i];
	  
	  
	  if (sbv==nil)
	  {
		NSAssert(sbv, @"sbv is an view , it is must exise.");

		return;
	  }
	  
	  [_containtView addSubview:sbv];
	  
	  CGFloat rowHeight = [self rowHeiht:i];
	  
	  UIEdgeInsets edgs      = [self edgsForRow:i];
	  
	  CGFloat top    =  edgs.top;
	  CGFloat bottom =  edgs.bottom;
	  CGFloat left   = edgs.left;
	  CGFloat right  = edgs.right;
	  
	  sbv.layer.cornerRadius = 8.0f;
	  sbv.clipsToBounds = YES;
	  [sbv mas_makeConstraints:^(MASConstraintMaker *make) {
		  if (lastView)
		  {
			  make.top.equalTo(lastView.mas_bottom).offset(lastBottom+top);
		  }else{
			  make.top.equalTo(_containtView).offset(top);
		  }
		  make.left.mas_equalTo(left);
		  make.right.mas_equalTo(-right);
		  make.height.mas_equalTo(rowHeight);
	  }];
	  
	  
	  lastBottom =bottom;
	  lastView = sbv;
	  
	}
	[_containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(lastView).offset(lastBottom);
	}];
	
	
}

-(NSInteger)rowCount
{
	if ([self.dataSource respondsToSelector:@selector(lgRowCountScrollView:)])
	{
		NSInteger row = [self.dataSource lgRowCountScrollView:self];
		if (row==NSNotFound||row<0)
		{
			row = 0;
		}
		return row;
	}
	return 0;
}

-(CGFloat)rowHeiht:(NSInteger)row
{
	if ([self.dataSource respondsToSelector:@selector(lgScrollView:andHeightForRow:)])
	  {
		CGFloat rHeight = [self.dataSource lgScrollView:self andHeightForRow:row];
		
		return rHeight;
	  }
	return 0.0f;
}

-(UIEdgeInsets)edgsForRow:(NSInteger)row
{
	if ([self.dataSource respondsToSelector:@selector(lgEdgsScrollView:forRow:)])
	  {
		UIEdgeInsets edgs = [self.dataSource lgEdgsScrollView:self forRow:row];
		
		return edgs;
	  }
	return UIEdgeInsetsMake(0, 0, 0, 0);

}


-(UIView *)subVForRow:(NSInteger)row
{
	if ([self.dataSource respondsToSelector:@selector(lgScrollView:andViewForRow:)])
	  {
		
		UIView * view = [self.dataSource lgScrollView:self andViewForRow:row];
		
		return view;
	  }
	return nil;

}

-(UIView *)registViewClass:(Class)className andRow:(NSInteger)row
{
	UIView *view = [_containtView viewWithTag:row+100];
	
	if (view)
	{
	  return view;
	}
	view  = (UIView *)[[className alloc]init];
	[_containtView addSubview:view];
	view.tag = 100+row;
	return view;
}


-(void)reloadData
{
	//调用刷新的方法
	[self deleteNotUseView];
	[self resetlayout];
}


//删除多余部分
-(void)deleteNotUseView
{
	NSInteger count = [self rowCount];
	//修改的数量
    NSInteger changeNum  = 	_lastCount - count;
	
	if (changeNum>0)
	{
	  for (int i = 0; i<changeNum; i++)
	  {
		NSInteger vTag = count+i+100;
		UIView *view = [_containtView viewWithTag:vTag];
		[view removeFromSuperview];
	  }
	}
	
}

-(void)resetlayout
{
	NSInteger count = [self rowCount];
	
	UIView *lastView = nil;
	CGFloat lastBottom = 0.0f;
	
	for (int i = 0; i<count; i++)
	  {
		UIView *sbv = [self subVForRow:i];
		
		
		if (sbv==nil)
		  {
			NSAssert(sbv, @"sbv is an view , it is must exise.");
			
			return;
		  }

		if (i>=_lastCount)
		{
		  [_containtView addSubview:sbv];
		}
		
		CGFloat rowHeight = [self rowHeiht:i];
		
		UIEdgeInsets edgs      = [self edgsForRow:i];
		
		CGFloat top    =  edgs.top;
		CGFloat bottom =  edgs.bottom;
		CGFloat left   = edgs.left;
		CGFloat right  = edgs.right;
		
		if (i>=_lastCount) {
			
			[sbv mas_makeConstraints:^(MASConstraintMaker *make) {
				if (lastView)
				  {
					make.top.equalTo(lastView.mas_bottom).offset(lastBottom+top);
				  }else{
					  make.top.equalTo(_containtView).offset(top);
				  }
				make.left.mas_equalTo(left);
				make.right.mas_equalTo(-right);
				make.height.mas_equalTo(rowHeight);
			}];
			
		}else{
			[sbv mas_remakeConstraints:^(MASConstraintMaker *make) {
				if (lastView)
				  {
					make.top.equalTo(lastView.mas_bottom).offset(lastBottom+top);
				  }else{
					  make.top.equalTo(_containtView).offset(top);
				  }
				make.left.mas_equalTo(left);
				make.right.mas_equalTo(-right);
				make.height.mas_equalTo(rowHeight);
			}];
		}
		
		lastBottom =bottom;
		lastView = sbv;
		
	  }
	[UIView animateWithDuration:0.2 animations:^{
		[_containtView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.bottom.equalTo(lastView).offset(lastBottom);
		}];
		[_containtView layoutIfNeeded];
	}];

	_lastCount = count;

}

////////////

-(void)setDataSource:(id)dataSource
{
	_dataSource = dataSource;
}

-(void)setDelegate:(id)delegate
{
	_delegate = delegate;
}

////////////

-(UIScrollView *)getScrollView
{
	return _scrollView;
}


@end
