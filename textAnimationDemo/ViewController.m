//
//  ViewController.m
//  textAnimationDemo
//
//  Created by xuyanlan on 2017/12/6.
//  Copyright © 2017年 xuyanlan. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Path.h"
#import "AnimatedTextView.h"

@interface ViewController ()<UIScrollViewDelegate>
//case 1
@property(nonatomic,strong)AnimatedTextView *textView;

@end

static NSString *const testString = @"Just test a a  a a a 测试录音播放 hhhhh ，和我在成都的街头走一走 呜喔呜喔~~直到所有的灯都熄灭了也不停留\n,Just test a a  a a a 测试录音播放 hhhhh ，和我在成都的街头走一走 呜喔呜喔~~直到所有的灯都熄灭了也不停留";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCase2];

}
- (void)testCase2 {
    _textView = [AnimatedTextView new];
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont systemFontOfSize:20];
    _textView.frame = CGRectMake(0, 60, 150, 300);
    _textView.text = testString;
    [self.view addSubview:_textView];
    
    
    UIButton *testButton = [UIButton new];
    [testButton setFrame:CGRectMake(250, 300, 60, 40)];
    [testButton setTitle:@"测试" forState:UIControlStateNormal];
    [testButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}
- (void)buttonClick {
    int array[5] = {0,10,23,35,60};
    int index = arc4random()%4;
    int start = array[index];
    int end;
    if(index == 4){
        end = (_textView.text.length-1);
    }else{
        end = array[index + 1];
    }
    NSLog(@"start : %d, end : %d",start,end);
    [_textView highlightStart:start end:end];
}

@end
