//
//  RFToolbarButton.m
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "RFToolbarButton.h"

@interface RFToolbarButton ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) eventHandlerBlock buttonPressBlock;

@end

@implementation RFToolbarButton

+ (instancetype)buttonWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (id)initWithTitle:(NSString *)title {
    _title = title;
    return [self init];
}

- (id)init
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    UIFont *font = version.floatValue >= 7.0f ? [UIFont fontWithName:@"Helvetica-Light" size:28.0f] :
                                                [UIFont fontWithName:@"HelveticaNeue-Medium" size:26.0f];
    CGSize sizeOfText = version.floatValue >= 7.0f ? [self.title sizeWithAttributes:@{NSFontAttributeName:font}] :
                                                     [self.title sizeWithFont:font];
   
    UIImage *image = version.floatValue >= 7.0f ? [UIImage imageNamed:@"keyboard_button_iOS7.png"] : [UIImage imageNamed:@"keyboard_button_iOS6.png"];
    CGFloat inset = version.floatValue >= 7.0f ? 3 : 5;
    UIImage *buttonImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, inset, 0, inset)];
    
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        frame = CGRectMake(0, 0, sizeOfText.width > buttonImage.size.width ? sizeOfText.width + 3 : buttonImage.size.width, buttonImage.size.height);
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frame = CGRectMake(0, 0, 66, buttonImage.size.height);
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:self.title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.titleLabel.font = font;
        self.titleLabel.textColor = [UIColor colorWithWhite:0.500 alpha:1.0];
        
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 4, 0);
        
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        [self addTarget:self action:@selector(playTapSound) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent {
    self.buttonPressBlock = eventHandler;
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:controlEvent];
}

- (void)playTapSound {
    [[UIDevice currentDevice] playInputClick];
}

- (void)buttonPressed {
    self.buttonPressBlock();
}

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

@end
