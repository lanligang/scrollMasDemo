//
//  MacroFile.h
//  ScrollViewUseMas
//
//  Created by Macx on 2017/8/6.
//  Copyright © 2017年 LLG. All rights reserved.
//

#ifndef MacroFile_h
#define MacroFile_h

#if __OBJC__

#define ALETE_FIRST \
if (TARGET_IPHONE_SIMULATOR) {\
UIAlertView *alete = [[UIAlertView alloc]initWithTitle:@"指纹真机可现实出来" message:@"温馨提示" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alete show];\
}\


#define ScaleX  [UIScreen mainScreen].bounds.size.width/320.0f

#define ScaleY  [UIScreen mainScreen].bounds.size.height/480.0f


/**创建ScrollVIew*/
#define SCROLLV \
[[UIScrollView alloc]init];\


/**创建VIew*/
#define VIEW_CREACT \
[UIView new];\

/** 控制View添加子视图 */
#define ADD_SV(v)\
[self.view addSubview:v];\


/**随机颜色*/
#define COLOR_RADOM \
    [UIColor colorWithHue:\
	            ( arc4random() % 256 / 256.0)\
    saturation:(arc4random()%128 / 256.0)+0.5 \
    brightness:(arc4random()%128/ 256.0 ) + 0.5\
         alpha:1];\


#endif



#endif /* MacroFile_h */
