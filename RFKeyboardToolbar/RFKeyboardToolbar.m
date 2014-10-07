//
//  RFKeyboardToolbar.m
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "RFKeyboardToolbar.h"
#import "RFToolbarButton.h"

@interface RFKeyboardToolbar () <UIInputViewAudioFeedback>

@property (nonatomic,strong) UIView *toolbarView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) CALayer *topBorder;
@property (nonatomic,strong) NSArray *buttonsToAdd;

@end

@implementation RFKeyboardToolbar

+ (instancetype)toolbarViewWithButtons:(NSArray *)buttons {
    return [[RFKeyboardToolbar alloc] initWithButtons:buttons];
}

- (id)initWithButtons:(NSArray*)buttons {
    self = [super initWithFrame:CGRectMake(0, 0, self.window.rootViewController.view.bounds.size.width, 48)];
    if (self) {
        _buttonsToAdd = buttons;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:[self inputAccessoryView]];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame = _toolbarView.bounds;
    frame.size.height = 0.5f;
    
    _topBorder.frame = frame;
}

- (UIView*)inputAccessoryView {
    _toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 48)];
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    _toolbarView.backgroundColor = version.floatValue >= 7.0f ? [UIColor colorWithRed:210.0f/256.0f green:213.0f/256.0f blue:219.0f/256.0f alpha:1.0f] :
                                                                [UIColor colorWithRed:143.0f/256.0f green:151.0f/256.0f blue:162.0f/256.0f alpha:1.0f];
    
    _toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    _topBorder = [CALayer layer];
    _topBorder.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.5f);
    _topBorder.backgroundColor = version.floatValue >= 7.0f ? [UIColor colorWithWhite:0.678 alpha:1.0].CGColor :
                                                              [UIColor colorWithWhite:0.378 alpha:1.0].CGColor;
    
    [_toolbarView.layer addSublayer:_topBorder];
    [_toolbarView addSubview:[self fakeToolbar]];
    
    return _toolbarView;
}

- (UIScrollView*)fakeToolbar {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 48)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentInset = UIEdgeInsetsMake(6.0f, 0.0f, 8.0f, 6.0f);
    
    NSUInteger index = 0;
    NSUInteger originX = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 3 : 7;
    
    CGRect originFrame;
    
    for (RFToolbarButton *eachButton in _buttonsToAdd) {
        originFrame = CGRectMake(originX, 0, eachButton.frame.size.width, eachButton.frame.size.height);
        eachButton.frame = originFrame;
        
        [_scrollView addSubview:eachButton];
        
        CGFloat gap = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 8.0 : 15.0;
        originX = originX + eachButton.bounds.size.width + gap;
        index++;
    }
    
    CGSize contentSize = _scrollView.contentSize;
    contentSize.width = originX - 8;
    _scrollView.contentSize = contentSize;
    
    return _scrollView;
}

- (BOOL)enableInputClicksWhenVisible {
    return self.tapSoundEnabled;
}

@end
