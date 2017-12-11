//
//  NSString+Path.h
//  textAnimationDemo
//
//  Created by xuyanlan on 2017/12/11.
//  Copyright © 2017年 xuyanlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Path)

- (UIBezierPath*)bezierPathWithFont:(UIFont*)font;

@end
