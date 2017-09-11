//
//  LGScrollView.h
//  ScrollViewUseMas
//
//  Created by Macx on 2017/8/8.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGScrollView;

@protocol LgScrollViewdelegate <NSObject>

//总共有多少行
-(NSInteger )lgRowCountScrollView:(LGScrollView *)lgScrollView;

// 行高
-(CGFloat )lgScrollView:(LGScrollView *)lgScrollView andHeightForRow:(NSInteger)row;

//偏移量 都取正值 对应的是向内收缩 反之向外扩张

-(UIEdgeInsets  )lgEdgsScrollView:(LGScrollView *)lgScrollView forRow:(NSInteger)row;


//每行需要的View
-(UIView *)lgScrollView:(LGScrollView *)lgScrollView andViewForRow:(NSInteger )row;



@end

@interface LGScrollView : UIView

@property (nonatomic, strong,getter=getScrollView,readonly) UIScrollView		*scrollView;


- (instancetype)initWithDelegate:(id)delegate andSuperView:(UIView *)sv;

-(UIView *)registViewClass:(Class)className andRow:(NSInteger)row;

-(void)reloadData;



@end
