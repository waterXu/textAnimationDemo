//
//  AnimatedTextView.m
//  textAnimationDemo
//
//  Created by xuyanlan on 2017/12/11.
//  Copyright © 2017年 xuyanlan. All rights reserved.
//

#import "AnimatedTextView.h"
#define kHighlightColor [UIColor colorWithRed:67.0/255.0 green:132.0/255.0 blue:242.0/255.0 alpha:1]
#define kLayerFillColor [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1]

@implementation AnimatedTextView
{
    UITextView *_maskTextView;
    CAShapeLayer *_highlightLayer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.contentSize = CGSizeZero;
    self.userInteractionEnabled = YES;
    self.textColor = kLayerFillColor;
    _maskTextView = [UITextView new];
    _maskTextView.textColor = kHighlightColor;
    _maskTextView.userInteractionEnabled = NO;
    _maskTextView.backgroundColor = [UIColor clearColor];
    [self addSubview:_maskTextView];
    _highlightLayer = [CAShapeLayer layer];
    _highlightLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _highlightLayer.fillColor = kLayerFillColor.CGColor;//本来textview的颜色
    [_maskTextView.layer setMask:_highlightLayer];
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    _maskTextView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    _highlightLayer.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
}

- (void)setText:(NSString *)text {
    [super setText:text];
    _maskTextView.text = text;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _maskTextView.font = font;
}
- (void)highlightStart:(NSUInteger)start end:(NSUInteger)end
{
    [self clearHighlight];
    NSRange range = NSMakeRange(start, end - start + 1);
    self.selectedRange = range;
    UITextRange *textRange = self.selectedTextRange;
    NSArray *arrays =  [self selectionRectsForRange:textRange];
    CGFloat lineHeight = self.font.lineHeight;
    for (UITextSelectionRect *rect in arrays) {
        //        NSLog(@"rectX is :%f",rect.rect.origin.x);
        //        NSLog(@"rectY is :%f",rect.rect.origin.y);
        //        NSLog(@"rectW is :%f",rect.rect.size.width);
        //        NSLog(@"rectH is :%f",rect.rect.size.height);
        if(rect.containsEnd || rect.containsStart) {
            continue;
        }
        int line = rect.rect.size.height / lineHeight;
        for (int i = 0; i < line; i++)
        {//多行分别做动效
            CGFloat y = rect.rect.origin.y + (rect.rect.size.height/line) * i;
            CGRect layerRect = CGRectMake(rect.rect.origin.x, y, rect.rect.size.width, rect.rect.size.height/line);
            [self addSelectedLayerWithRect:layerRect];
        }
    }
}
- (void)addSelectedLayerWithRect:(CGRect)rect
{
    //添加一个上下的高亮的layer
    //如果是左右的动效的则需要把初始位置和最后的位置取出进行排序后再添加
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = _highlightLayer.bounds;
    layer.fillColor = kLayerFillColor.CGColor;
    [_highlightLayer addSublayer:layer];
    
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:rect];
    
#if 0
    UIBezierPath *fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 0)];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.5;
    basicAnimation.repeatCount = 1;
    basicAnimation.fromValue = (__bridge id)fromPath.CGPath;
    basicAnimation.toValue = (__bridge id)toPath.CGPath;
    [layer addAnimation:basicAnimation forKey:@"path"];
#else
    //透明动效
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation.duration = 0.5;
    basicAnimation.repeatCount = 1;
    basicAnimation.fromValue = @0.3;
    basicAnimation.toValue = @1;
    [layer addAnimation:basicAnimation forKey:@"opacity"];
    
#endif
    
    layer.path = toPath.CGPath;
}
- (void)clearHighlight
{
    self.selectedRange = NSMakeRange(0, 0);
    for (CAShapeLayer *layer in [_highlightLayer.sublayers copy]) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}
@end
